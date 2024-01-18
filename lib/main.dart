import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 207, 206, 206),
      ),
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
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              input = '';
              result = '';
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                color: const Color.fromARGB(255, 255, 255, 255),
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  result.isEmpty ? input : '$input = $result',
                  style: const TextStyle(fontSize: 32.0, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              buildRow(['7', '8', '9', '/'], Colors.white,1),
              const SizedBox(height: 10),
              buildRow(['4', '5', '6', '*'], Colors.white,1),
              const SizedBox(height: 10),
              buildRow(['1', '2', '3', '-'], Colors.white,1),
              const SizedBox(height: 10),
              buildRow(['%', '0', '.', '+'],  Colors.white,1),
              const SizedBox(height: 10),
              buildRow(['='], Colors.blue, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(
      List<String> buttons, Color buttonColor, int horizontalSpace) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) {
        return GestureDetector(
          onTap: () {
            handleButtonPress(button);
          },
          child: Container(
            width: 90.0 * horizontalSpace, // Ajusta el ancho aquí
            height: 60,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                button,
                style: TextStyle(fontSize: 25.0, color: Colors.black),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void handleButtonPress(String button) {
    setState(() {
      if (button == '=') {
        result = evaluateExpression();
      } else {
        if (!result.isEmpty) {
          input = button;
          result = '';
        } else {
          bool isLastCharOperator = input.isNotEmpty && isOperator(input.substring(input.length - 1));
          if (isOperator(button) && isLastCharOperator) {
            input = input.substring(0, input.length - 1) + button;
          } else {
            input += button;
          }
        }
      }
    });
  }

  bool isOperator(String character) {
    return ['+', '-', '*', '/', '%'].contains(character);
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
