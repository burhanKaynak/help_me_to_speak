import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';

class StorageService {
  static final instance = StorageService();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> putFileUserDocuments(File file, int index) async {
    var user = AuthService.instance.currentUser;
    var path = 'documents/certificates/${user!.uid}/$index';
    await _storage.ref(path).putFile(file);
    return path;
  }

  Future<String> putConversationMedia(String conversationId, File file) async {
    var path =
        'conversations/$conversationId/media/${file.path.split('/').last}';
    await _storage.ref(path).putFile(file);
    return path;
  }

  Future<String> putImage(File file) async {
    var path =
        'images/${AuthService.instance.currentUser!.uid}${AuthService.instance.currentUser!.uid}';
    var result = await _storage.ref(path).putFile(file);
    var url = await result.ref.getDownloadURL();
    return url;
  }

  Future<Uri> downloadFile(String path, String conversationId) async {
    final fileFromStorage = await _storage.ref().child(path).getDownloadURL();
    return Uri.parse(fileFromStorage);
  }
}
