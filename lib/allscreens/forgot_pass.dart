import 'package:flutter/material.dart';

class MyForgotPassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _MyForgotPasswordState();
  }

}

class _MyForgotPasswordState extends State<MyForgotPassword>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Forgot Password"),
    ),
    body: Center(
    child: ElevatedButton(
    onPressed: () {
    Navigator.pop(context);
    },
    child: Text('Go back!'),
    ),
    )
    );
  }

}