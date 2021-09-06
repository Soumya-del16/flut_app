import 'dart:convert';

import 'package:flut_app/allscreens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyContactUs extends StatefulWidget{
  String phoneno;
  MyContactUs(this.phoneno);

  @override
  State<StatefulWidget> createState() {
    return new _MyContactUsState();
  }

}


class _MyContactUsState extends State<MyContactUs>{

  final _contatform_key = GlobalKey<FormState>();
  late String name,mobile,message;

  Future<SignUpSuccessMessage> contactInsert(http.Client client,String mob,String name,String message, BuildContext context) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['contact_insert'] = '1';
    map['mobile'] = mob;
    map['name'] = name;
    map['message'] = message;

    final response =
    await client
        .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Contact info'),
            content: Text(' Message Successfully sent '),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return SignUpSuccessMessage.fromJson(jsonDecode(response.body));

    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Contact info'),
            content: Text(' Failed to load '),
            actions: <Widget>[
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      throw Exception('Failed to load album');
    }
  }



  @override
  Widget build(BuildContext context) {

    return
      Form (
        key: _contatform_key,
        child:Scaffold(
        appBar: AppBar(title: Text('Contact Us')),
        body :Container(
      decoration: BoxDecoration(
        color: Colors.white,),

      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Text('Contact Us', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                    child:
                    TextFormField(

                      validator: (value) => value!.isEmpty ?  'Name cannot be blank' : getNameError(value),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 1.0
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                    child:
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ?  getMobileErrormessage(value) : getMobileErrormessage(value),
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: 'Mobile no',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 1.0
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                    child:   TextFormField(
                      validator: (value) => value!.isEmpty ?  'Cannot be empty': getMessageError(value),
                      decoration: InputDecoration(
                        hintText: 'Message',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                              color: Colors.orangeAccent,
                              width: 1.0
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),

                    ),
                  ),
                ],
              ),
              //),
              SizedBox(height: 30),
              Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.0),
                    color: Colors.orange
                ),
                child:
                Center(
                  child:
                  InkWell(
                    onTap: (){
                      if(_contatform_key.currentState!.validate()){
                        contactInsert(http.Client(), mobile, name, message, context);
                      }
                    },
                    child: new Container(
                      child: Center(
                        child:Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  //,
                ),
              ),
              SizedBox(height: 30,),

            ],
          ),
        ),
      ),
    ),
        ),
    );
  }

  String? getNameError(String value) {
    if(value.length <=3 ){
      return 'Name contains atlest 4characters';
    }
    name = value;
    return null;
  }
  String? getMessageError(String value) {
    if(value.length <=3 ){
      return 'Name contains atlest 4characters';
    }
    message = value;
    return null;
  }
  String? getMobileErrormessage(String value) {
    if(value.isEmpty)
    {
      return 'mobile cannot be blank';
    }
    else{
      if (!RegExp("^[6-9]{1}[0-9]{9}").hasMatch(value)) {
        return 'Please enter valid mobile number';
      }
    }
    mobile = value;
    return null;
  }

}


