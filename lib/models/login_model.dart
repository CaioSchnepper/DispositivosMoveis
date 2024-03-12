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
  // "accessToken": "string",
  // "changePassword": true,
  // "expireAt": "2024-03-12T03:02:43.562Z",
  // "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
  // "permissions": {
  //   "additionalProp1": true,
  //   "additionalProp2": true,
  //   "additionalProp3": true
  // },
  // "phoneNumber": "string",
  // "refreshToken": "string"
}
