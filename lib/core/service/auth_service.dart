import 'package:firebase_auth/firebase_auth.dart';

import '../error/auth_exeption_handler.dart';

class AuthService {
  static final instance = AuthService();
  final _auth = FirebaseAuth.instance;
  late AuthStatus _status;

  Future<AuthStatus> login({
    required String email,
    required String password,
  }) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<AuthStatus> createAccount({
    required String email,
    required String password,
    required String name,
  }) async {
    await _auth
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));
    _auth.currentUser!.updateDisplayName(name);
    return _status;
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    await _auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));
    return _status;
  }
}
