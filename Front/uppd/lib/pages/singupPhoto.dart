import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uppd/helper/helperfunctions.dart';
import 'package:uppd/manager/auth.dart';
import 'package:uppd/pages/chatRoom.dart';
import 'package:uppd/pages/singup.dart';

import '../manager/database.dart';

class SingupPhoto extends StatefulWidget {
  final String pas;
  final String login;
  final String name;
  final String age;
  final String token;

  const SingupPhoto(
      {Key? key,
      required this.pas,
      required this.login,
      required this.name,
      required this.age,
      required this.token})
      : super(key: key);

  @override
  State<SingupPhoto> createState() =>
      _SingupPhotoState(pas, login, name, age, token);
}

class _SingupPhotoState extends State<SingupPhoto> {
  final String pas;
  final String login;
  final String name;
  final String age;
  final String token;

  _SingupPhotoState(this.pas, this.login, this.name, this.age, this.token);

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Ошибка загрузки фото: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      left: 30,
                      top: 10,
                    ),
                    child: const Text(
                      'Регистрация',
                      style: TextStyle(
                          color: Color(0xffED694A),
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Image(
                          image:
                              AssetImage('assets/arrow-point-to-right 1.png'),
                        ))),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30, top: 20),
                    child: const Text(
                      'Фото',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30, top: 2, right: 30),
                    child: const Text(
                      'Профиля',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2),
                    )),
                Container(
                  margin: const EdgeInsets.only(left: 50, top: 30, right: 50),
                  child: GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: image != null
                        ? ClipOval(
                            child: Image.file(
                            image!,
                            width: 100,
                            height: 300,
                            fit: BoxFit.cover,
                          ))
                        : const Image(
                            image: AssetImage('assets/uploadPhotos.png'),
                          ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 60),
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 0,
                      right: 40,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xffED694A)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Продолжить',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        print(image!.path);
                        singup(login, pas, name, age, token, image!.path);
                        HelperFunctions.saveUserLoggedInSharedPreference(true);
                        HelperFunctions.saveUserNameSharedPreference(name);
                        HelperFunctions.saveUserEmailSharedPreference(login);
                        HelperFunctions.saveUserAgeSharedPreference(age);
                        HelperFunctions.saveUserPhotoSharedPreference(image!.path);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatRoom()));
                      },
                    )),
              ],
            )));
  }
}
