import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var Input = '';
  var output = '';

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(color: Color.fromARGB(255, 171, 130, 4)),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        Input,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        output,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
            ),
          ),
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            Input = '';
                            output = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color.fromARGB(255, 5, 83, 146),
                        textColor: Colors.black,
                      );
                    } else if (index == 1) {
                      return MyButton(
                        buttonText: buttons[index],
                        color: const Color.fromARGB(255, 6, 85, 149),
                        textColor: Colors.black,
                      );
                    } else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            Input += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color.fromARGB(255, 9, 80, 139),
                        textColor: Colors.black,
                      );
                    } else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            Input = Input.substring(0, Input.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: const Color.fromARGB(255, 4, 75, 133),
                        textColor: Colors.black,
                      );
                    } else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.orange,
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            Input += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? const Color.fromARGB(255, 6, 97, 172)
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finaluserinput = Input;
    finaluserinput = Input.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    output = eval.toString();
  }
}
//.............................................................................................................

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          height: 100,
          color: color,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
