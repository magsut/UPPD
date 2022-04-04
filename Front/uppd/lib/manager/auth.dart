import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../models/user.dart';

class AuthServices {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user==null){
      return null;
    }
    return User(user.uid, user.email);
  }
  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }


  Future<User?> signInWithEmailAndPassword(
      String email,
      String password,
      ) async{
    final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
      String email,
      String password,
      ) async{
    final credential = await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(credential.user);}


  Future<void> singOut() async{
    return await _firebaseAuth.signOut();}
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