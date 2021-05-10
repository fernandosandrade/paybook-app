import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthService {
  Future<FirebaseUser> getUser();
  Future<FirebaseUser> signInWithGoogle();
  Future<FirebaseUser> signInWithEmailPassword({required String email, required String password});
  Future signInWithFacebook();
  Future<String> getToken();
  Future logout();
  Stream<FirebaseUser> get onAuthStateChanged;
  Future<AuthResult> createUser({required String email, required String password});
}

class AuthService implements IAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    return user;
  }

  @override
  Future<FirebaseUser> signInWithEmailPassword({required String email, required String password}) async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user;
  }

  @override
  Future signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  Future<FirebaseUser> getUser() {
    return _auth.currentUser();
  }

  @override
  Future logout() {
    return _auth.signOut();
  }

  @override
  Future<String> getToken() {
    throw UnimplementedError();
  }

  @override
  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  @override
  Future<AuthResult> createUser({required String email, required String password}) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}
