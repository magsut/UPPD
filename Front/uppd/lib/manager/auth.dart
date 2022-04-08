import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uppd/helper/helperfunctions.dart';
import '../models/user.dart';

class AuthServices {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
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
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await auth.FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(credential.user);
  }

  Future<void> singOut() async {
    return await _firebaseAuth.signOut();
  }
}

login(String name, pas) async {
  final http.Response response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/user/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'pas': pas,
      'login': name
    }),
  );
  print(response.body);

  var user = jsonDecode(response.body);
  print(user);
  HelperFunctions.saveUserNameSharedPreference(user['UserName']);
  HelperFunctions.saveUserEmailSharedPreference(user['UserLogin']);
  HelperFunctions.saveUserAgeSharedPreference(user['Age']);
  HelperFunctions.saveUserPhotoSharedPreference(user['Icon']);
}

singup(String name, pas, login, age, token, filePath) async {
  var newFileName = DateTime.now().microsecondsSinceEpoch.toString() + filePath.split('/').last;
  newFileName.split('.').join('-').split(':').join('-').split(' ').join('-');
  print(newFileName);
  HelperFunctions.saveUserPhotoSharedPreference(newFileName);
  var request = http.MultipartRequest(
      "POST", Uri.parse('http://10.0.2.2:3000/api/user/createAc'));
  request.fields['name'] = name;
  request.fields['pas'] = pas;
  request.fields['login'] = login;
  request.fields['age'] = age;
  request.fields['token'] = token;
  request.fields['fileName'] = newFileName;
  request.files.add(await http.MultipartFile.fromPath('avatar', filePath));

  request.send().then((value) => print(value));

}

