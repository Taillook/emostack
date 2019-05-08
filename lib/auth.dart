import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> sginInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<String> signInAnonymous();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAutn = FirebaseAuth.instance;

  Future<String> sginInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAutn.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAutn.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAutn.currentUser();
    return user.uid;
  }

  Future<String> signInAnonymous() async {
    FirebaseUser user = await _firebaseAutn.signInAnonymously();
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAutn.signOut();
  }
}
