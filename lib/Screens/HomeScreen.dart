import 'package:bharat_scan_and_translate/Screens/OCR.dart';
import 'package:bharat_scan_and_translate/Screens/Translate.dart';
import 'package:flutter/material.dart';

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
            appBar: AppBar(
              backgroundColor: Color(0xFF11249F),
              title: new Text("Bharat Scan And Translate",
                style: new TextStyle(color: Colors.white),),
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

class Style {
  static final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
  );
  static final smallTextStyle = commonTextStyle.copyWith(
    fontSize: 9.0,
  );
  static final commonTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 10.0,
      fontWeight: FontWeight.w400
  );
  static final titleTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600
  );
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.w400
  );
}

final planetCardContent1 = new Container(
  margin: new EdgeInsets.fromLTRB(76.0, 16.0, 16.0, 16.0),
  constraints: new BoxConstraints.expand(),
  child: new Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Container(height: 4.0),
      new Text('Optical Character Recogniser',
        style: Style.titleTextStyle,
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
        style: Style.titleTextStyle,
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
      color: new Color(0xFF333366),
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
      color: new Color(0xFF333366),
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