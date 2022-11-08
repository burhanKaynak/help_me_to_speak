import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';

class DatabaseService {
  static final instance = DatabaseService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> addUserToDocuments({required User user}) async {
    var status = false;
    await _db
        .collection('users')
        .doc(user.uid)
        .set({'email': user.email})
        .then((value) => status = true)
        .onError((error, stackTrace) => status = false);
    return status;
  }

  Future<bool> updateUserType(int type) async {
    var status = false;
    await _db
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .update({'type': type})
        .then((value) => status = true)
        .onError((error, stackTrace) => status = false);
    return status;
  }

  Future<bool> setTranslatorDocuments(List<String> storagePath) async {
    var status = false;
    await _db
        .collection('users')
        .doc(AuthService.instance.currentUser!.uid)
        .collection('document')
        .doc('documents')
        .set({'documents': storagePath, 'isConfirmed': false});
    return status;
  }
}
