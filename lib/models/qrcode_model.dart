import 'dart:core';

class QRCodeModel {
  String url;
  String corprimaria;
  String corsecundaria;
  String parceira;
  String tenantId;

  QRCodeModel(this.url, this.corprimaria, this.corsecundaria, this.parceira,
      this.tenantId);

  QRCodeModel.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        corprimaria = json['corprimaria'],
        corsecundaria = json['corsecundaria'],
        parceira = json['parceira'],
        tenantId = json['tenantId'];

  Map<String, dynamic> toJson() => {
        'url': url,
        'corprimaria': corprimaria,
        'corsecundaria': corsecundaria,
        'parceira': parceira,
        'tenantId': tenantId
      };
}
