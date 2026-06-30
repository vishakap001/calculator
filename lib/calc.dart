import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
  String input = "";

  String output = "0";

  Widget button(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            buttonPressed(text);
          },
          child: Text(text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                    text == "=" ||
                    text == "+" ||
                    text == "-" ||
                    text == "x" ||
                    text == "÷"
                ? Colors.orange
                :text=="AC"||text=="％"||text=="⌫"?Colors.grey:Color.fromRGBO(34, 34, 34, 1),
            foregroundColor:text=="AC"||text=="％"||text=="⌫"?Colors.black: Colors.white,
            fixedSize: Size(90, 60),
            shape: CircleBorder(),
           
          ),
        ),
      ),
    );
  }

  String evaluatexp(String expression) {
    expression = expression.replaceAll("x", "*").replaceAll("÷", "/");
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);
    return result.toString();
  }

  void buttonPressed(String value) {
    setState(() {
      if (value == "AC") {
        input = "";
        output = "0";
      } else if (value == "⌫") {
        input = input.isNotEmpty ? input.substring(0, input.length - 1) : "";
      } else if (value == "=") {
        try {
          output = evaluatexp(input);
        } catch (e) {
          output = "error";
        }
      } else {
        input = input + value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
             
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Text(input,style: TextStyle(color: Colors.white,fontSize: 56),), Text(output,style: TextStyle(color: Colors.white,fontSize: 45))]),
            ),
          ),
          Row(children: [button("AC"), button("％"), button("⌫"), button("÷")]),
          Row(children: [button("7"), button("8"), button("9"), button("x")]),
          Row(children: [button("4"), button("5"), button("6"), button("-")]),
          Row(children: [button("1"), button("2"), button("3"), button("+")]),
          Row(children: [button("00"), button("0"), button("."), button("=")]),
        ],
      ),
    );
  }
}
