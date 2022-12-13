import 'package:firebase_auth/firebase_auth.dart';

import '../error/auth_exeption_handler.dart';
import '../models/response/customer_model.dart';
import 'database_service.dart';

class AuthService {
  static final instance = AuthService();
  final _auth = FirebaseAuth.instance;
  Customer? _customer;
  late AuthStatus _status;

  User? get currentUser => _auth.currentUser;
  Customer? get getCustomer => _customer;

  Future<AuthStatus> login({
    required String email,
    required String password,
  }) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    if (_status != AuthStatus.successful) return _status;
    _customer =
        await DatabaseService.instance.getCustomer(_auth.currentUser!.uid);
    return _status;
  }

  Future<void> logout() async {
    _customer = null;
    await _auth.signOut();
  }

  Stream<void> updateProfileImage(String path) {
    _customer!.photoUrl = path;
    return _auth.currentUser!.updatePhotoURL(path).asStream();
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

  Future<AuthStatus> changePassword(
      {required String newPassword, required currentPassword}) async {
    await currentUser!
        .reauthenticateWithCredential(EmailAuthProvider.credential(
      email: _customer!.email!,
      password: currentPassword,
    ));

    await currentUser!
        .updatePassword(newPassword)
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
