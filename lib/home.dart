import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _priceReaded = "R\$ 0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("img/bitcoin.png"),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                _priceReaded,
                style: TextStyle(fontSize: 50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextButton(
                onPressed: () => {_getBCPrice()},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.fromLTRB(45, 20, 45, 20)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                child: const Text('Atualizar Preço'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBCPrice() async {
    http.Response response;
    response = await http.get(Uri.parse("https://blockchain.info/ticker"));
    Map<String, dynamic> bcPrices = jsonDecode(response.body);
    print('resposta: ${bcPrices['BRL']}');
    setState(() {
      _priceReaded = 'R\$ ${bcPrices['BRL']['buy'].toString()}';
    });
  }
}
