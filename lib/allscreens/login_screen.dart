

import 'package:flut_app/allscreens/navi_home.dart';
import 'package:flut_app/allscreens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'forgot_pass.dart';

class LoginPage extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form (
        key: _formkey,
        child:
        Scaffold(
          body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [Colors.yellow, Colors.orangeAccent, Colors.yellow]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Login', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            SizedBox(height: 10),
            Stack(
              overflow: Overflow.visible,
              alignment: AlignmentDirectional.topCenter,
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
                Positioned(
                  top: -50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:
                    NetworkImage('https://picsum.photos/250?image=2'),
                  ),
                ),
                 // ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,),

                child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Welcome!', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                          child:
                          TextFormField(
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
                            decoration: InputDecoration(
                              hintText: 'Password',
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
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        print("SignUp clicked");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyForgotPassword()),
                        );
                      },
                      child: new Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Center(

                          child:Text("Forgot Password", style: TextStyle(color: Colors.grey,fontSize: 16),),
                        ),
                      ),
                    ),
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
                            print("SignUp clicked");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyNavigationBar(),),
                            );
                          },
                          child: new Container(
                            child: Center(
                              child:Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        //,
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      child: Center(
                        child:Row(
                          children: [
                            Text("Don't have an account?", style: TextStyle(color: Colors.grey,fontSize: 16),),
                            InkWell(
                              onTap: (){
                                print("SignUp clicked");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                                );
                              },
                              child: new Container(
                                child: Center(
                                  child:Text("SignUp", style: TextStyle(color: Colors.deepOrange,fontSize: 16),),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
            )
          ],

        ),
      ),
        ),
    );
  }
}

