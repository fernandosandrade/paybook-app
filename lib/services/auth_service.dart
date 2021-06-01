import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthService {
  User? getUser();
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailPassword({required String email, required String password});
  Future signInWithFacebook();
  Future<String> getToken();
  Future logout();
  Stream<User?> get onAuthStateChanged;
  Future<UserCredential> createUser({required String email, required String password});
}

class AuthService implements IAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = (await _googleSignIn.signIn())!;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User user = (await _auth.signInWithCredential(credential)).user!;
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    return user;
  }

  @override
  Future<User> signInWithEmailPassword({required String email, required String password}) async {
    final User user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user!;
    return user;
  }

  @override
  Future signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  User? getUser() {
    return _auth.currentUser;
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
  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  @override
  Future<UserCredential> createUser({required String email, required String password}) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}
