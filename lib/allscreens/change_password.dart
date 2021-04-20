import 'package:flutter/material.dart';


class MyChangePassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new _MyChangePasswordState();
  }

}
class _MyChangePasswordState extends State<MyChangePassword>{
  final _forkey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return  Form (
        key: _forkey2,
        child:
        Scaffold(
          appBar:  AppBar(title: Text('Change Password')),
        body:
        Container(
            decoration: BoxDecoration(
              color: Colors.white,),

            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Change Password ', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                          child:
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Old Password',
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
                              hintText: 'New Password',
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
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
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
                            print("SignUp clicked");
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyNavigationBar(),),
                            );*/
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
        )
    );
   /* )
    );*/

  }


}