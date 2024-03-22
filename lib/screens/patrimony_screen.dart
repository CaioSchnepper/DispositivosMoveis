import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:app_do_portao/screens/command_screen.dart';
import 'package:app_do_portao/services/patrimony_service.dart';
import 'package:app_do_portao/utils/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';

class PatrimonyScreen extends StatefulWidget {
  const PatrimonyScreen({super.key});

  final String title = 'Login';

  @override
  State<PatrimonyScreen> createState() => _PatrimonyScreenState();
}

class _PatrimonyScreenState extends State<PatrimonyScreen> {
  PatrimonyModel _patrimonies = PatrimonyModel();

  @override
  void initState() {
    _fetchPatrimonies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: Image.asset('lib/assets/images/patrimonio.gif'),
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                for (var cliente in _patrimonies.clientes)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: Card(
                      child: ListTile(
                        onTap: () => _navigateToCommands(cliente),
                        leading: Icon(
                          Icons.location_city,
                          size: 40,
                          color: cliente.armado ? Colors.red : Colors.green,
                        ),
                        title: Text(cliente.nome),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${cliente.cliente1} - ${cliente.particao}'),
                            Text(cliente.armado ? 'Armado' : 'Desarmado',
                                style: TextStyle(
                                    color: cliente.armado
                                        ? Colors.red
                                        : Colors.green))
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _fetchPatrimonies() async {
    PatrimonyModel patrimonies = PatrimonyModel();

    try {
      patrimonies = await PatrimonyService.fetchPatrimonies();
    } catch (exception) {
      SnackBarHelper.show(context, "Erro ao buscar patrimônios");
      return;
    }

    setState(() {
      _patrimonies = patrimonies;
    });
  }

  void _navigateToCommands(ClienteModel cliente) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CommandScreen(cliente: cliente)),
    );
  }
}
