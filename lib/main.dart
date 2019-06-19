import 'package:flutter/material.dart';

void main() => runApp(LearnReligionApp());

class LearnReligionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TBD",
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 10.0,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "TitleCard",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 50,
                  ),
                ),
              ),
            ),
          ),
          HomePageButton(
            color: Colors.amberAccent,
            string: "Hello",
          ),
          HomePageButton(),
          HomePageButton(),
        ],
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  final Color color;
  final String string;
  HomePageButton({this.color: Colors.black, this.string: ""});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Text(
            string,
            style: TextStyle(
              fontFamily: "Georgia",
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
