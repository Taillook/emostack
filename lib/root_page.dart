import 'package:flutter/material.dart';
import 'auth.dart';
import 'home_page.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        print("aaa");
        widget.auth.signInAnonymous().then((userId) {
          setState(() {
            authStatus =
                userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
          });
        });
        return new Scaffold();
      case AuthStatus.signedIn:
        print("bbb");
        widget.auth.currentUser().then((userId) {
          print(userId);
        });
        return new HomePage(
          auth: widget.auth,
        );
    }
  }
}
