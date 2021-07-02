import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:paybook_app/data/models/charge/charge_111_model.dart';
import 'package:paybook_app/data/models/destinatario.dart';
import 'package:paybook_app/globals/enum_form_action.dart';
import 'package:paybook_app/routes/app_pages.dart';
import 'package:paybook_app/services/cobranca_service.dart';
import 'package:paybook_app/services/enum_cobranca_status.dart';
import 'package:paybook_app/utils/id_generator.dart';

class Charge111FormController extends GetxController {
  final log = Logger('Charge111FormController');
  final ICobrancaService<Charge111Model> cobrancaService;
  final String bookID;
  final _formKey = GlobalKey<FormState>();
  final isInAsyncCall = false.obs;

  final valorController = TextEditingController();
  final vencimentoController = TextEditingController();
  final editorDiasVencimentoController = TextEditingController(text: '0');

  final formatter = NumberFormat("#,##0.00", "pt_BR");
  final toggleVencimentos = [false, false, false].obs;
  final vencimentos = Map.of({7: Text("7"), 14: Text("14"), 30: Text("30")});

  late String tituloForm;

  // defines if is create or edit
  late EnumFormAction formAction;

  Charge111Model? _charge111Model;
  double? valor;
  final destinatario = Rxn<Destinatario>();
  var dataVencimento = DateTime.now().obs;
  DateTime dpInitialDate = DateTime.now();

  // data original. usada apenas na alteracao.
  DateTime? dataVencimentoOriginal;

  Charge111FormController(
      {required this.cobrancaService, required this.bookID, Charge111Model? chargeToEdit})
      : this._charge111Model = chargeToEdit {
    this._charge111Model == null ? _initFormIncluir() : _initFormAlterar(this._charge111Model!);
  }

  @override
  onInit() {
    super.onInit();
    // this._charge111Model == null ? _initFormIncluir() : _initFormAlterar(this._charge111Model!);
    // Get.parameters.containsKey('id_cobranca')
    //     ? _initFormAlterar(Get.parameters['id_cobranca'])
    //     : _initFormIncluir();
  }

  get formKey => this._formKey;

  /// altera o toggle de vencimento com base no index de [vencimentos] passado
  /// a partir do index eh identificado o prazo selecionado, e uma nova data eh atribuia a [dataVencimento]
  void changeToggleVencimento(int index, {DateTime? dataBase}) {
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
  void changeDataVencimento({int? addDias, int? removeDias}) {
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
    if (formAction == EnumFormAction.INCLUIR) {
      Charge111Model((s) => s
        ..id = newCobrancaId()
        ..idBook = bookID
        ..valor = this.valor
        ..destinatario = this.destinatario.value!.toBuilder()
        ..dtCriacao = DateTime.now()
        ..dtVencimento = this.dataVencimento.value
        ..status = EnumCobrancaStatus.waiting_payment);
    } else if (formAction == EnumFormAction.ALTERAR) {
      this._charge111Model!.rebuild((b) => b
        ..valor = this.valor
        ..destinatario = this.destinatario.value!.toBuilder()
        ..dtVencimento = this.dataVencimento.value);
      cobranca = this._charge111Model;
    }
    await save(cobranca);
  }

  Future save(Charge111Model model) async {
    this.isInAsyncCall.value = true;
    await cobrancaService.save(model);
    this.isInAsyncCall.value = false;
  }

  void delete(Charge111Model model) {
    cobrancaService.delete(model);
  }

  String newCobrancaId() {
    return IdGenerator.randomAlphanumeric();
  }

  _initFormIncluir() {
    formAction = EnumFormAction.INCLUIR;
    this.tituloForm = 'nova cobrança simples';
    changeToggleVencimento(0);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    this.valorController.text = "R\$ " + formatter.format(0);
  }

  _initFormAlterar(Charge111Model cobrancaModel) {
    formAction = EnumFormAction.ALTERAR;
    this.tituloForm = 'alterar cobrança simples';
    ever<DateTime>(dataVencimento, (novaData) {
      if (dataVencimentoOriginal != null)
        this.editorDiasVencimentoController.text =
            novaData.difference(dataVencimentoOriginal!).inDays.toString();
    });
    // cobrancaService.findById(idCobranca).then((cobrancaModel) {
    //   if (cobrancaModel != null) {
    //     this._charge111Model = cobrancaModel;

    final formatter = NumberFormat("#,##0.00", "pt_BR");
    this.valorController.text = "R\$ " + formatter.format(cobrancaModel.valor);
    this.destinatario.value = cobrancaModel.destinatario;
    this.dataVencimento.value = cobrancaModel.dtVencimento;
    this.dataVencimentoOriginal = cobrancaModel.dtVencimento;
    this.dpInitialDate = cobrancaModel.dtVencimento;
    //   } else
    //     log.warning('_initFormAlterar: no charge was found for $idCobranca');
    // }).whenComplete(() => this.isInAsyncCall.value = false);
  }

  editarDestinatario() async {
    var args = '';
    if (formAction == EnumFormAction.ALTERAR) {
      var destinatario = this.destinatario.value!;
      args = '?nome=' +
          destinatario.nome +
          '&telefone=' +
          destinatario.telefone +
          '&email=' +
          destinatario.email;
    }
    var contato = await Get.toNamed(AppRoutes.destinatario + args);
    if (contato != null) this.destinatario.value = contato;
  }
}
