import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyNewSelectImage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return new _MyNewSelectImageState();
  }
}

class _MyNewSelectImageState extends State<MyNewSelectImage>
{
   /*PickedFile? _imageFile ;
   bool isVideo = false;
   VideoPlayerController? _controller;
   VideoPlayerController? _toBeDisposed;
   String? _retrieveDataError;
   dynamic _pickImageError;
   final ImagePicker _picker = ImagePicker();
   final TextEditingController maxWidthController = TextEditingController();
   final TextEditingController maxHeightController = TextEditingController();
   final TextEditingController qualityController = TextEditingController();

   Future<void> _playVideo(PickedFile? file) async {
     *//*if (file != null && mounted) {
       await _disposeVideoController();
       late VideoPlayerController controller;
       if (kIsWeb) {
         controller = VideoPlayerController.network(file.path);
       } else {
         controller = VideoPlayerController.file(File(file.path));
       }
       _controller = controller;
       // In web, most browsers won't honor a programmatic call to .play
       // if the video has a sound track (and is not muted).
       // Mute the video so it auto-plays in web!
       // This is not needed if the call to .play is the result of user
       // interaction (clicking on a "play" button, for example).
       final double volume = kIsWeb ? 0.0 : 1.0;
       await controller.setVolume(volume);
       await controller.initialize();
       await controller.setLooping(true);
       await controller.play();
       setState(() {});
     }*//*
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
     if (_controller != null) {
       await _controller!.setVolume(0.0);
     }
     if (isVideo) {
       final PickedFile? file = await _picker.getVideo(
           source: source, maxDuration: const Duration(seconds: 10));
       await _playVideo(file);
     } else {
       await _displayPickImageDialog(context!,
               (double? maxWidth, double? maxHeight, int? quality) async {
             try {
               final pickedFile = await _picker.getImage(
                 source: source,
                 maxWidth: maxWidth,
                 maxHeight: maxHeight,
                 imageQuality: quality,
               );
               setState(() {
                 _imageFile = pickedFile;
               });
             } catch (e) {
               setState(() {
                 _pickImageError = e;
               });
             }
           });
     }

   }

   @override
   void dispose() {

     maxWidthController.dispose();
     maxHeightController.dispose();
     qualityController.dispose();
     super.dispose();
   }

   Widget _previewImage() {
     final Text? retrieveError = _getRetrieveErrorWidget();
     if (retrieveError != null) {
       return retrieveError;
     }
     if (_imageFile != null) {
       if (kIsWeb) {
         // Why network?
         // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
         return Image.network(_imageFile!.path);
       } else {
         return Semantics(
             child: Image.file(File(_imageFile!.path)),
             label: 'image_picker_example_picked_image');
       }
     } else if (_pickImageError != null) {
       return Text(
         'Pick image error: $_pickImageError',
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
     final LostData response = await _picker.getLostData();
     if (response.isEmpty) {
       return;
     }
     if (response.file != null) {

         setState(() {
           _imageFile = response.file;
         });

     } else {
       _retrieveDataError = response.exception!.code;
     }
   }
   Text? _getRetrieveErrorWidget() {
     if (_retrieveDataError != null) {
       final Text result = Text(_retrieveDataError!);
       _retrieveDataError = null;
       return result;
     }
     return null;
   }
*/
   /*void _showPicker(context) {
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
                           isVideo = false;
                           _onImageButtonPressed(ImageSource.camera,context: context);
                           Navigator.of(context).pop();
                         },
                         child: Text('Camera',style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                       ),
                       ),
                        Padding(padding:EdgeInsets.all(20),
                           child: InkWell(
                         onTap: (){
                           isVideo = false;
                           _onImageButtonPressed(ImageSource.gallery,context: context);
                           Navigator.of(context).pop();
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
   }*/
  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        Navigator.of(context).pop();
        break;
      case 'Settings':
        break;
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
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

     body: Center(
       child: Text('Option Menu'),
     ),
     /* body: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: Color(0xffFDCF09),
                child: _imageFile != null
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
              ),
            ),
          )

        ],
      ),*/

    );

  }


/*   Future<void> _displayPickImageDialog(
       BuildContext context, OnPickImageCallback onPick) async {
     return showDialog(context: context,
         builder: (context) {
           return AlertDialog(title: Text('Add optional parameters'), content: Column(children: <Widget>[
             TextField(controller: maxWidthController, keyboardType: TextInputType.numberWithOptions(decimal: true), decoration:
             InputDecoration(hintText: "Enter maxWidth if desired"),
             ),
             TextField(controller: maxHeightController, keyboardType: TextInputType.numberWithOptions(decimal: true), decoration:
             InputDecoration(hintText: "Enter maxHeight if desired"),),
             TextField(controller: qualityController, keyboardType: TextInputType.number, decoration:
             InputDecoration(hintText: "Enter quality if desired"),),],
           ),
             actions: <Widget>[
               TextButton(child: const Text('CANCEL'), onPressed: () {
                 Navigator.of(context).pop();},),
               TextButton(child: const Text('PICK'), onPressed: () {
                 double? width = maxWidthController.text.isNotEmpty
                     ? double.parse(maxWidthController.text) : null;
                 double? height = maxHeightController.text.isNotEmpty ? double.parse(maxHeightController.text) : null;
                 int? quality = qualityController.text.isNotEmpty ? int.parse(qualityController.text) : null;
                 onPick(width, height, quality);
                 Navigator.of(context).pop();
               }),],);});
   }*/
}

/*typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);*/














