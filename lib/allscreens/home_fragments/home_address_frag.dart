
import 'dart:convert';
import 'package:flut_app/allscreens/qrcode_creater.dart';
import 'package:flut_app/allscreens/sign_up.dart';
import 'package:http/http.dart' as http;
import 'package:flut_app/allscreens/response_model_classes/address_data_response.dart';
import 'package:flut_app/permissions/location_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clipboard/clipboard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';

class MyAddressHomePage extends StatelessWidget {
  final String phoneno;
  MyAddressHomePage(this.phoneno);
  TextEditingController address1controller = TextEditingController();
  TextEditingController address2controller = TextEditingController();
  TextEditingController landmarkcontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController addresstypecontroller = TextEditingController();
  late String _address1, _address2, _landmark, _city, _district, _country,
      _pincode, _state, _addtype, _sid;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late List<AddressDataResponse> addressDataItemslist;

  Future<List<AddressDataResponse>> getAllAddressByMobile(http.Client client,
      String phoneno) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['address_viewby_mobile'] = '1';
    map['mobileno'] = phoneno;
    final response = await client
        .post(Uri.parse(
        'http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),
        body: map);
    if (response.statusCode == 200) {
      print('Response code - ${response.statusCode}');
      print('Response Body success API -${response.body}');
    }
    else {
      print('Response code else - ${response.statusCode}');
      throw Exception('Unable to fetch Address from the REST API');
    }
    var responseJson = json.decode(response.body);
    return (responseJson['data'] as List).map<AddressDataResponse>((json) =>
        AddressDataResponse.fromJson(json)).toList();
  }

  Future<SignUpSuccessMessage> getFailAddress(http.Client client,
      String phoneno) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['address_viewby_mobile'] = '1';
    map['mobileno'] = phoneno;
    final response = await client
        .post(Uri.parse(
        'http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),
        body: map);
    if (response.statusCode == 200) {
      print('Response code - ${response.statusCode}');
      print('Response Body success API -${response.body}');
      return SignUpSuccessMessage.fromJson(jsonDecode(response.body));
    }
    else {
      print('Response code else - ${response.statusCode}');
      throw Exception('Unable to fetch Address from the REST API');
    }
    //var responseJson = json.decode(response.body);
  }

