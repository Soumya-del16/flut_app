import 'package:flutter/material.dart';

class MyAboutus extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new _MyAboutusState();

  }

}

class _MyAboutusState extends State<MyAboutus>{
  final _forkey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return  Form (
        key: _forkey3,
        child:
        Scaffold(
        appBar:  AppBar(title: Text('About Us')),
          body: Column(
                                  children: <Widget>[
                                       SizedBox(height: 10,),
                                       Text('About Us ', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
                                                  SizedBox(height: 30,),
                                      Column(
                                        children: <Widget>[
                                           Padding(
                                    padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                     child: Text('About Us  Text  is here', style: TextStyle(color: Colors.black, fontSize: 16),),

                                       ),
                                       ] ),
    ]),
    ),
    );
  }


}