
import 'package:flut_app/allscreens/response_model_classes/address_data_response.dart';
import 'package:flut_app/permissions/location_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clipboard/clipboard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';

class AddressListViewHandelItem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new AddressListViewHandelItemState();
  }

}

class AddressDataViewModel {
  List<AddressDataResponse> addressDataItemslist;
  AddressDataViewModel({ required this.addressDataItemslist});

  getAddressData() =>
      <AddressDataResponse>[
        AddressDataResponse(
            addressid: 1,
            addressType: 'Temple',
            addressline1: 'Pochamma Temple',
          addressline2: 'Musi Nagar',
          addresslandmark: 'Malakpet',
          addresscity: 'Hyderabad',
          addressstate: 'Telangana',
          addresspincode: ' 500024'
        ),
        AddressDataResponse(
          addressid: 2,
            addressType: 'Office',
          addressline1: ' TCS plat no1',
          addressline2: '',/*Deccan Park*/
          addresslandmark: 'Software Units Layout',
          addresscity: 'Madhapur',
          addressstate: 'Telangana',
          addresspincode: '500081',
        ),
        AddressDataResponse(
          addressid: 3,
          addressType: 'Relatives Home',
          addressline1: 'Hno: 17-11-244/2 ',
          addressline2: '',
          addresslandmark: 'Subash nagar',
          addresscity: 'Ursu,bodrai,warangal',
          addressstate: 'Telangana',
          addresspincode: '506002',
        )
      ];

}

class AddressListViewHandelItemState extends State<AddressListViewHandelItem>{
  TextEditingController address1controller =  TextEditingController();
  TextEditingController address2controller =  TextEditingController();
  TextEditingController landmarkcontroller =  TextEditingController();
  TextEditingController pincodecontroller =  TextEditingController();
  TextEditingController citycontroller =  TextEditingController();
  TextEditingController statecontroller =  TextEditingController();
  TextEditingController addresstypecontroller = TextEditingController();
  late String _address1,_address2,_landmark,_city,_pincode,_state,_addtype;
  final  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _addresssenderData = AddressDataViewModel(addressDataItemslist: []);
  late List<AddressDataResponse> addressDataItemslist;
  late Position _currentPosition;
  static final LatLng _initialcameraposition = LatLng(0.0, 0.10);
  late GoogleMapController _controller;
  Location _location = Location();
  late double lat =0 ,long = 0 ;
  //Key key =  Key('deyails');
  @override
  void initState() {
    super.initState();
    addressDataItemslist =  _addresssenderData.getAddressData();

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
      _state ='';
      _pincode ='';
      _addtype ='';
     // email = (prefs.getString('email') ?? '');
    });
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
          return Column(
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
                                                ),
                                                //),
                                              ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
                                            child: SizedBox(
                                                width: 310.0,
                                                child: RaisedButton(
                                                    onPressed: () {
                                                      print('Edit Address');
                                                      _address1 = address1controller.text.toString();
                                                      _address2 = address2controller.text.toString();
                                                      _landmark = landmarkcontroller.text.toString();
                                                      _city = citycontroller.text.toString();
                                                      _state = statecontroller.text.toString();
                                                      _pincode = pincodecontroller.text.toString();
                                                      _addtype = addresstypecontroller.text.toString();
                                                      int id = addressDataItemslist.length+1;
                                                      setState(() {
                                                        if (_address1.isEmpty &&
                                                            _address2.isEmpty &&
                                                            _landmark.isEmpty &&
                                                            _city.isEmpty && _state.isEmpty &&
                                                            _pincode.isEmpty &&
                                                            _addtype.isEmpty) {
                                                          print('fil all fields');
                                                        }
                                                        else {

                                                          addressDataItemslist.removeAt(position);
                                                          AddressDataResponse ad1 = new AddressDataResponse(
                                                            addressid: id,
                                                            addressType: _addtype,
                                                            addressline1: _address1,
                                                            addressline2: _address2,
                                                            addresslandmark: _landmark,
                                                            addresscity: _city,
                                                            addressstate: _state,
                                                            addresspincode: _pincode,
                                                          );


                                                          addressDataItemslist.insert(position, ad1);

                                                          address1controller.clear();
                                                          address2controller.clear();
                                                          landmarkcontroller.clear();
                                                          citycontroller.clear();
                                                          statecontroller.clear();
                                                          pincodecontroller.clear();
                                                          addresstypecontroller.clear();
                                                          Navigator.of(context).pop();
                                                        }
                                                      });
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
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                addressDataItemslist.removeAt(position);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.copy,
                              size: 25.0,
                              color: Colors.grey,
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
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                print("Qr create Request");
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
                              color: Colors.grey,
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
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              )
            ],
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
            child: FloatingActionButton(
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
                                  '  Add Address',style: TextStyle(
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

                                              }
                                              else{
                                                _address1 = value;
                                                print(value+','+_address1);
                                              }
                                             // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                            },
                                            onSaved: (String? value) {
                                              // This optional block of code can be used to run
                                              // code when the user saves the form.

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

                                              }
                                              else{
                                                _address2 = value;
                                                print(value+','+_address2);
                                              }
                                              // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                            },
                                            onSaved: (String? value) {
                                              // This optional block of code can be used to run
                                              // code when the user saves the form.

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

                                              }
                                              else{
                                                _city = value;
                                                print(value+','+_city);
                                              }
                                              // return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                                            },
                                            onSaved: (String? value) {
                                              // This optional block of code can be used to run
                                              // code when the user saves the form.

                                              _city = value!;
                                              print(value+','+_city);

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
                                              // This optional block of code can be used to run
                                              // code when the user saves the form.

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
                                      _address1 = address1controller.text.toString();
                                      _address2 = address2controller.text.toString();
                                      _landmark = landmarkcontroller.text.toString();
                                      _city = citycontroller.text.toString();
                                      _state = statecontroller.text.toString();
                                      _pincode = pincodecontroller.text.toString();
                                      _addtype = addresstypecontroller.text.toString();
                                      int id = addressDataItemslist.length+1;
                                      setState(() {
                                        if (_address1.isEmpty &&
                                            _address2.isEmpty &&
                                            _landmark.isEmpty &&
                                            _city.isEmpty && _state.isEmpty &&
                                            _pincode.isEmpty &&
                                            _addtype.isEmpty) {
                                        }
                                        else {
                                          print(
                                              address1controller.text
                                                  .toString() +
                                                  "," + id.toString());

                                          AddressDataResponse ad1 = new AddressDataResponse(
                                            addressid: id,
                                            addressType: _addtype,
                                            addressline1: _address1,
                                            addressline2: _address2,
                                            addresslandmark: _landmark,
                                            addresscity: _city,
                                            addressstate: _state,
                                            addresspincode: _pincode,
                                          );

                                          addressDataItemslist.add(ad1);
                                          address1controller.clear();
                                          address2controller.clear();
                                          landmarkcontroller.clear();
                                          citycontroller.clear();
                                          statecontroller.clear();
                                          pincodecontroller.clear();
                                          addresstypecontroller.clear();
                                         // addressDataItemslist.indexOf(element)
                                          Navigator.of(context).pop();

                                        }


                                      });
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
            ),
          ),
        ],
      ),
    );

  }

}