import 'package:bharat_scan_and_translate/Screens/OCR.dart';
import 'package:bharat_scan_and_translate/Screens/Translate.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar:PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: GradientAppBar(
                title: Align(alignment:Alignment.topCenter,child: Text("Bharat Scan And Translate",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF11249F),
                ),)),
                gradient: LinearGradient(colors: [Color(0xFFFF9933),Colors.white, Colors.green]),
              ),
            ),
            body:SingleChildScrollView(
              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new SizedBox(
                      height: 50.0,
                    ),
                    new HomePageBody(),
                    new HomePageBody2(),
                    new SizedBox(
                      height: 60.0,
                    ),
                  ]
              ) ,
            ))
    );
  }
}



final planetCardContent1 = new Container(
  margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
  constraints: new BoxConstraints.expand(),
  child: new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Container(height: 4.0),
      new Text('Optical Character Recogniser',
        style: TextStyle(
            color:Color(0xFF333366),
            fontSize: 18.0,
            fontWeight: FontWeight.w600
        )
      ),
      new Container(height: 10.0),
      new Container(
          margin: new EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: 18.0,
          color: new Color(0xff00c6ff)
      ),
    ],
  ),
);
final planetCardContent2 = new Container(
  margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
  constraints: new BoxConstraints.expand(),
  child: new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Container(height: 4.0),
      new Text('Translate From Image',
        style: TextStyle(
            color:Color(0xFF333366),
            fontSize: 18.0,
            fontWeight: FontWeight.w600
        )
      ),
      new Container(height: 10.0),
      new Container(
          margin: new EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: 18.0,
          color: new Color(0xff00c6ff)
      ),
    ],
  ),
);

class PlanetRow extends StatelessWidget {


  final planetCard = new Container(
    child: planetCardContent1,
    height: 160.0,
    margin: new EdgeInsets.only(left: 46.0),
    decoration: new BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [0.1, 0.5, 0.9,],
        colors: [Color(0xFFFF9933),Colors.white, Colors.green]
      ),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );
  final planetThumbnail = new Container(
    margin: new EdgeInsets.symmetric(
        vertical: 16.0
    ),
    alignment: FractionalOffset.centerLeft,
    child: new Image(
      image: new AssetImage("assets/images/OCR.png"),
      height: 92.0,
      width: 92.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap:
            (){ Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OCR(),));
        },

        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              planetCard,
              planetThumbnail,
            ],
          ),
        )
    );
  }
}

class PlanetRow2 extends StatelessWidget {
  final planetCard = new Container(
    child: planetCardContent2,
    height: 160.0,
    margin: new EdgeInsets.only(left: 46.0),
    decoration: new BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.1, 0.5, 0.9,],
          colors: [Color(0xFFFF9933),Colors.white, Colors.green]
      ),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 10.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
  );
  final planetThumbnail = new Container(
    margin: new EdgeInsets.symmetric(
        vertical: 16.0
    ),
    alignment: FractionalOffset.centerLeft,
    child: new Image(
      image: new AssetImage("assets/images/translate.png"),
      height: 92.0,
      width: 92.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap:
            () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Translate(),
          )
          );
        },

        child: new Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 24.0,
          ),
          child: new Stack(
            children: <Widget>[
              planetCard,
              planetThumbnail,
            ],
          ),
        )
    );
  }
}
class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PlanetRow();
  }
}
class HomePageBody2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new PlanetRow2();
  }
}