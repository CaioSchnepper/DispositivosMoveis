import 'dart:convert';

import 'package:dispositivos_moveis/models/qrcode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _QR_CODE_DATA = 'QR_CODE_DATA';

  static Future<void> saveQRCodeData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_QR_CODE_DATA, data);
  }

  static Future<QRCodeModel> getQRCodeData() async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodeData = prefs.getString(_QR_CODE_DATA);
    return QRCodeModel.fromJson(jsonDecode(qrCodeData!));
  }
}
