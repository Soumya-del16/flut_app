import 'package:flutter/material.dart';

class MyContactUs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new _MyContactUsState();
  }

}

class _MyContactUsState extends State<MyContactUs>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                        hintText: 'Email',
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
    );
  }
}