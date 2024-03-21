class AutomationModel {
  List<ComandoModel> comandos = List.empty();
  int idIntegracao = 0;
  String nome = "";

  AutomationModel();

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
