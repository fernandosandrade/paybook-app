import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:paybook_app/globals/enum_form_action.dart';

import '../../../../data/models/cobranca_101_model.dart';
import '../../../../data/models/destinatario.dart';
import '../../../../data/repositories/cobranca_simples_repository.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/id_generator.dart';
import '../../enum_status_cobranca.dart';
import '../book_simples_list_controller.dart';

class CobrancaSimplesFormController extends GetxController {
  BookSimplesListController bookController = Get.find();
  final ICobrancaSimplesRepository cobrancaSimplesRepository;
  final _formKey = GlobalKey<FormState>();
  final formatter = NumberFormat("#,##0.00", "pt_BR");
  final tituloForm = ''.obs;

  Cobranca101Model _cobrancaSimplesModel;

  var formAction = EnumFormAction.INDEFINIDA.obs;
  var isInAsyncCall = false.obs;

// setado no onSave do campo de valor
  double valor;
  var destinatario = Destinatario().obs;
  var dataVencimento = DateTime.now().obs;

  DateTime dpInitialDate = DateTime.now();

  // data original. usada apenas na alteracao.
  DateTime dataVencimentoOriginal;

  var valorController = TextEditingController();
  var vencimentoController = TextEditingController();
  var editorDiasVencimentoController = TextEditingController(text: '0');

  RxList<bool> toggleVencimentos = List<bool>.of([false, false, false]).obs;
  Map<int, Text> vencimentos = Map.of({7: Text("7"), 14: Text("14"), 30: Text("30")});

  CobrancaSimplesFormController({@required this.cobrancaSimplesRepository});

  @override
  onInit() {
    Get.parameters.containsKey('id_cobranca')
        ? _initFormAlterar(Get.parameters['id_cobranca'])
        : _initFormIncluir();
  }

  get formKey => this._formKey;

  /// altera o toggle de vencimento com base no index de [vencimentos] passado
  /// a partir do index eh identificado o prazo selecionado, e uma nova data eh atribuia a [dataVencimento]
  void changeToggleVencimento(int index, {DateTime dataBase}) {
    for (int buttonIndex = 0; buttonIndex < toggleVencimentos.length; buttonIndex++) {
      buttonIndex == index
          ? toggleVencimentos[buttonIndex] = true
          : toggleVencimentos[buttonIndex] = false;
    }
    int prazo = index >= 0 ? vencimentos.entries.elementAt(index).key : 0;

    dataVencimento.value = dataBase == null
        ? DateTime.now().add(Duration(days: prazo))
        : dataBase.add(Duration(days: prazo));
  }

  /// seta uma data especifica para o vencimento.
  /// ao faze-lo, todas as opcoes do toggle sao desmarcadas.
  void setDataVencimento(DateTime data) {
    this.dataVencimento.value = data;
    for (int buttonIndex = 0; buttonIndex < toggleVencimentos.length; buttonIndex++)
      toggleVencimentos[buttonIndex] = false;
  }

  /// altera a data de vencimento atual, adicionando ou removendo dias.
  ///
  /// na remocao, apenas efetiva se a data resultante nao for inferior a Datetime.now()
  void changeDataVencimento({int addDias, int removeDias}) {
    //int dias = int.parse(this.editorDiasVencimentoController.text);
    if (addDias != null) {
      this.dataVencimento.value = this.dataVencimento.value.add(Duration(days: 1));
    }
    if (removeDias != null &&
        this.dataVencimento.value.subtract(Duration(days: 1)).isAfter(DateTime.now())) {
      this.dataVencimento.value = this.dataVencimento.value.subtract(Duration(days: 1));
    }
  }

  Future salvarCobranca() async {
    var cobranca;
    if (formAction.value == EnumFormAction.INCLUIR) {
      cobranca = Cobranca101Model(
          idCobranca: newCobrancaId(),
          idBook: this.bookController.bookSimplesModel.idBook,
          valor: this.valor,
          destinatario: this.destinatario.value,
          dtCriacao: DateTime.now(),
          dtVencimento: this.dataVencimento.value,
          status: EnumStatusCobranca.PENDENTE.toString());
    } else if (formAction.value == EnumFormAction.ALTERAR) {
      this._cobrancaSimplesModel.valor = this.valor;
      this._cobrancaSimplesModel.destinatario = this.destinatario.value;
      this._cobrancaSimplesModel.dtVencimento = this.dataVencimento.value;
      cobranca = this._cobrancaSimplesModel;
    }
    await save(cobranca);
  }

  Future save(Cobranca101Model model) async {
    await cobrancaSimplesRepository.save(model);
  }

  void delete(Cobranca101Model model) {
    cobrancaSimplesRepository.delete(model);
  }

  String newCobrancaId() {
    return IdGenerator.randomAlphanumeric();
  }

  _initFormIncluir() {
    formAction.value = EnumFormAction.INCLUIR;
    this.isInAsyncCall.value = false;
    this.tituloForm.value = 'nova cobrança simples';
    changeToggleVencimento(0);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    this.valorController.text = "R\$ " + formatter.format(0);
  }

  _initFormAlterar(String idCobranca) {
    formAction.value = EnumFormAction.ALTERAR;
    this.isInAsyncCall.value = true;
    this.tituloForm.value = 'alterar cobrança simples';
    ever(dataVencimento, (novaData) {
      this.editorDiasVencimentoController.text =
          novaData.difference(dataVencimentoOriginal).inDays.toString();
    });
    cobrancaSimplesRepository.getByIdCobranca(idCobranca).then((cobrancaModel) {
      this._cobrancaSimplesModel = cobrancaModel;

      final formatter = NumberFormat("#,##0.00", "pt_BR");
      this.valorController.text = "R\$ " + formatter.format(cobrancaModel.valor);
      this.destinatario.value = cobrancaModel.destinatario;
      this.dataVencimento.value = cobrancaModel.dtVencimento;
      this.dataVencimentoOriginal = cobrancaModel.dtVencimento;
      this.dpInitialDate = cobrancaModel.dtVencimento;
    }).whenComplete(() => this.isInAsyncCall.value = false);
  }

  editarDestinatario() async {
    var args = '';
    if (formAction.value == EnumFormAction.ALTERAR) {
      args = '?nome=' +
          this.destinatario.value.nome +
          '&telefone=' +
          this.destinatario.value.telefone +
          '&email=' +
          this.destinatario.value.email;
    }
    var contato = await Get.toNamed(AppRoutes.DESTINATARIO + args);
    if (contato != null) this.destinatario.value = contato;
  }
}
