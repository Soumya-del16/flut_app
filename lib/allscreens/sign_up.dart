import 'package:flut_app/Constants.dart';
import 'package:flut_app/allscreens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


Future<SignUpSuccessMessage> createDigiAddressUser(http.Client client,String mob,String fullname, BuildContext context) async {
  var map = new Map<String, dynamic>();
  map['accesskey'] = '1234';
  map['customer_reg'] = '1';
  map['mobile'] = mob;
  map['fullname'] = fullname;

  final response =
  await client
      .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);
  if (response.statusCode == 200) {

    return SignUpSuccessMessage.fromJson(jsonDecode(response.body));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class SignUpSuccessMessage {
  final String result;
  final String message;
  SignUpSuccessMessage({ required this.result, required this.message});

  factory SignUpSuccessMessage.fromJson(Map<String, dynamic> json) {
    return SignUpSuccessMessage(
        result: json['result'],
        message: json['message']
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen>{
  final _signupformkey = GlobalKey<FormState>();
  late String _phone,_name;
  late Future<SignUpSuccessMessage> futureAlbum;
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
    _phone = value;
    return null;
  }


  String? getNameError(String value) {
    if(value.length <=3 ){
      return 'Name contains atlest 4characters';
    }
    _name = value;
    return null;
  }

  @override
  Widget build(BuildContext context) {
   return
      Form (
      key: _signupformkey,
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
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child:  Icon(Icons.arrow_back,size: 30,),
              ),

              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('SignUp', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
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
                height: 50.0,
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
            ]
          ),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
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
                                    hintText: 'Mobile Number',
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
                          SizedBox(height: 40,),
                         InkWell(
                           onTap: (){
                             if(_signupformkey.currentState!.validate()){
                               HttpOverrides.global = new MyHttpOverrides();
                               futureAlbum = createDigiAddressUser(http.Client(), _phone, _name,context);
                               showDialog(context: context,
                                   builder: (BuildContext context){
                                     return
                                       CustomDialogBox(
                                         text: "Ok", signup: futureAlbum,
                                       );
                                   }
                               );
                             }
                           },
                           child:  Container(
                             height: 50,
                             margin: EdgeInsets.symmetric(horizontal: 5),
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(2.0),
                                 color: Colors.orange
                             ),
                             child: Center(
                               child: Text("SignUp", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                             ),
                           ),
                         ),
                          SizedBox(height: 20,),
                          Container(height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 70),
                            child: Center(
                              child:Row(
                                children: [
                                  Text("Already have an account?", style: TextStyle(color: Colors.grey,fontSize: 16),),

                                  InkWell(
                                    onTap: (){
                                      print("SignUp clicked");
                                        /*user can go back to previoue layout from present layout of the application */
                                        Navigator.pop(context, true);
                                    },
                                    child: new Container(
                                      child: Center(
                                        child:Text(" Login", style: TextStyle(color: Colors.deepOrange,fontSize: 16),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ),
                          ),
                          SizedBox(height: 30,)
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
class MyHttpOverrides extends HttpOverrides{
  @override
   Future<HttpClient> createHttpclient(SecurityContext context) async => super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
}

class CustomDialogBox extends StatefulWidget {
  final String text;
  // Image img;
  Future<SignUpSuccessMessage> signup;

   CustomDialogBox({ required this.signup,required this.text});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FutureBuilder<SignUpSuccessMessage>(
                future: widget.signup,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return
                      Column(
                        children: [
                        Text(snapshot.data!.result,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                          SizedBox(height: 15,),
                          Text(snapshot.data!.message,style: TextStyle(fontSize: 14),textAlign: TextAlign.center,),
                        ],
                      );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              ),

              SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(widget.text,style: TextStyle(fontSize: 18),)),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/fluttericon.png")
            ),
          ),
        ),
      ],
    );
  }
}

