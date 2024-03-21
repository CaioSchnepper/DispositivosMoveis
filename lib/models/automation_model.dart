class AutomationModel {
  List<ComandoModel> comandos = List.empty();
  int idIntegracao = 0;
  String nome = "";

  AutomationModel(this.comandos, this.idIntegracao, this.nome);

  AutomationModel.from(AutomationModel automation) {
    comandos = automation.comandos;
    idIntegracao = automation.idIntegracao;
    nome = automation.nome;
  }

  AutomationModel.fromJson(Map<String, dynamic> json)
      : comandos = toComandosList(json['comandos']),
        idIntegracao = json['idIntegracao'],
        nome = json['nome'];

  static List<ComandoModel> toComandosList(List<dynamic> list) {
    return list.map((comando) => ComandoModel.fromJson(comando)).toList();
  }
}

class ComandoModel {
  int idComando;
  int idComandoPadrao;
  int idInterface;
  int indIconeComando;
  String nome;
  int? status;
  String valorComando;
  int enumAcao;

  ComandoModel.fromJson(Map<String, dynamic> json)
      : idComando = json['idComando'],
        idComandoPadrao = json['idComandoPadrao'],
        idInterface = json['idInterface'],
        indIconeComando = json['indIconeComando'],
        nome = json['nome'],
        status = json['status'],
        valorComando = json['valorComando'],
        enumAcao = json['enumAcao'];
}

class ComandoSendModel {
  final int comandoId;
  final int integracaoId;
  final String? zona;

  ComandoSendModel(
      {required this.comandoId,
      required this.integracaoId,
      required this.zona});

  Map<String, dynamic> toJson() =>
      {'comandoId': comandoId, 'integracaoId': integracaoId, 'zona': zona};
}
