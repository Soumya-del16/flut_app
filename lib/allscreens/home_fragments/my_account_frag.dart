import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flut_app/allscreens/about_us.dart';
import 'package:flut_app/allscreens/change_password.dart';
import 'package:flut_app/allscreens/contact_us.dart';
import 'package:flut_app/allscreens/home_fragments/my_profile_frag.dart';
import 'package:flut_app/allscreens/privacy_policy.dart';
import 'package:flut_app/allscreens/terms_and_cond.dart';
import 'package:flut_app/allscreens/update_profile.dart';



class MyAcountScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MyAcountScreenState();
  }

}

class _MyAcountScreenState extends State<MyAcountScreen>{

  PickedFile? _imageFile11 ;
  bool isVideo1 = false;
  VideoPlayerController? _controller11;

  String? _retrieveDataError11;
  dynamic _pickImageError11;
  final ImagePicker _picker11 = ImagePicker();
  final TextEditingController maxWidthController11 = TextEditingController();
  final TextEditingController maxHeightController11 = TextEditingController();
  final TextEditingController qualityController11 = TextEditingController();

  Future<void> _playVideo(PickedFile? file) async {
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        Navigator.of(context).pop();
        break;
      case 'Settings':
        break;
    }
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext? context}) async {
    if (_controller11 != null) {
      await _controller11!.setVolume(0.0);
    }
    print('rgdf');
    if (isVideo1) {
      final PickedFile? file = await _picker11.getVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    } else {
      await _displayPickImageDialog2(context!,
              (double? maxWidth, double? maxHeight, int? quality) async {
            try {
              final pickedFile = await _picker11.getImage(
                source: source,
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                imageQuality: quality,
              );
              setState(() {
                _imageFile11 = pickedFile;
              });
            } catch (e) {
              setState(() {
                _pickImageError11 = e;
              });
            }
          });
    }

  }

  @override
  void dispose() {

    maxWidthController11.dispose();
    maxHeightController11.dispose();
    qualityController11.dispose();
    super.dispose();
  }

  Widget _previewImage() {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile11 != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        return Image.network(_imageFile11!.path);
      } else {
        return Semantics(
            child: Image.file(File(_imageFile11!.path)),
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError11 != null) {
      return Text(
        'Pick image error: $_pickImageError11',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker11.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {

      setState(() {
        _imageFile11 = response.file;
      });

    } else {
      _retrieveDataError11 = response.exception!.code;
    }
  }
  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError11 != null) {
      final Text result = Text(_retrieveDataError11!);
      _retrieveDataError11 = null;
      return result;
    }
    return null;
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(padding:EdgeInsets.all(20),
                        child: InkWell(
                          onTap: (){
                            isVideo1 = false;
                            _onImageButtonPressed(ImageSource.camera,context: context);
                           // Navigator.of(context).pop();
                          },
                          child: Text('Camera',style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                        ),
                      ),
                      Padding(padding:EdgeInsets.all(20),
                          child: InkWell(
                            onTap: (){
                              isVideo1 = false;
                              _onImageButtonPressed(ImageSource.gallery,context: context);
                             // Navigator.of(context).pop();
                            },
                            child: Text('Gallery',style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                          )
                      )
                    ],
                  )

                ],
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        // backgroundColor: Colors.orange
      ),
      body: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                //MyProfileWidget(),
            Padding(
               padding: EdgeInsets.all(20),
               child: CircleAvatar(
                 radius: 52,
                 backgroundColor: Color(0xffFDCF09),
                 child: _imageFile11 != null
                     ? ClipRRect(
                     borderRadius: BorderRadius.circular(50),
                     child: _previewImage()
                 )
                     : Container(
                   decoration: BoxDecoration(
                       color: Colors.grey[200],
                       borderRadius: BorderRadius.circular(50)),
                   width: 100,
                   height: 100,
                   child: Icon(
                     Icons.camera_alt,
                     color: Colors.grey[800],
                   ),
                 ),
               )
             ),

                InkWell(
                  onTap: (){
                    print("SignUp clicked");
                  },
                  child:
                  Semantics(label: 'image_picker_example_from_gallery',
                    child:FloatingActionButton(
                    onPressed: () {
                      _showPicker(context);
                    },
                    heroTag: 'image1',
                    tooltip: 'Take a Photo',
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
                ),

                InkWell(
                  onTap: (){
                    print(" clicked");
                    Navigator.push(context,MaterialPageRoute(builder: (context) => MyUpdateProfile()),
                    );
                  },
                  child:
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Update Profile', style: TextStyle(color: Colors.orange, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  ),
                ),
              ],
            ),

        InkWell(
          onTap: (){
            print(" clicked");
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyChangePassword()),
            );
          },
          child:
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('Change Password', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
          ),
        ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
        InkWell(
          onTap: (){
            print(" clicked");
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyContactUs()),
            );
          },
          child:
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('Contact Us', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
          ),
        ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
        InkWell(
          onTap: (){
            print(" clicked");
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyPrivacyPolicy()),
            );
          },
          child:
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('Privacy Policy', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
          ),
        ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
        InkWell(
          onTap: (){
            print(" clicked");
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyTermsCond()),
            );
          },
          child:
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('Terms and Conditions', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
          ),
        ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
        InkWell(
          onTap: (){
            print(" clicked");
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyAboutus()),
            );
          },
          child:
          Padding(
            padding: EdgeInsets.all(20),
            child: Text('About Us', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
          ),
        ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
            InkWell(
              onTap: (){
                print(" Logout");
                Navigator.pop(context);
              },
              child:
              Padding(
                padding: EdgeInsets.all(20),
                child: Text('Logout', style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              ),
            ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
            SizedBox(height: 40,),
       /* Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 30),
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
                Navigator.pop(context);
              },
              child: new Container(
                child: Center(
                  child:Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                ),
              ),
            ),
            //,
          ),
        ),*/

      ]
      ),
    );
  }


  Future<void> _displayPickImageDialog2(
      BuildContext context, OnPickImageCallback2 onPick) async {
    return showDialog(context: context,
        builder: (context) {
          return AlertDialog(title: Text('Add optional parameters'), content: Column(children: <Widget>[
            TextField(controller: maxWidthController11, keyboardType: TextInputType.numberWithOptions(decimal: true), decoration:
            InputDecoration(hintText: "Enter maxWidth if desired"),
            ),
            TextField(controller: maxHeightController11, keyboardType: TextInputType.numberWithOptions(decimal: true), decoration:
            InputDecoration(hintText: "Enter maxHeight if desired"),),
            TextField(controller: qualityController11, keyboardType: TextInputType.number, decoration:
            InputDecoration(hintText: "Enter quality if desired"),),],
          ),
            actions: <Widget>[
              TextButton(child: const Text('CANCEL'), onPressed: () {
                Navigator.of(context).pop();},),
              TextButton(child: const Text('PICK'), onPressed: () {
                double? width = maxWidthController11.text.isNotEmpty
                    ? double.parse(maxWidthController11.text) : null;
                double? height = maxHeightController11.text.isNotEmpty ? double.parse(maxHeightController11.text) : null;
                int? quality = qualityController11.text.isNotEmpty ? int.parse(qualityController11.text) : null;
                onPick(width, height, quality);
                Navigator.of(context).pop();
              }),],);});
  }
}

typedef void OnPickImageCallback2(
    double? maxWidth, double? maxHeight, int? quality);