class PatrimonyModel {
  List<ClienteModel> clientes = List.empty();
  //Permission config;

  PatrimonyModel();

  PatrimonyModel.fromJson(Map<String, dynamic> json)
      : clientes = toClientModelList(json['clientes']);
  //config = json['config'];

  static List<ClienteModel> toClientModelList(List<dynamic> list) {
    return list.map((cliente) => ClienteModel.fromJson(cliente)).toList();
  }
}

class ClienteModel {
  bool armado;
  String cliente1;
  bool hasVideoServer;
  int idUnico;
  String nome;
  String? parceira;
  String particao;
  double posX;
  double posY;

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
