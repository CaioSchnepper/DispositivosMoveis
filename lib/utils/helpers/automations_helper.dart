import 'package:app_do_portao/models/automation_model.dart';
import 'package:app_do_portao/utils/constants/acao_enum.dart';

class AutomationsHelper {
  static bool commandContainsPortao(String nome) {
    const String portaoWithTilde = "Portão";
    const String portaoWithoutTilde = "Portao";

    return nome.contains(portaoWithTilde) ||
        nome.contains(portaoWithTilde.toLowerCase()) ||
        nome.contains(portaoWithoutTilde) ||
        nome.contains(portaoWithoutTilde.toLowerCase());
  }

  static bool commandIsSupported(ComandoModel comando) {
    return comando.enumAcao == EnumAcao.armar ||
        comando.enumAcao == EnumAcao.desarmar ||
        comando.enumAcao == EnumAcao.inibirZonas;
  }
}
