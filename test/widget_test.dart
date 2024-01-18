import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              color: Colors.grey[300], // Fondo gris
              child: Text(
                result.isEmpty ? input : '$input = $result',
                style: TextStyle(fontSize: 24.0, color: Colors.black),
              ),
            ),
          ),
          buildRow(['P1', '/']),
          buildRow(['7', '8', '9', '*']),
          buildRow(['4', '5', '6', '-']),
          buildRow(['1', '2', '3', '+']),
          buildRow(['%', '0', '.', '=']),
        ],
      ),
    );
  }

  Widget buildRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((button) {
          return Expanded(
            flex: button == 'P1' ? 3 : 1,
            child: GestureDetector(
              onTap: () {
                handleButtonPress(button);
              },
              child: Container(
                color: Colors.white, // Fondo blanco
                height: double.infinity,
                child: Center(
                  child: button == 'P1'
                      ? SizedBox.shrink()
                      : Text(
                          button,
                          style: TextStyle(fontSize: 18.0, color: Colors.black), // Texto negro
                        ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void handleButtonPress(String button) {
    setState(() {
      if (button == '=') {
        result = evaluateExpression();
      } else {
        input += button;
      }
    });
  }

  String evaluateExpression() {
    List<String> tokens = input.split(RegExp(r'(\+|-|\*|/|%| )'));
    List<String> operators =
        input.split(RegExp(r'(\d+|\.)')).where((e) => e.isNotEmpty).toList();

    double resultValue = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i++) {
      double value = double.parse(tokens[i]);
      String operator = operators[i - 1];

      switch (operator) {
        case '+':
          resultValue += value;
          break;
        case '-':
          resultValue -= value;
          break;
        case '*':
          resultValue *= value;
          break;
        case '/':
          resultValue /= value;
          break;
        case '%':
          resultValue %= value;
          break;
      }
    }

    return resultValue.toString();
  }
}