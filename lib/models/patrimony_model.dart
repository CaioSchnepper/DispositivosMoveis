import 'dart:convert';
import 'dart:ffi';

import 'package:dispositivos_moveis/models/permissions_model.dart';

class PatrimonyModel {
  List<ClienteModel> clientes;
  Permission config;

  PatrimonyModel.fromJson(Map<String, dynamic> json)
      : clientes = jsonDecode(json['clientes'])
            .map((cliente) => ClienteModel.fromJson(cliente))
            .toList(),
        config = json['config'];
}

class ClienteModel {
  bool armado;
  String cliente1;
  bool hasVideoServer;
  int idUnico;
  String nome;
  String parceira;
  String particao;
  Long posX;
  Long posY;

  ClienteModel.fromJson(Map<String, dynamic> json)
      : armado = json['armado'],
        cliente1 = json['cliente1'],
        hasVideoServer = json['hasVideoServer'],
        idUnico = json['idUnico'],
        nome = json['nome'],
        parceira = json['parceira'],
        particao = json['particao'],
        posX = json['posX'],
        posY = json['posY'];
}
