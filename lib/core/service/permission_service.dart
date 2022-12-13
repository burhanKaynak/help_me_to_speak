import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final BuildContext context;
  late List<Permission> _permissions;
  final List<Permission> _permanentlyDenied = [];

  PermissionService.of(this.context);

  Future<bool> getPermission(List<Permission> permissions) async {
    _permissions = permissions;
    var result = false;

    for (var permission in _permissions) {
      var status = await permission.status;

      switch (status) {
        case PermissionStatus.granted:
          result = true;
          break;

        case PermissionStatus.denied:
          final permissionResult = await permission.request();
          if (permissionResult.isDenied) {
            _permanentlyDenied.add(permission);
          } else if (permissionResult.isPermanentlyDenied) {
            _permanentlyDenied.add(permission);
            result = false;
            break;
          } else {
            result = permissionResult.isGranted;
          }
          break;

        case PermissionStatus.permanentlyDenied:
          _permanentlyDenied.add(permission);
          result = false;
          break;

        default:
          result = true;
      }
    }
    if (_permanentlyDenied.isNotEmpty) await _showPermissionDialog();

    return result;
  }

  _showPermissionDialog() async {
    var result = await showOkCancelAlertDialog(
        title:
            '${_permanentlyDenied.map((e) => _names[e.value])} izni gerekiyor',
        message:
            'Lütfen bu hizmeti kullanabilmek için Ayarlar buttonuna tıklayıp gerekli izinleri veriniz.',
        useActionSheetForIOS: true,
        context: context,
        cancelLabel: 'Kapat',
        okLabel: 'Ayarlar');
    if (result == OkCancelResult.ok) await openAppSettings();
  }

  static const List<String> _names = <String>[
    'Takvim',
    'Kamera',
    'Rehber',
    'Konum',
    'Konum',
    'Konum',
    'Media Kütüphanesi',
    'Mikrofon',
    'Telefon',
    'Fotoğraf',
    'Hatırlatıcılar',
    'Sensör',
    'Sms',
    'Konuşma',
    'Depolama',
    'Pil Optimizasyonlarını yoksay',
    'Bildirim',
    'Medya konumuna erişim',
    'activity_recognition',
    'unknown',
  ];
}