  Widget flotbutton(BuildContext context1) {
    addressDataItemslist = <AddressDataResponse>[];

    return   FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        showDialog(
            context: context1,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 550,
                  child:  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Add Address',style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.orange),
                          ),
                          Form (
                            key:  _formkey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller:  address1controller,
                                    // obscureText: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Addressline1',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _address1 = value;
                                        print(value+','+_address1);
                                        return 'empty addressline1';
                                      }
                                      else{
                                        _address1 = value;
                                        print(value+','+_address1);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      _address1 = value!;
                                      print(value+','+_address1);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller: address2controller,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Addressline2',
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

                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _address2 = value;
                                        print(value+','+_address2);
                                        return 'empty addressline2';
                                      }
                                      else{
                                        _address2 = value;
                                        print(value+','+_address2);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      _address2 = value!;
                                      print(value+','+_address2);
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller: landmarkcontroller,
                                    decoration: InputDecoration(
                                      hintText: 'Landmark',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _landmark = value;
                                        print(value+','+_landmark);
                                        return 'empty landmark';
                                      }
                                      else{
                                        _landmark = value;
                                        print(value+','+_landmark);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.

                                      _landmark = value!;
                                      print(value+',saved'+_landmark);

                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller:  citycontroller,
                                    decoration: InputDecoration(
                                      hintText: 'city',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _city = value;
                                        print(value+','+_city);
                                        return 'empty city';
                                      }
                                      else{
                                        _city = value;
                                        print(value+','+_city);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {

                                      _city = value!;
                                      print(value+','+_city);

                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller:  districtcontroller,
                                    decoration: InputDecoration(
                                      hintText: 'district',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _district = value;
                                        // print(value+','+_district);
                                        return 'empty city';
                                      }
                                      else{
                                        _district = value;
                                        print(value+','+_district);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      _district = value!;
                                      print(value+','+_district);
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller: statecontroller,
                                    decoration: InputDecoration(
                                      hintText: 'State',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _state = value;
                                        print(value+','+_state);
                                        return 'empty pincode';
                                      }
                                      else{
                                        _state = value;
                                        print(value+','+_state);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {

                                      _state = value!;
                                      print(value+','+_state);

                                    },

                                  ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: pincodecontroller,
                                    decoration: InputDecoration(
                                      hintText: 'Pincode',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _pincode = value;
                                        print(value+','+_pincode);
                                        return 'empty state';
                                      }
                                      else{
                                        _pincode = value;
                                        print(value+','+_pincode);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.

                                      _pincode = value!;
                                      print(value+','+_pincode);

                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller: addresstypecontroller,
                                    decoration: InputDecoration(
                                      hintText: 'AddressType',
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
                                    validator: ( String? value) {
                                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      _addtype = value!;
                                      print(value+','+_addtype);

                                    },

                                  ),
                                ),
                              ],
                            ),
                            //),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                            child:SizedBox(
                              width: 300.0,
                              height: 40.0,
                              child: RaisedButton(
                                  onPressed: () {
                                    print('Added');
                                    if(_formkey.currentState!.validate()){
                                      _address1 = address1controller.text.toString();
                                      _address2 = address2controller.text.toString();
                                      _landmark = landmarkcontroller.text.toString();
                                      _city = citycontroller.text.toString();
                                      _district = districtcontroller.text.toString();
                                      _state = statecontroller.text.toString();
                                      _country = 'India';
                                      _pincode = pincodecontroller.text.toString();
                                      _addtype = addresstypecontroller.text.toString();
                                      int id = addressDataItemslist.length+1;
                                      _sid = id.toString();
                                      print(
                                          address1controller.text
                                              .toString() +
                                              "," + id.toString());

                                      insertAddressbyMobile(http.Client(),_address1,_address2,_landmark,_city,_district,_state,_country,
                                          _pincode,_addtype,phoneno,context1);
                                      Navigator.of(context).pop();

                                    }

                                  },
                                  child: Text(
                                    "Add Adress",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.orange//const Color(0xFF1BC0C5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );

            });

      },
      heroTag: 'alert3',
      tooltip: 'Add address',
      child: const Icon(Icons.add,
          size: 25.0,
          color: Colors.white),
    );
  }

  Future<SignUpSuccessMessage> insertAddressbyMobile(http.Client client, String address1,
      String address2,String landmark,String city,String district,String state
      ,String country,String pincode,String type,String mobile,BuildContext context1) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['address_insert'] = '1';
    map['addressline1'] = address1;
    map['addressline2'] = address2;
    map['landmark'] = landmark;
    map['city'] = city;
    map['district'] = district;
    map['state'] = state;
    map['country'] = country;
    map['pincode'] = pincode;
    map['type'] = type;
    map['mobileno'] =mobile;
    final response =
    await client
        .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);
    if (response.statusCode == 200) {
      showDialog(
        context: context1,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Inserted'),
            content: Text('Address Successfully Inserted'),
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
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        FutureBuilder<List<AddressDataResponse>>(
          future: getAllAddressByMobile(http.Client(), phoneno),
          builder: (context, snapshot) {
            print("enter snapshot");
            if (snapshot.hasError)
              print(snapshot.error);
            return snapshot.hasData
                ? AddressListViewHandelItem(phoneno, snapshot.data!)
                : Center(child: FutureBuilder<SignUpSuccessMessage>(
              future: getFailAddress(http.Client(), phoneno),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.assignment_late_outlined, size: 50,),
                        Text(snapshot.data!.result, style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),),
                        SizedBox(height: 15,),
                        Text(snapshot.data!.message,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: flotbutton(context),
                            ),
                          ],
                        ),
                      ],
                    );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),);
          },
        ),
      ),
    );
  }


}

class AddressListViewHandelItem extends StatefulWidget {
  String phone;
  List<AddressDataResponse> addresslist;

  AddressListViewHandelItem(this.phone, this.addresslist);

