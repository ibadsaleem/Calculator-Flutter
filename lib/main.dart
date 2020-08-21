//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:core';

void main() => runApp(Calculator());

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SafeArea(child: SimpleCalculator()),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  double equationFontSize = 38;
  double resultFontSize = 48;
  String expression = "";
  num A;
  void buttonPressed(String buttonText) {
    if (buttonText == "C") {
      equationFontSize = 38;
      resultFontSize = 48;
      equation = "0";
      result = "0";
    } else if (buttonText == "⌫") {
      equation = equation.substring(0, equation.length - 1);
      if (equation == "") {
        equation = "0";
      }
    } else if (buttonText == "=") {
      equationFontSize = 38;
      resultFontSize = 48;

      expression = equation;
      expression = expression.replaceAll('x', '*');
      expression = expression.replaceAll('÷', '/');

      try {
        Parser p = Parser();

        Expression exp = p.parse(expression);
        ContextModel C = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, C)}';
      } catch (e) {
        result = "Error!";
      }
    } else {
      if (equation == "0") {
        equationFontSize = 48;
        resultFontSize = 38;
        equation = buttonText;
      } else {
        equation = equation + buttonText;
      }
    }
  }

  Widget buildButton(String buttonText, Color clr, double btnheight) {
    return Container(
      height: MediaQuery.of(context).size.height * .10 * btnheight,
      color: clr,
      child: FlatButton(
        onPressed: () {
          setState(() {
            buttonPressed(buttonText);
          });
        },
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            'Simple Calculator',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
              ),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  border: TableBorder.all(
                      color: Colors.black,
                      width: 0.2,
                      style: BorderStyle.solid),
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', Colors.red, 1),
                        buildButton('⌫', Colors.blue, 1),
                        buildButton('÷', Colors.blue, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', Colors.black54, 1),
                        buildButton('8', Colors.black54, 1),
                        buildButton('9', Colors.black54, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', Colors.black54, 1),
                        buildButton('5', Colors.black54, 1),
                        buildButton('6', Colors.black54, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', Colors.black54, 1),
                        buildButton('2', Colors.black54, 1),
                        buildButton('3', Colors.black54, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', Colors.black54, 1),
                        buildButton('0', Colors.black54, 1),
                        buildButton('00', Colors.black54, 1),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  border: TableBorder.all(
                      color: Colors.black, width: .2, style: BorderStyle.solid),
                  children: [
                    TableRow(
                      children: [buildButton('x', Colors.blue, 1)],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', Colors.blue, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', Colors.blue, 1),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', Colors.red, 2),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
