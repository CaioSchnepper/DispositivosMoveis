import 'package:app_do_portao/models/permissions_model.dart';

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
  bool? changePassword;
  DateTime expireAt;
  String? id;
  Permission? permissions;
  String? phoneNumber;
  String refreshToken;

  LoginResponseModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        changePassword = json['changePassword'],
        expireAt = DateTime.parse(json['expireAt']),
        id = json['id'],
        // permissions = json['permissions'],
        phoneNumber = json['phoneNumber'],
        refreshToken = json['refreshToken'];

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'changePassword': changePassword,
        'expireAt': expireAt.toString(),
        'id': id,
        'permissions': permissions,
        'phoneNumber': phoneNumber,
        'refreshToken': refreshToken
      };
}

class RefreshTokenModel {
  String keyAccessId;
  String refreshToken;

  RefreshTokenModel(this.keyAccessId, this.refreshToken);

  Map<String, dynamic> toJson() =>
      {'keyAccessId': keyAccessId, 'refreshToken': refreshToken};
}