  @override
  State<StatefulWidget> createState() {
    return new AddressListViewHandelItemState(addresslist,phone);
  }
}
class AddressListViewHandelItemState extends State<AddressListViewHandelItem>{
  TextEditingController address1controller =  TextEditingController();
  TextEditingController address2controller =  TextEditingController();
  TextEditingController landmarkcontroller =  TextEditingController();
  TextEditingController pincodecontroller =  TextEditingController();
  TextEditingController citycontroller =  TextEditingController();
  TextEditingController districtcontroller =  TextEditingController();
  TextEditingController statecontroller =  TextEditingController();
  TextEditingController addresstypecontroller = TextEditingController();
  late String _address1,_address2,_landmark,_city,_district,_country,_pincode,_state,_addtype,_sid;
  final  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late List<AddressDataResponse> addressDataItemslist;
  late Position _currentPosition;
  static final LatLng _initialcameraposition = LatLng(0.0, 0.10);
  late GoogleMapController _controller;
  Location _location = Location();
  late double lat =0 ,long = 0 ;
  String phone;
  var futureAlbum;
  AddressListViewHandelItemState( this.addressDataItemslist,this.phone);

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }


  _getCurrentLocation() {
    print('current pos ');
    _location.onLocationChanged.listen((l) {
      lat = l.latitude!;
      long = l.longitude!;
      print(l.latitude.toString());
      print(l.longitude.toString());
      print(l.toString());
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        Navigator.of(context).pop();
        break;
      case 'Settings':

      // Navigator.push(context,MaterialPageRoute(builder: (context) => HomeCopyPage());
        break;
    }
  }

  _loadCounter() async {
   // SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _address1 ='';
      _address2 ='';
      _landmark ='';
      _city ='';
      _district;
      _state ='';
      _country='';
      _pincode ='';
      _addtype ='';
     // email = (prefs.getString('email') ?? '');
    });
  }
  Widget flotbutton(){
    return  FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20.0)), //this right here
                child: Container(
                  height: 550,
                  child:  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Add Address',style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.orange),
                          ),
                          Form (
                            key:  _formkey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller:  address1controller,
                                    // obscureText: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Addressline1',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _address1 = value;
                                        print(value+','+_address1);
                                        return 'empty addressline1';
                                      }
                                      else{
                                        _address1 = value;
                                        print(value+','+_address1);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      _address1 = value!;
                                      print(value+','+_address1);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller: address2controller,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Addressline2',
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

                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _address2 = value;
                                        print(value+','+_address2);
                                        return 'empty addressline2';
                                      }
                                      else{
                                        _address2 = value;
                                        print(value+','+_address2);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      _address2 = value!;
                                      print(value+','+_address2);
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller: landmarkcontroller,
                                    decoration: InputDecoration(
                                      hintText: 'Landmark',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _landmark = value;
                                        print(value+','+_landmark);
                                        return 'empty landmark';
                                      }
                                      else{
                                        _landmark = value;
                                        print(value+','+_landmark);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.

                                      _landmark = value!;
                                      print(value+',saved'+_landmark);

                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller:  citycontroller,
                                    decoration: InputDecoration(
                                      hintText: 'city',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _city = value;
                                        print(value+','+_city);
                                        return 'empty city';
                                      }
                                      else{
                                        _city = value;
                                        print(value+','+_city);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {

                                      _city = value!;
                                      print(value+','+_city);

                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller:  districtcontroller,
                                    decoration: InputDecoration(
                                      hintText: 'district',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _district = value;
                                        // print(value+','+_district);
                                        return 'empty city';
                                      }
                                      else{
                                        _district = value;
                                        print(value+','+_district);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      _district = value!;
                                      print(value+','+_district);
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller: statecontroller,
                                    decoration: InputDecoration(
                                      hintText: 'State',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _state = value;
                                        print(value+','+_state);
                                        return 'empty pincode';
                                      }
                                      else{
                                        _state = value;
                                        print(value+','+_state);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {

                                      _state = value!;
                                      print(value+','+_state);

                                    },

                                  ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: pincodecontroller,
                                    decoration: InputDecoration(
                                      hintText: 'Pincode',
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
                                    validator: ( String? value) {
                                      if(value!.isEmpty){
                                        _pincode = value;
                                        print(value+','+_pincode);
                                        return 'empty state';
                                      }
                                      else{
                                        _pincode = value;
                                        print(value+','+_pincode);
                                      }
                                      // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.

                                      _pincode = value!;
                                      print(value+','+_pincode);

                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                  child:
                                  TextFormField(
                                    controller: addresstypecontroller,
                                    decoration: InputDecoration(
                                      hintText: 'AddressType',
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
                                    validator: ( String? value) {
                                      return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                    },
                                    onSaved: (String? value) {
                                      _addtype = value!;
                                      print(value+','+_addtype);

                                    },

                                  ),
                                ),
                              ],
                            ),
                            //),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                            child:SizedBox(
                              width: 300.0,
                              height: 40.0,
                              child: RaisedButton(
                                  onPressed: () {
                                    print('Added');
                                    if(_formkey.currentState!.validate()){
                                      _address1 = address1controller.text.toString();
                                      _address2 = address2controller.text.toString();
                                      _landmark = landmarkcontroller.text.toString();
                                      _city = citycontroller.text.toString();
                                      _district = districtcontroller.text.toString();
                                      _state = statecontroller.text.toString();
                                      _country = 'India';
                                      _pincode = pincodecontroller.text.toString();
                                      _addtype = addresstypecontroller.text.toString();
                                      int id = addressDataItemslist.length+1;
                                      _sid = id.toString();
                                      print(
                                          address1controller.text
                                              .toString() +
                                              "," + id.toString());

                                      insertAddressbyMobile(http.Client(),_address1,_address2,_landmark,_city,_district,_state,_country,
                                          _pincode,_addtype,phone);
                                      Navigator.of(context).pop();

                                    }

                                  },
                                  child: Text(
                                    "Add Adress",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.orange//const Color(0xFF1BC0C5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );

            });

      },
      heroTag: 'alert3',
      tooltip: 'Add address',
      child: const Icon(Icons.add,
          size: 25.0,
          color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar:  AppBar(
        title: Text('Home'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return   new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Card(
            elevation: 5,
         child: Column(
            children: <Widget>[

              Column(
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 5.0),
                        child: Text(
                          addressDataItemslist[position].addressType.toString(),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),//left, top,right,bottom
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              addressDataItemslist[position].addressline1+','+ addressDataItemslist[position].addressline2+','
                                  +addressDataItemslist[position].addresslandmark,
                              style: TextStyle(fontSize: 15.0),
                            ),
                            Text(
                              addressDataItemslist[position].addresscity+','+ addressDataItemslist[position].addressstate+','
                                  + addressDataItemslist[position].addresspincode,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child:
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 25.0,
                              color: Colors.orange,
                            ),
                            onPressed: () {

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0)), //this right here
                                      child: Container(
                                        height: 550,
                                        child: SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                               '  Edit Address',style: TextStyle(
                                                  fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.orange),
                                              ),
                                              Form (
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                                      child:
                                                      TextFormField(
                                                        controller: address1controller = TextEditingController(
                                                          text: addressDataItemslist[position].addressline1
                                                        ),

                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          hintText: 'Addressline1',
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
                                                        validator: ( String? value) {

                                                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                                        },
                                                        onSaved: (String? value) {
                                                          _address1 = value!;
                                                          print(value+','+_address1);

                                                        },

                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                                      child:
                                                      TextFormField(
                                                        controller: address2controller = TextEditingController(
                                                            text: addressDataItemslist[position].addressline2
                                                        ),

                                                        keyboardType: TextInputType.text,
                                                        decoration: InputDecoration(
                                                          hintText: 'Addressline2',
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
                                                        validator: ( String? value) {

                                                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                                        },
                                                        onSaved: (String? value) {
                                                          _address2 = value!;
                                                          print(value+','+_address2);

                                                        },

                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                                      child:
                                                      TextFormField(
                                                        controller: landmarkcontroller = TextEditingController(
                                                            text: addressDataItemslist[position].addresslandmark
                                                        ),

                                                        decoration: InputDecoration(
                                                          hintText: 'Landmark',
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
                                                        validator: ( String? value) {

                                                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                                        },
                                                        onSaved: (String? value) {
                                                          _landmark = value!;
                                                          print(value+','+_landmark);

                                                        },

                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                                      child:
                                                      TextFormField(
                                                        controller: citycontroller = TextEditingController(
                                                            text: addressDataItemslist[position].addresscity
                                                        ),

                                                        decoration: InputDecoration(
                                                          hintText: 'city',
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
                                                        validator: ( String? value) {

                                                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                                        },
                                                        onSaved: (String? value) {
                                                          _city = value!;
                                                          print(value+','+_city);

                                                        },

                                                      ),

                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                                      child:
                                                      TextFormField(
                                                        controller:  districtcontroller = TextEditingController(
                                                            text: addressDataItemslist[position].addressdistict
                                                        ),
                                                        decoration: InputDecoration(
                                                          hintText: 'district',
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
                                                        validator: ( String? value) {

                                                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                                        },
                                                        onSaved: (String? value) {
                                                          _district = value!;
                                                          print(value+','+_district);

                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                                      child:
                                                      TextFormField(
                                                        controller: statecontroller = TextEditingController(
                                                            text: addressDataItemslist[position].addressstate
                                                        ),

                                                        decoration: InputDecoration(
                                                          hintText: 'State',
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
                                                        validator: ( String? value) {

                                                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                                        },
                                                        onSaved: (String? value) {
                                                         _state = value!;
                                                          print(value+','+_state);
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                                      child:
                                                      TextFormField(
                                                        controller: pincodecontroller = TextEditingController(
                                                            text: addressDataItemslist[position].addresspincode
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        decoration: InputDecoration(
                                                          hintText: 'Pincode',
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
                                                        validator: ( String? value) {

                                                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                                        },
                                                        onSaved: (String? value) {
                                                          _pincode = value!;
                                                          print(value+','+_pincode);
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                                      child:
                                                      TextFormField(
                                                        controller: addresstypecontroller = TextEditingController(
                                                            text: addressDataItemslist[position].addressType
                                                        ),

                                                        decoration: InputDecoration(
                                                          hintText: 'AddressType',
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
                                                        validator: ( String? value) {
                                                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                                        },
                                                        onSaved: (String? value) {
                                                          _addtype = value!;
                                                          print(value+','+_addtype);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ), //),
                                              ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                            child: SizedBox(
                                                width: 310.0,
                                                child: RaisedButton(
                                                    onPressed: () {
                                                      print('Edit Address');
                                                      //if(_formkey.currentState!.validate()){
                                                        _address1 = address1controller.text.toString();
                                                        _address2 = address2controller.text.toString();
                                                        _landmark = landmarkcontroller.text.toString();
                                                        _city = citycontroller.text.toString();
                                                        _district = districtcontroller.text.toString();
                                                        _state = statecontroller.text.toString();
                                                        _country = 'India';
                                                        _pincode = pincodecontroller.text.toString();
                                                        _addtype = addresstypecontroller.text.toString();
                                                        int id = addressDataItemslist.length+1;
                                                        _sid = id.toString();
                                                        print(
                                                            address1controller.text
                                                                .toString() +
                                                                "," + id.toString());
                                                        updateAddressbyMobile(http.Client(),addressDataItemslist[position].id,_address1,_address2,_landmark,_city,_district,_state,_country,
                                                            _pincode,_addtype,phone);
                                                        Navigator.of(context).pop();
                                                     // }
                                                    },
                                                    child: Text(
                                                      "Edit Address",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    color: Colors.orange//const Color(0xFF1BC0C5),
                                                ),
                                              ),
                                          ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      ),
                                    );
                                  });

                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 25.0,
                              color: Colors.orange,
                            ),
                            onPressed: () {

                              deleteAlertboxConfirmation(context, 'Delete Address', 'Are you sure',addressDataItemslist[position].id,position);

                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              size: 25.0,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              setState(() {
                                FlutterClipboard.copy( addressDataItemslist[position].addressline1+','+ addressDataItemslist[position].addressline2+','
                                    +addressDataItemslist[position].addresslandmark+","+addressDataItemslist[position].addresscity+','+ addressDataItemslist[position].addressstate+','
                                    + addressDataItemslist[position].addresspincode).then(( value ) =>
                                    print('copied'));
                                final snackBar = SnackBar(
                                  content: Text('copied'),
                                  duration: Duration(seconds: 5),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.share,
                              size: 25.0,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              setState(() {
                                Share.share('https://flutter.com');
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.location_pin,
                              size: 25.0,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              setState(() {
                                print(lat);
                                print(long);
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>MapScreen02( addressDataItemslist[position].addressline1,
                                     addressDataItemslist[position].addressline2,  addressDataItemslist[position].addresslandmark,
                                    addressDataItemslist[position].addresscity, addressDataItemslist[position].addressstate,
                                    addressDataItemslist[position].addresspincode,addressDataItemslist[position].addressType,
                                   lat, long)
                                 ),
                                );
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.dashboard_outlined,
                              size: 25.0,
                              color: Colors.orange,
                            ),
                            onPressed: () {
                              setState(() {
                                print(lat);
                                print(long);
                                Navigator.push(context, MaterialPageRoute(builder: (context) =>QRCreatePage( addressDataItemslist[position].addressline1,
                                    addressDataItemslist[position].addressline2,  addressDataItemslist[position].addresslandmark,
                                    addressDataItemslist[position].addresscity, addressDataItemslist[position].addressstate,
                                    addressDataItemslist[position].addresspincode,addressDataItemslist[position].addressType,
                                    lat, long)
                                ),
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),     /*Divider(
                height: 2.0,
                color: Colors.grey,
              )*/
            ],
          )
          )
          );
        },
        itemCount: addressDataItemslist.length,
      ),
      floatingActionButton:
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: flotbutton(),
          ),
        ],
      ),
    );


  }


  deleteAlertboxConfirmation(BuildContext context,String title,String description, String id, int position,) {

    /*this is the alert box which used to show to user whenever delete icon clicked.
    * If user  confirms to delete than clcik Ok */
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: <Widget>[
            FlatButton(
              child: Text("YES"),
              onPressed: () {
                deleteAddress(http.Client(),id , context);
                setState(() {
                  addressDataItemslist.removeAt(position);
                  Navigator.of(context).pop();
                });
              },
            ),
            FlatButton(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<SignUpSuccessMessage> insertAddressbyMobile(http.Client client, String address1,
      String address2,String landmark,String city,String district,String state
      ,String country,String pincode,String type,String mobile) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['address_insert'] = '1';
    map['addressline1'] = address1;
    map['addressline2'] = address2;
    map['landmark'] = landmark;
    map['city'] = city;
    map['district'] = district;
    map['state'] = state;
    map['country'] = country;
    map['pincode'] = pincode;
    map['type'] = type;
    map['mobileno'] =mobile;

    final response =
    await client
        .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);
    if (response.statusCode == 200) {

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Inserted'),
            content: Text('Address Successfully Inserted'),
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
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }



  Future<SignUpSuccessMessage> updateAddressbyMobile(http.Client client, String id, String address1,
      String address2,String landmark,String city,String district,String state
      ,String country,String pincode,String type,String mobile) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['address_update'] = '1';
    map['id']= id;
    map['addressline1'] = address1;
    map['addressline2'] = address2;
    map['landmark'] = landmark;
    map['city'] = city;
    map['district'] = district;
    map['state'] = state;
    map['country'] = country;
    map['pincode'] = pincode;
    map['type'] = type;
    map['mobileno'] =mobile;

    final response =
    await client
        .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Updated'),
            content: Text('Address Successfully Updated'),
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
      //successAlertbox(context, 'Updated ', 'Address Successfully Updated');
      return SignUpSuccessMessage.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  Future<SignUpSuccessMessage> deleteAddress(http.Client client,String id, BuildContext context) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['address_delete'] = '1';
    map['id'] = id;
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
}


