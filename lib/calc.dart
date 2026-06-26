import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

class _CalcState extends State<Calc> {
String input="";

String output="0";

Widget button(String text){
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(onPressed: () {
        buttonPressed(text);
      }, child: Text(text),style: ElevatedButton.styleFrom(backgroundColor: text=="="?Colors.orange:Colors.black),),
    ),
  );
}

String evaluatexp(String expression){
  expression=expression.replaceAll("x", "*").replaceAll("÷", "/");
  Parser p=Parser();
  Expression exp=p.parse(expression);
  ContextModel cm=ContextModel();
  double result=exp.evaluate(EvaluationType.REAL, cm);
  return result.toString();
}

void buttonPressed(String value){
setState(() {
  if(value=="AC"){
    input="";
    output="0";
  }
  else if(value=="⌫"){
    input=input.isNotEmpty?input.substring(0,input.length-1):"";
  }
  else if (value=="="){
try{
  output=evaluatexp(input);
}
  catch(e){
    output="error";
  }}
  else{
    input=input+value;
  }

});
}

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(alignment: Alignment.bottomRight,
            child: Column(children: [
              Text(input),
              Text(output),          ],
            ),),
          ),
          Row(children: [button("AC"),button("％"),button("⌫"),button("÷"),],),
          Row(children: [button("7"),button("8"),button("9"),button("x"),],),
          Row(children: [button("4"),button("5"),button("6"),button("-")],),
          Row(children: [button("1"),button("2"),button("3"),button("+")],),
          Row(children: [button("00"),button("0"),button("."),button("=")],)
          
        ],
      ) ,
    );
  }
}