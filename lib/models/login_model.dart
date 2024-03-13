import 'package:dispositivos_moveis/models/permissions_model.dart';
import 'package:uuid/uuid.dart';

class LoginModel {
  final String applicationId;
  final String celular;
  final String senha;

  const LoginModel(
      {required this.applicationId,
      required this.celular,
      required this.senha});

  Map<String, dynamic> toJson() =>
      {'applicationId': applicationId, 'celular': celular, 'senha': senha};
}

class LoginResponseModel {
  String accessToken;
  bool changePassword;
  DateTime expireAt;
  Uuid id;
  Permission permissions;
  String phoneNumber;
  String refreshToken;

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        changePassword = json['changePassword'],
        expireAt = json['expireAt'],
        id = json['id'],
        permissions = json['permissions'],
        phoneNumber = json['phoneNumber'],
        refreshToken = json['refreshToken'];

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'changePassword': changePassword,
        'expireAt': expireAt,
        'id': id,
        'permissions': permissions,
        'phoneNumber': phoneNumber,
        'refreshToken': refreshToken
      };
}
