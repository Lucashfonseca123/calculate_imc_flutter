import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _text = "Informe seus dados";

  void _resetField() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _text = "Digite Algo";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _text = "Abaixo do peso ${imc.toStringAsPrecision(4)}";
      } else if (imc > 18.6) {
        _text = "Ta de boa ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculado de imc"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetField,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Colors.green,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: weightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu peso";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: heightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura";
                      }
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _calculate();
                            }
                          },
                          child: Text(
                            "Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          color: Colors.green,
                        ),
                      )),
                  Text(
                    _text,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              )),
        ));
  }
}
