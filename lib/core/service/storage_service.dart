import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';

class StorageService {
  static final instance = StorageService();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> putFileUserDocuments(File file, int index) async {
    var user = AuthService.instance.currentUser;
    var path = '${user!.uid}/documents/$index';
    await _storage.ref(path).putFile(file);
    return path;
  }
}
