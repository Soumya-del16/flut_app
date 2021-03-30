import 'package:flut_app/allscreens/login_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
   return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen>{
  final _signupformkey = GlobalKey<FormState>();


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
              /*Column(children: <Widget>[

              ],),*/
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
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Mail-ID',
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
                          SizedBox(height: 40,),
                          Container(
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
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
