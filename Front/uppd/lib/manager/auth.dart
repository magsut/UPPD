import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}






























//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// singup(String name,pas) async {
// final http.Response response = await http.post(
//   Uri.parse('http://localhost:3000/api/user/createAc'),
//   headers: <String, String>{
//     'Content-Type': 'application/json; charset=UTF-8',
//     },
//   body: jsonEncode(<String, String>{
//     'pas': pas,
//     'name':name,
//     }),
//   );
// print(response.body);
//     // print(response.body);
//
// }
// login(String name,pas) async {
//   final http.Response response = await http.post(
//     Uri.parse('http://localhost:3000/api/user/login'),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'pas': pas,
//       'name':name,
//     }),
//   );
// print(response.body);
//   // print(response.body);
//
// }