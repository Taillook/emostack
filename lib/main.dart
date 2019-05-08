import 'package:flutter/material.dart';
import 'root_page.dart';
import 'auth.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "emostack",
        theme: new ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: new RootPage(
          auth: Auth(),
        ));
  }
}
