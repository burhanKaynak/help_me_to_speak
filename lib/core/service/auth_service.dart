import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_me_to_speak/core/models/response/customer_model.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';

import '../error/auth_exeption_handler.dart';

class AuthService {
  static final instance = AuthService();
  final _auth = FirebaseAuth.instance;
  Customer? _customer;
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

    _customer =
        await DatabaseService.instance.getCustomer(_auth.currentUser!.uid);
    return _status;
  }

  Future<void> logout() async {
    _customer = null;
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
        .then((value) async {
      _status = AuthStatus.successful;
    }).catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
    await _auth.currentUser!.updateDisplayName(name);
    await DatabaseService.instance.register(user: _auth.currentUser!);
    _customer =
        await DatabaseService.instance.getCustomer(_auth.currentUser!.uid);
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

  Future<AuthStatus> sendMailVerification() {
    _auth.currentUser!
        .sendEmailVerification()
        .then((value) => _status = AuthStatus.successful)
        .catchError((e) {
      _status = AuthExceptionHandler.handleAuthException(e);
    });
    return Future<AuthStatus>.value(_status);
  }

  Future<bool> checkEmailVerified() async {
    await _auth.currentUser!.reload();
    return _auth.currentUser!.emailVerified;
  }

  User? get currentUser => _auth.currentUser;

  Customer? get getCustomer => _customer;
  Future<bool> setCustomer() async {
    if (_auth.currentUser != null) {
      _customer =
          await DatabaseService.instance.getCustomer(_auth.currentUser!.uid);
    } else {
      return false;
    }
    return true;
  }
}
