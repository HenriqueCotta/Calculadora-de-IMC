import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var weightController = TextEditingController(text: "");
  TextEditingController heightController = TextEditingController(text: "");
  
  var formkey = GlobalKey<FormState>();

  String infoText = "Informe seus dados!";

  void resetFields() {

    weightController.text = "";
    heightController.text = "";
    setState(() {
      infoText = "Informe seus dados!";
    });
    
  }

  void calculate() {

    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);
      print(imc);

      if (imc < 18.6){
        infoText = "${imc.toStringAsPrecision(3)} (Abaixo do peso!)";
      } else if(imc >= 18.6 && imc < 24.9){
        infoText = "${imc.toStringAsPrecision(3)} (Peso ideal!)";
      } else if(imc >= 24.9 && imc < 29.9){
        infoText = "${imc.toStringAsPrecision(3)} (Obesidade grau I!)";
      } else if(imc >= 29.9 && imc < 34.9){
        infoText = "${imc.toStringAsPrecision(3)} (Obesidade grau II!)";
      } else if(imc >= 34.9 && imc < 39.9){
        infoText = "${imc.toStringAsPrecision(3)} (Obesidade grau III!)";
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: resetFields,
              icon: Icon(Icons.refresh),
            )
          ]),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: content(),
            ),
          ),
        ),
      ),
    );
  }

  Form content() {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 120.0,
            color: Colors.green,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Peso (kg)",
              labelStyle: TextStyle(color: Colors.green),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontSize: 25.0,
            ),
            controller: weightController,
            validator: (value) {
              if(value == null || value.isEmpty){
                return "Insira seu peso.";
              }
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Altura (cm)",
              labelStyle: TextStyle(color: Colors.green),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontSize: 25.0,
            ),
            controller: heightController,
            validator: (value) {
              if(value  == null || value.isEmpty){
                return "Insira sua altura.";
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if(formkey.currentState!.validate()){
                calculate();
              }
            },
            child: Text("Calcular", textScaleFactor: 2),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              minimumSize: Size(160, 55),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$infoText",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}
