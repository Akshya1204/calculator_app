import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Button-like Text Field'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: MyButton(),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  String _value = '';

  void _onTap() {
    setState(() {
      _value = 'Button tapped!';
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller1 = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    return
    Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller1,
            decoration: InputDecoration(
              labelText: 'Text Field 1',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                
              });
            },
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: _controller2,
            decoration: InputDecoration(
              labelText: 'Text Field 2',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (value) {
              // Do something when the text field changes
            },
          ),
        ),
      ],
    )
  }
}