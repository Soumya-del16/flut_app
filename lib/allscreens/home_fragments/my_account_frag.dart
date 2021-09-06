import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flut_app/allscreens/login_screen.dart';
import 'package:flut_app/allscreens/sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
import 'package:http/http.dart' as http;
import 'package:flut_app/allscreens/update_profile.dart';



class MyAccountScreen extends StatefulWidget{
  String phoneno;
  //String imageurl;
  MyAccountScreen(this.phoneno);

  @override
  State<StatefulWidget> createState() {
    return new _MyAccountScreenState();
  }

}
class ImageResponse {
  final String result;
  final String message;
  ImageResponse({ required this.result, required this.message});

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(
        result: json['result'],
        message: json['message']
    );
  }
}


class _MyAccountScreenState extends State<MyAccountScreen>{

  PickedFile? _imageFile11 ;
  bool isVideo1 = false;
  VideoPlayerController? _controller11;
  String? _retrieveDataError11;
  dynamic _pickImageError11;
  final ImagePicker _picker11 = ImagePicker();
  final TextEditingController maxWidthController11 = TextEditingController();
  final TextEditingController maxHeightController11 = TextEditingController();
  final TextEditingController qualityController11 = TextEditingController();
  late Future<List<LoginData>> logindata ;

  var im;


  @override
  void initState() {
    logindata = logImage(http.Client());
    //getImage();
    super.initState();
  }
  Future<ImageResponse> updateImage(http.Client client,String mob,String base64, BuildContext context) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['customers_update_image'] = '1';
    map['mobile'] = mob;
    map['image'] = base64;

    final response =
    await client
        .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);
    if (response.statusCode == 200) {
      print('Response code - ${response.statusCode}');
      print('Response Body -${response.body}');
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Image uploaded'),
            content: Text(' Image Successfully sent '),
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
      return ImageResponse.fromJson(jsonDecode(response.body));
    } else {
      Navigator.of(context).pop();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Image'),
            content: Text('Failed'),
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
      throw Exception('Failed to load album');
    }
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
    else {
    /*  await _displayPickImageDialog2(context!,
              (double? maxWidth, double? maxHeight, int? quality) async {*/
            try {
              final pickedFile = await _picker11.getImage(
                source: source,
                maxWidth: 400,
                maxHeight: 400,
                imageQuality: 99,
              );
              setState(() async {
                _imageFile11 = pickedFile;
                List<int> imageBytes = await _imageFile11!.readAsBytes();
                print('imagebytes: ');
                print(imageBytes);
                String base64Image = base64Encode(imageBytes);
                print('base64 : '+base64Image);
                updateImage(http.Client(), widget.phoneno, base64Image, context!);
              });
            } catch (e) {
              setState(() {
                _pickImageError11 = e;
              });
            }
         // });
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
          return Image.network(_imageFile11!.path);
        } else {
          return Semantics(
              child: Image.file(File(_imageFile11!.path)),
              label: 'image_picker_example_picked_image');
        }
      }
      else if (_pickImageError11 != null) {
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
                           // updateImage(http.Client, widget.phoneno,base64image, context);
                          },
                          child: Text('Camera',style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                        ),
                      ),
                      Padding(padding:EdgeInsets.all(20),
                          child: InkWell(
                            onTap: (){
                              isVideo1 = false;
                              _onImageButtonPressed(ImageSource.gallery,context: context);

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
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(50),
                     child: FutureBuilder<List<LoginData>>(
                     future: logindata,
                     builder: (context, snapshot) {
                       if (snapshot.hasData) {
                         return  Semantics(
                             child:Image.network('http://www.intellicloudapp.com/digitaladdress/'+snapshot.data![0].image)
                         );
                       } else if (snapshot.hasError) {
                         return Icon(
                           Icons.camera_alt,
                           color: Colors.grey[800],
                         );

                       }
                       return CircularProgressIndicator();
                     },

                   ),)
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
            Navigator.push(context,MaterialPageRoute(builder: (context) => MyContactUs(widget.phoneno)),
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

      ]
      ),
    );
  }

  Future<List<LoginData>> logImage(http.Client client) async {
    var map = new Map<String, dynamic>();
    map['accesskey'] = '1234';
    map['customers_login'] = '1';
    map['mobile'] = widget.phoneno;
    final response = await client
        .post(Uri.parse('http://www.intellicloudapp.com/digitaladdress/digitaladdressapp.php'),body: map);

    if (response.statusCode == 200){
      print('Response code - ${response.statusCode}');
      print('Response Body -${response.body}');
    }
    else{
      print('Response code else - ${response.statusCode}');
      /*Fluttertoast.showToast(
          msg: 'Login Failed due to  ${response.statusCode} ',
          toastLength: Toast.LENGTH_SHORT);
*/
      throw Exception('Unable to fetch Address from the REST API');

    }
    // Use the compute function to run parsePhotos in a separate isolate.
    var responseJson = json.decode(response.body);
    return (responseJson['data']as List).map<LoginData>((json) => LoginData.fromJson(json)).toList();
  }



}

typedef void OnPickImageCallback2(
    double? maxWidth, double? maxHeight, int? quality);