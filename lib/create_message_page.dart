import 'package:flutter/material.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateMessagePage extends StatefulWidget {
  CreateMessagePage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _CreateMessagePageState();
}

class _CreateMessagePageState extends State<CreateMessagePage> {
  final formkey = new GlobalKey<FormState>();
  String uid;
  String _message;

  Future getuid() async {
    final userid = await widget.auth.currentUser();
    this.setState(() {
      uid = userid;
    });
    print(uid);
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

  void validateAndSubmit() async {
    if (validateAndSave()) {
      Firestore.instance.collection("emo").add({
                "uid": uid,
                "mes": _message,
                "at": DateTime.now()
              });
      Navigator.pop(context);
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
      appBar: new AppBar(
        title: new Text('投稿'),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Form(
          key: formkey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildSubmitButton(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'コメント'),
        validator: (value) => value.isEmpty ? '入力してください' : null,
        onSaved: (value) => _message = value,
      ),
    ];
  }

  List<Widget> buildSubmitButton() {
    return [
      new RaisedButton(
        splashColor: Colors.blueGrey,
        child: new Text('投稿', style: new TextStyle(fontSize: 20.0)),
        color: Colors.orange,
        onPressed: validateAndSubmit,
      )
    ];
  }
}
