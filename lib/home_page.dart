import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'auth.dart';
import 'create_message_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final formkey = new GlobalKey<FormState>();
  String _searchText;
  String uid;
  List data = [];

  Future getuid() async {
    final userid = await widget.auth.currentUser();
    this.setState(() {
      uid = userid;
    });
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    this.getuid();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("emostack")),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('emo').orderBy("at", descending: true).limit(100).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                var format = new DateFormat('yyyy/MM/dd(E) HH:mm');
                return new ListTile(
                  title: new Text(document['mes']),
                  subtitle: new Text(format.format(document['at'].toDate()))
                );
              }).toList(),
            );
        }
      },
    ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return CreateMessagePage(auth: widget.auth,);
                },
                fullscreenDialog: true,
              ));
        },
      ),
    );
  }
}
