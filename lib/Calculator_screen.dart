import 'package:flutter/material.dart';
import 'buttons_section.dart';
class Calculatorscreen extends StatefulWidget {
  const Calculatorscreen({super.key});

  @override
  State<Calculatorscreen> createState() => _CalculatorscreenState();
}

class _CalculatorscreenState extends State<Calculatorscreen> {
  String number1="";  //.0-9
  String operand="";  //+ - * / %
  String number2="";  //. 0-9
  @override
  Widget build(BuildContext context) {
    final screensize=MediaQuery.of(context).size;
    return Scaffold(
      body:
      //output screen
      SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child:SingleChildScrollView(
                  reverse: true,
                  child:Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "$number1$operand$number2".isEmpty?
                      "0":
                      "$number1$operand$number2",
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  )
              ),
            ),
            //buttons section
            Wrap(
              children:Btn.buttonValues
                  .map(
                      (value)=> SizedBox(
                      height:screensize.width/5,
                      width: value==Btn.n0 ?
                      screensize.width/2:
                      screensize.width/4,
                      child: buildButton(value)
                  )
              ).toList(),
            )
          ],
        ),
      ),
    );
  }
  Widget buildButton(value){
    return
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          color: getBtncolor(value),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(100)),
          child: InkWell(
              onTap: () => onBtnTap(value),
              child: Center(child: Text(value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              )
              )
          ),
        ),
      );
  }
  void onBtnTap(String value){
    if(value==Btn.del){
      delete();
      return;
    }
    if(value==Btn.clr){
      clear();
      return;
    }
    if(value==Btn.per){
      percent();
      return;
    }
    if(value==Btn.calculate){
      calculate();
      return;
    }
    appendvalues(value);
  }
  //calculate
  void calculate(){
    if(number1.isEmpty) return;
    if(operand.isEmpty) return;
    if(number2.isEmpty) return;
    final num1=double.parse(number1);
    final num2=double.parse(number2);
    var result=0.0;
    switch(operand){
      case Btn.add:
        result=num1+num2;
        break;
      case Btn.subtract:
        result=num1-num2;
        break;
      case Btn.multiply:
        result=num1*num2;
        break;
      case Btn.divide:
        result=num1/num2;
        break;
      default:
    }
    setState(() {
      number1="$result";
      if(number1.endsWith(".0")){
        number1=number1.substring(0,number1.length-2);
      }
      operand="";
      number2="";
    });
  }
  //percent
  void percent(){
    if(number1.isNotEmpty&&operand.isNotEmpty&&number2.isNotEmpty){
      //calculate before conversion
      calculate();
    }
    if(operand.isNotEmpty){
      // cannot be converted
      return;
    }
    final number=double.parse(number1);
    setState(() {
      number1="${(number / 100)}";
      operand="";
      number2="";
    });
  }
  //clear
  void clear(){
    setState(() {
      number1="";
      operand="";
      number2="";
    });
  }
  //delete
  void delete(){
    if(number2.isNotEmpty){
      number2 = number2.substring(0,number2.length-1);
    }
    else if(operand.isNotEmpty){
      operand="";
    }
    else if(number1.isNotEmpty){
      number1 = number1.substring(0,number1.length-1);
    }
    setState(() {
    });
  }

  void appendvalues(String value){
    //number1 operand number2
    // operand is pressed
    if(value!=Btn.dot && int.tryParse(value)==null){
      if(operand.isNotEmpty && number2.isNotEmpty){
        calculate();
      }
      operand=value;
      // assign value to number1 variable
    }else if(number1.isEmpty || operand.isEmpty){
      // check if value is "."
      if(value==Btn.dot && number1.contains(Btn.dot)) return;
      if(value==Btn.dot && (number1.isEmpty || number1==Btn.n0)){
        value="0.";
      }
      number1 +=value;
    }
    // assign value to number2 variable
    else if(number2.isEmpty || operand.isNotEmpty){
      if(value==Btn.dot && number2.contains(Btn.dot)) return;
      if(value==Btn.dot && (number2.isEmpty || number2==Btn.n0)){
        value="0.";
      }
      number2 +=value;
    }
    setState(() {

    });
  }
  Color getBtncolor(value){
    return [Btn.del,Btn.clr].contains(value) ? Colors.blueGrey
        :[
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate
    ].contains(value)?Colors.orange:Colors.black;
  }
}