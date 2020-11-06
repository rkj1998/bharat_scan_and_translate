import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:translator/translator.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';


class Translate extends StatefulWidget {
  @override
  _TranslateState createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {

  createAlertDialog2(BuildContext context) {
    // Alert Box when no radio button is selected while answering.
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
            Text("Right now Only Translation to english language is supported however more languages are to be added soon."),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                ),
              )
            ],
          );
        });
  }

  bool isPlaying = false;
  FlutterTts _flutterTts;
  @override
  void initState() {
    _c = new TextEditingController();
    _d = new TextEditingController();
    super.initState();
    initializeTts();
    Timer(Duration(seconds: 0),(){
      createAlertDialog2(context);
    });
  }

  @override
  void dispose(){
    _c?.dispose();
    _d?.dispose();
    super.dispose();
    _flutterTts.stop();

  }

  initializeTts() {
    _flutterTts = FlutterTts();

    _flutterTts.ttsInitHandler(() {
      setTtsLanguage();
    });

    _flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    _flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    _flutterTts.setErrorHandler((err) {
      setState(() {
        print("error occurred: " + err);
        isPlaying = false;
      });
    });
  }

  void setTtsLanguage() async {
    await _flutterTts.setLanguage("en-US");
  }

  void speechSettings1() {
    _flutterTts.setVoice("en-us-x-sfg#male_1-local");
    _flutterTts.setPitch(1.5);
    _flutterTts.setSpeechRate(.9);
  }

  void speechSettings2() {
    _flutterTts.setVoice("en-us-x-sfg#male_2-local");
    _flutterTts.setPitch(1);
    _flutterTts.setSpeechRate(0.5);
  }

  Future _speak(String text) async {
    if (text != null && text.isNotEmpty) {
      var result = await _flutterTts.speak(text);
      if (result == 1)
        setState(() {
          isPlaying = true;
        });
    }
  }

  Future _stop() async {
    var result = await _flutterTts.stop();
    if (result == 1)
      setState(() {
        isPlaying = false;
      });
  }

  TextEditingController _c ;
  TextEditingController _d ;
  File imageURI;
  var text ='';
  final ImagePicker _picker = ImagePicker();


  void translate(String value) async{
    final translator = GoogleTranslator();
    var result = await translator
        .translate(value, to: 'en');
    setState(() {
      _d.text="$result";
    });
  }

  createAlertDialog(BuildContext context) {
    // Alert Box when no radio button is selected while answering.
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:  RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
            title:
            Text("Select An Option"),
            actions: <Widget>[

              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              stops: [0.1, 0.5, 0.9,],
                              colors: [Color(0xFFFF9933),Colors.white, Colors.green]
                          ),
                        ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7,
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 5),
                          onPressed: () {
                            text="";
                            Navigator.of(context).pop();
                            getImageFromCamera();
                          },
                          child: Text(
                            "Click Here To Select Image From Camera",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF333366),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              stops: [0.1, 0.5, 0.9,],
                              colors: [Color(0xFFFF9933),Colors.white, Colors.green]
                          ),
                        ),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.7,
                        child: FlatButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 5),
                          onPressed: () {
                            text="";
                            Navigator.of(context).pop();
                            getImageFromGallery();
                          },
                          child: Text(
                            "Click Here To Select Image From Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF333366),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF333366),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        });
  }

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
    setState(() {
      _c.text=text;
    });
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

        text = text + ' ';
      }
    }
    setState(() {
      _c.text=text;
    });
    textRecognizer.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: GradientAppBar(
            title: Align(alignment:Alignment.topCenter,child: Text("Translate",style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF11249F),
            ),)),
            gradient: LinearGradient(colors: [Color(0xFFFF9933),Colors.white, Colors.green]),
          ),
        ),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                imageURI == null
                    ? Text('Select An Image Or Enter Text to be Translated.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                ),)
                    : Image.file(imageURI, width:300, height: 300, fit: BoxFit.contain),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: _c,
                    decoration:InputDecoration(
                      suffixIcon: IconButton(
                        icon: isPlaying
                            ?Icon(
                          Icons.stop,
                          color: Colors.red,
                        ):Icon(
                          Icons.play_arrow,
                          color: Colors.green,
                        ),
                        onPressed: (){
                          setState(() {
                            //speechSettings1();
                            isPlaying ? _stop() : _speak(_c.text);
                          });
                        },
                      )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [0.1, 0.5, 0.9,],
                          colors: [Color(0xFFFF9933),Colors.white, Colors.green]
                      ),
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 5),
                      onPressed: () {
                        createAlertDialog(context);
                      },
                      child: Text(
                        "Click Here To Select Image",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF333366),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          stops: [0.1, 0.5, 0.9,],
                          colors: [Color(0xFFFF9933),Colors.white, Colors.green]
                      ),
                    ),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 5),
                      onPressed: () {
                        print(_c.text);
                       translate(_c.text);
                      },
                      child: Text(
                        "Translate",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF333366),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: _d,
                    decoration:InputDecoration(
                        suffixIcon: IconButton(
                          icon: isPlaying
                              ?Icon(
                            Icons.stop,
                            color: Colors.red,
                          ):Icon(
                            Icons.play_arrow,
                            color: Colors.green,
                          ),
                          onPressed: (){
                            setState(() {
                              //speechSettings1();
                              isPlaying ? _stop() : _speak(_d.text);
                            });
                          },
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
