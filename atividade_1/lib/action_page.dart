import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

class ActionPage extends StatefulWidget {
  ActionPage({
    Key? key,
    required this.action,
  }) : super(key: key);
  final String action;

  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.action),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Card(
          child: FutureBuilder(
            future: getActionInformation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ActionInformationCard(action: (snapshot.data as Action));
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar as informações"),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Action> getActionInformation() async {
    var response = await http.get(
      Uri.parse(
        "https://api.hgbrasil.com/finance/stock_price?key=8f636b9d&symbol=" +
            widget.action,
      ),
    );
    print(response.body);
    return Action.fromJson(
      jsonDecode(
        (response).body,
      )['results'][widget.action],
    );
  }
}

class ActionInformationCard extends StatelessWidget {
  const ActionInformationCard({Key? key, required this.action})
      : super(key: key);

  final Action action;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Nome: " + action.companyName.toString()),
          Container(height: 10),
          Text("Descrição: " + action.description.toString()),
          Container(height: 10),
          Text("Região: " + action.region.toString()),
          Container(height: 10),
          Text("Moeda: " + action.currency.toString()),
          Container(height: 10),
          Text("Nome: " + action.companyName.toString()),
          Container(height: 40),
          Text("Valor de mercado: R\$ " + action.marketCap.toString()),
          Container(height: 10),
          Text("preço da ação: R\$ " + action.price.toString()),
          Container(height: 10),
          Text("Porcentagem de mudança: " + action.changePercent.toString()+"%"),
          Container(height: 40),
          Center(child: Text("Dados de: " + action.updateTime.toString())),
        ],
      ),
    );
  }
}

class Action {
  final String? name;
  final String? companyName;
  final String? description;
  final String? region;
  final double? price;
  final String? currency;
  final String? updateTime;
  final double? marketCap;
  final double? changePercent;

  Action({
    this.name,
    this.companyName,
    this.description,
    this.region,
    this.price,
    this.currency,
    this.updateTime,
    this.marketCap,
    this.changePercent,
  });

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      name: json['name'],
      companyName: json['company_name'],
      description: json['description'],
      region: json['region'],
      price: json['price'],
      currency: json['currency'],
      updateTime: json['updated_at'],
      marketCap: json['market_cap'],
      changePercent: json['change_percent'],
    );
  }
}
