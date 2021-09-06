import 'dart:convert';

import 'package:flut_app/allscreens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyUpdateProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _MyUpdateProfileState();
  }
}
class _MyUpdateProfileState extends State<MyUpdateProfile>{
  final _contatform_key = GlobalKey<FormState>();
  late String name,mobile,email,city;

  Future<SignUpSuccessMessage> updateProfile(http.Client client,String mob,String name,String city,String email, BuildContext context) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['customers_update_profile'] = '1';
    map['mobile'] = mob;
    map['fullname'] = name;
    map['city'] = city;
    map['email']= email;

    final response =
    await client
        .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);
    if (response.statusCode == 200) {
      print('Response code - ${response.statusCode}');
      print('Response Body -${response.body}');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update info'),
            content: Text('  Successfully updated '),
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
            title: Text('Update info'),
            content: Text(' Failed to upload '),
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

  String? getNameError(String value) {
    if(value.length <=3 ){
      return 'Name contains atlest 4characters';
    }
    name = value;
    return null;
  }
  String? getCityError(String value) {
    if(value.length <=3 ){
      return 'City contains atlest 4characters';
    }
    city = value;
    return null;
  }
  String? getEmailError(String value) {
    if(value.length <=3 ){
      return 'Name contains atlest 4characters';
    }
    email = value;
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
  @override
  Widget build(BuildContext context) {

    return  Form (
        key: _contatform_key,
        child:
      Scaffold(
      appBar: AppBar(title: Text('Update Profile')),
      body:  Container(
        decoration: BoxDecoration(
          color: Colors.white,),

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Text('Update Profile ', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
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
                          hintText: 'User name',
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
                        validator: (value) => value!.isEmpty ?  'Email cannot be blank' : getEmailError(value),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'E-mail',
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
                        validator: (value) => value!.isEmpty ?  'City cannot be blank' : getCityError(value),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'City',
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
                        print("Update clicked");
                       if(_contatform_key.currentState!.validate()){
                         updateProfile(http.Client(), mobile, name, city, email, context);
                       }
                      },
                      child: new Container(
                        child: Center(
                          child:Text("Update", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
}