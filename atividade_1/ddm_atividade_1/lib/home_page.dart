import 'package:ddm_atividade_1/action_page.dart';
import 'package:ddm_atividade_1/actions_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ações"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Pesquise pela ação que deseja obter informações:',
              ),
              Container(height: 20),
              TextField(
                controller: searchController,
                onChanged: (value) => setState(() {}),
              ),
              Container(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: ActionsList.actionsList.entries.map((entry) {
                  return entry.key
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())
                      ? ActionTile(action: entry.key)
                      : Container();
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  const ActionTile({
    Key? key,
    required this.action,
  }) : super(key: key);

  final String action;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActionPage(
              action: action,
            ),
          ),
        );
      },
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(action),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActionPage(
                          action: action,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_right,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
