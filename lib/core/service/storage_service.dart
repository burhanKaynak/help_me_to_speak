import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';
import 'package:path_provider/path_provider.dart';

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

  Future<File> downloadFile(String path, String conversationId) async {
    final fileFromStorage = _storage.ref().child(path);
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.path}/${fileFromStorage.fullPath}";
    final file = File(filePath);
    await file.create(recursive: true);
    var result = await fileFromStorage.writeToFile(file);
    return file;
  }
}
