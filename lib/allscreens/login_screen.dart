

import 'dart:convert';
import 'dart:io';

import 'package:flut_app/allscreens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'forgot_pass.dart';
import 'package:http/http.dart' as http;
import 'package:flut_app/allscreens/home_fragments/home_address_frag.dart';
import 'package:flut_app/allscreens/home_fragments/my_account_frag.dart';
import 'package:flut_app/allscreens/home_fragments/notification_frag.dart';


class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return new  _LoginPageState();
  }

}
late String _phone;
class _LoginPageState extends State<LoginPage> {

  final List<_PositionItem> _positionItems = <_PositionItem>[];


   @override
  void initState() {
    super.initState();
    _pemission_for_location();
  }

  void _pemission_for_location () async{
    await Geolocator.requestPermission().then((value) => {
      _positionItems.add(_PositionItem(
          _PositionItemType.permission, value.toString()))
    });
  }

  Future<List<LoginData>> loginDigiAPI(http.Client client, BuildContext context, String phone,) async {

    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['customers_login'] = '1';
    map['mobile'] = phone;
    final response = await client
        .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);

    if (response.statusCode == 200){
      print('Response code - ${response.statusCode}');
      print('Response Body -${response.body}');

      Fluttertoast.showToast(
          msg: "Login successful",
          toastLength: Toast.LENGTH_SHORT);

      Navigator.push(context,MaterialPageRoute(builder: (context) => MyNavigationBar()),
      );
    }
    else{
      print('Response code else - ${response.statusCode}');
      Fluttertoast.showToast(
          msg: 'Login Failed due to  ${response.statusCode} ',
          toastLength: Toast.LENGTH_SHORT);
      throw Exception('Unable to fetch Address from the REST API');

    }
    // Use the compute function to run parsePhotos in a separate isolate.
    var responseJson = json.decode(response.body);

    return (responseJson['data']as List).map<LoginData>((json) => LoginData.fromJson(json)).toList();

  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    String? getErrormessage(String value) {
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

    return
        Scaffold(
          body:
          Container(
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
                  child:
                  Form (
                    key: _formKey,
                    //autovalidate: _autoValidate,
                    child:Padding(
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
                           // controller: numbercontroller,
                            validator: (value) => value!.isEmpty ?  getErrormessage(value) : getErrormessage(value),
                            keyboardType: TextInputType.number,
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
                      ],
                    ),
                    //),
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyForgotPassword()),
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
                            if(_formKey.currentState!.validate()){
                              loginDigiAPI(http.Client(),context,_phone);
                            }
                            else{
                              print("Unsuccessful");
                            }
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
                            Text("Don't have an account? ", style: TextStyle(color: Colors.grey,fontSize: 16),),
                            InkWell(
                              onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()),
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
            ),
            )
          ],

        ),
      ),
    );
  }
}
enum _PositionItemType {
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

//Login using API



class LoginData {

  final String fullname;
  final String mobile;
  final String email;
  final String image;
  final String city;
  final String id;

  LoginData({ required this.id,required this.fullname,required this.mobile,required this.email, required this.image, required this.city});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'],
      fullname: json['fullname'] as String,
      mobile: json['mobile'] as String,
      email: json['email'] as String,
      image: json['image'] as String,
      city: json['city'] as String,
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'id' : id,
        'fullname': fullname,
        'mobile': mobile,
        'email': email,
        'image': image,
        'city': city,
      };
}



class MyNavigationBar extends StatefulWidget {
  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {

   int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MyAddressHomePage(_phone),
    MyNotificationRecyclerClass(),
    MyAccountScreen(_phone),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

@override
  void initState() {
  HttpOverrides.global = new MyHttpOverrides();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.orange
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                title: Text('Notifications'),
                backgroundColor: Colors.orange

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('My Account'),
              backgroundColor: Colors.orange,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 3
      ),
    );
  }


}

