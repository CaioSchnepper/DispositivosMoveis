import 'dart:convert';

import 'package:dispositivos_moveis/models/login_model.dart';
import 'package:dispositivos_moveis/models/qrcode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _qrCodeDataKey = 'QR_CODE_DATA';
  static const String _loginDataKey = 'LOGIN_DATA';

  static Future<void> saveQRCodeData(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_qrCodeDataKey, data);
  }

  static Future<QRCodeModel?> getQRCodeData() async {
    final prefs = await SharedPreferences.getInstance();
    final qrCodeData = prefs.getString(_qrCodeDataKey);

    return qrCodeData != null
        ? QRCodeModel.fromJson(jsonDecode(qrCodeData))
        : null;
  }

  static Future<void> saveLoginData(LoginResponseModel data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_loginDataKey, jsonEncode(data.toJson()));
  }

  static Future<LoginResponseModel?> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final loginData = prefs.getString(_loginDataKey);

    return loginData != null
        ? LoginResponseModel.fromJson(jsonDecode(loginData))
        : null;
  }
}
