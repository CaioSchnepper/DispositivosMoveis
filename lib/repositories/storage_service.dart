import 'dart:convert';

import 'package:app_do_portao/models/login_model.dart';
import 'package:app_do_portao/models/qrcode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class StorageService {
  static const String _qrCodeDataKey = 'QR_CODE_DATA';
  static const String _loginDataKey = 'LOGIN_DATA';

  static Future<void> saveQRCodeData(String data) async {
    SharedPreferences preferencesInstance =
        await SharedPreferences.getInstance();
    preferencesInstance.setString(_qrCodeDataKey, data);
  }

  static Future<QRCodeModel?> getQRCodeData() async {
    SharedPreferences preferencesInstance =
        await SharedPreferences.getInstance();
    final qrCodeData = preferencesInstance.getString(_qrCodeDataKey);

    return qrCodeData != null
        ? QRCodeModel.fromJson(jsonDecode(qrCodeData))
        : null;
  }

  static Future<void> saveLoginData(LoginResponseModel data) async {
    SharedPreferences preferencesInstance =
        await SharedPreferences.getInstance();
    preferencesInstance.setString(_loginDataKey, jsonEncode(data.toJson()));
  }

  static Future<LoginResponseModel?> getLoginData() async {
    SharedPreferences preferencesInstance =
        await SharedPreferences.getInstance();
    final loginData = preferencesInstance.getString(_loginDataKey);

    return loginData != null
        ? LoginResponseModel.fromJson(jsonDecode(loginData))
        : null;
  }

  static Future<String?> getTenantId() async {
    final QRCodeModel? qrCodeData = await StorageService.getQRCodeData();
    return qrCodeData?.tenantId;
  }

  static Future<String?> getAccessToken() async {
    final LoginResponseModel? loginData = await StorageService.getLoginData();
    return loginData?.accessToken;
  }

  static Future<String?> getRefreshToken() async {
    final LoginResponseModel? loginData = await StorageService.getLoginData();
    return loginData?.refreshToken;
  }

  static Future<String?> getApiUrl() async {
    final QRCodeModel? qrCodeData = await StorageService.getQRCodeData();
    return qrCodeData?.url;
  }
}
