import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'db.dart';
import 'models/definition.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

void main() {
  testDatabase();
  runApp(LearnReligionApp());
}

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

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SecondPageState();
  }
}

class SecondPageState extends State<SecondPage> {
  DatabaseHelper helper = DatabaseHelper();
  List<Definition> definitions;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getListView(),
    );
  }

  ListView getListView() {
    final Future<Database> dbFuture = helper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Definition>> definitionListFuture =
          helper.getDefinitionList();

      definitionListFuture.then((definitionList) {
        setState(() {
          this.definitions = definitionList;
          this.count = definitionList.length;
        });
      });
    });

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Text(this.definitions[position].word);
      },
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
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondPage()),
          );
        },
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
      ),
    );
  }
}

void testDatabase() async {
  final file = File("~\\lib\\data.csv");

  Stream<List> inputStream = file.openRead();

  inputStream.transform(utf8.decoder).transform(LineSplitter()).listen(
      (String line) {
    List row = line.split(",");

    String word = row[0];
    String definition = row[1];

    print("$word, $definition");
  }, onDone: () => print("closed"), onError: (e) => print(e.toString()));
}
