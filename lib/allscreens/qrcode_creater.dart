import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCreatePage extends  StatefulWidget{
  String addressline1;
  String addressline2;
  String addresslandmark;
  String addresscity;
  String addressstate;
  String addresspincode;
  String addressType;
  double lat;
  double long;
  QRCreatePage( this.addressline1,  this.addressline2, this.addresslandmark, this.addresscity, this.addressstate,
      this.addresspincode, this.addressType, this.lat, this.long);

  @override
  _QRCreatePage createState() {
    return _QRCreatePage();
  }

}
class _QRCreatePage extends State<QRCreatePage>{

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();

 late String  _dataString =  widget.addressline1+','+widget.addressline2+','+widget.addresslandmark
      +','+widget.addresscity+','+widget.addressstate+','+widget.addresspincode;

   late File file;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            _contentWidget(),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 12),
                FloatingActionButton(backgroundColor:Theme.of(context).primaryColor,
                  child: Icon(Icons.share,size: 30,),
                  onPressed: (){
                    setState(() async {

                      toQrImageData(_dataString);
                     // Share.shareFiles([path]);
                    });
                  },
                ),
              ],
            )
          ],
          ),
        ),
      ),
    );
  }

  Future<void> toQrImageData(String text) async {
    try {
      final image = await QrPainter(
        data: text,
        version: QrVersions.auto,
        gapless: true,
        color: Colors.black,
        emptyColor: Colors.white,
      ).toImage(300);
      final a = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = a!.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);

      final tempDir = await getTemporaryDirectory();
      if(tempDir.exists()!=true){
        tempDir.create();
      }
       file = await new File('${tempDir.path}/image.jpg').create();
      var newFile = await file.writeAsBytes(pngBytes);
      await newFile.create();
      if(newFile.exists() != null) {
        print("file create successfully");
        // showNotification
      }
      //must hav to provide path in androidmanifest with permissions
     Share.shareFiles(['${tempDir.path}/image.jpg']);
      //return pngBytes;
    } catch (e) {
      throw e;
    }
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 300.0,
                  version: 10,
                  backgroundColor: Colors.white,
                ),
              ),
            ),

    );
  }

}
