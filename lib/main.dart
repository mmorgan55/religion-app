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
      padding: EdgeInsets.all(25),
      child: Column(
        children: <Widget>[
          HomePageButton(
            2,
            color: Colors.amberAccent,
            str: "Hello",
          ),
          HomePageButton(1)
        ],
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  final int flexNum;
  final Color color;
  final String str;
  HomePageButton(this.flexNum, {this.color: Colors.blueGrey, this.str: "BLANK"})
      : assert(flexNum != null);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flexNum,
      fit: FlexFit.tight,
      child: Container(
        margin: EdgeInsets.all(7.5),
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
            str,
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
