import 'package:flutter/material.dart';
import 'db.dart';
import 'models/definition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  //testDatabase();
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
      body: StreamBuilder(
        stream: Firestore.instance.collection('words').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text("Loading...");
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey,
            ),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                buildListItem(context, snapshot.data.documents[index]),
          );
        },
      ),
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot document) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 10.0,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(document['word']),
        children: <Widget>[
          Text(document['definition'])
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
