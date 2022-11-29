import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';

mixin FilePickerMix {
  Future<File?> pickFiles(
      {required FileType type, List<String>? custom}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true, type: type, allowedExtensions: custom);
    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }

  String? getMimeType(path) {
    var mimeType = lookupMimeType(path);
    var result =
        mimeType!.substring(mimeType.indexOf('/') + 1, mimeType.length);
    return result;
  }
}
