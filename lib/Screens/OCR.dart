import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';

class OCR extends StatefulWidget {
  @override
  _OCRState createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  File imageURI;
  var text = '';
  final ImagePicker _picker = ImagePicker();

  Future getImageFromCamera() async {
    var image = await _picker.getImage(source: ImageSource.camera);

    setState(() {
      imageURI = File(image.path);
    });
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageURI);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            text = text + word.text + ' ';
          });
        }
        text = text + '\n';
      }
    }
    textRecognizer.close();
    print(text);
  }

  Future getImageFromGallery() async {
    var image = await _picker.getImage(source: ImageSource.gallery);

    setState(() {
      imageURI = File(image.path);
    });
    FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageURI);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText visionText = await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            text = text + word.text + ' ';
          });
        }
        text = text + '\n';
      }
    }
    textRecognizer.close();
    print(text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SN',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(backgroundColor: Color(0xFF11249F),
            title: Text('OCR',
              style: new TextStyle(color: Colors.white),),),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    imageURI == null
                        ? Text('No image selected.')
                        : Image.file(imageURI, width: 300, height: 200, fit: BoxFit.cover),

                    Container(
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                        child: RaisedButton(
                          onPressed: () {
                            getImageFromCamera();
                          },
                          child: Text('Click Here To Select Image From Camera'),
                          textColor: Colors.white,
                          color: Colors.green,
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        )),

                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: RaisedButton(
                          onPressed: () => getImageFromGallery(),
                          child: Text('Click Here To Select Image From Gallery'),
                          textColor: Colors.white,
                          color: Colors.green,
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        )),



                  ])

          ),
        )
    );
  }
}
