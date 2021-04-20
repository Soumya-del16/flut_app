import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen02 extends StatefulWidget {
  late String add1;
  final String add2;
  final  String landmark;
  final String city;
  final String state;
  final String pincode;
  final String type;
  final double lant;
  final double long;

  MapScreen02(this.add1, this.add2, this.landmark, this.city, this.state,
      this.pincode, this.type,this.lant,this.long) ;

  @override
  _MapScreen02State createState() => _MapScreen02State();
}

class _MapScreen02State extends State<MapScreen02> {
  late GoogleMapController mapController;
  late Position _currentPosition;
  late double totaldist = 0;

  late String addresssting = widget.add1+','+widget.add2+','+widget.landmark+','+widget.city+','+widget.state+','+widget.pincode;
  late String searchAdd;
  final Set<Marker> _markers = {};


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddmarkerCurrentLocation();
  }
  _getAddmarkerCurrentLocation() {
     double lati = widget.lant ;
    double log = widget.long ;
    LatLng _initialcameraposition = LatLng(lati,log );
    final LatLng _currentMyPosition = _initialcameraposition;
    setState(() {
      if(lati!= 0.0) {
        _markers.add(Marker(
          markerId: MarkerId(_currentMyPosition.toString()),
          position: _currentMyPosition,
          infoWindow: InfoWindow(
              title: 'Mylocation',
              snippet: 'Welcome to mylocation'
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition:
            CameraPosition(target: LatLng(widget.lant, widget.long), zoom: 5.0),
            markers: _markers,
          ),
          Positioned(
            right: 15,
            left: 15,
            bottom: 30,
            child: Container(
              height: 50,
              transformAlignment : AlignmentDirectional.center,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Text('Total Distance : '+ totaldist.toString()+'Kilometers',
                style: TextStyle(color:  Colors.black, fontSize: 16.0,fontWeight: FontWeight.bold),
                textAlign : TextAlign.center,
              ),
              ),
            ),
        ],
      ),
    );
  }

  searchnavigate() {
    locationFromAddress(searchAdd).then((result) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(result[0].latitude, result[0].longitude),
        zoom: 10,
      )));
    });
  }

  void onMapCreated(controller) {
    setState(() async {
      mapController = controller;
      List<Location> locations = await locationFromAddress("Warangal, telangana");
      print(locations.toString());
      print('location'+':'+locations.toString());
      locationFromAddress(addresssting).then((result) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(result[0].latitude, result[0].longitude),
          zoom: 9,
        )));
        _getAddressLocation(result[0].latitude, result[0].longitude);
        double lati = widget.lant ;
        double log = widget.long ;
          totaldist = calculateDistance(
              lati, log, result[0].latitude, result[0].longitude);
      });
    });
  }

  _getAddressLocation(double latitu,double longi) {
    setState(() {
      LatLng _initialcameraposition1 = LatLng(latitu,longi );
       final LatLng _currentAddressPosition1 = _initialcameraposition1;

      _markers.add(Marker(
        markerId: MarkerId(_currentAddressPosition1.toString()),
        position: _currentAddressPosition1,
        infoWindow: InfoWindow(
            title: 'Destination',
            snippet: 'End'
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

    double calculateDistance(lat1, lon1, lat2, lon2){
    if(lat1 != 0.0){
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 - c((lat2 - lat1) * p)/2 +
          c(lat1 * p) * c(lat2 * p) *
              (1 - c((lon2 - lon1) * p))/2;
      return 12742 * asin(sqrt(a));
    }
    else {
      return 0.0;

    }
  }
}