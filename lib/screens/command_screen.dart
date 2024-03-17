import 'package:app_do_portao/models/patrimony_model.dart';
import 'package:flutter/material.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key, required ClienteModel cliente});

  final String title = 'Login';

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  //PatrimonyModel _patrimonies = PatrimonyModel();

  @override
  void initState() {
    _fetchCommands();
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
                //for (var cliente in _patrimonies.clientes)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: const Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.location_city,
                          size: 40,
                          //color: cliente.armado ? Colors.red : Colors.green,
                        ),
                        title: Text(''),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(''),
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

  void _fetchCommands() async {
    //PatrimonyModel patrimonies = await PatrimonyService.fetchPatrimonies();

    setState(() {
     // _patrimonies = patrimonies;
    });
  }
}
