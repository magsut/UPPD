import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:uppd/manager/auth.dart';
import 'package:uppd/pages/chatRoom.dart';
import 'package:uppd/pages/loading.dart';
import 'package:uppd/pages/login.dart';
import 'package:uppd/pages/profile.dart';


class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  var name;
  var pas;
  var pas1;
  final formKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();

  singMeUp()  async {
    setState(() {
      isLoading  = true;
    });
    try{
     await authServices.createUserWithEmailAndPassword(usernameController.text, passwordController.text).then((val) {
      print('${val?.uid}');
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const ChatRoom()));

    });
    } on FirebaseAuthException catch (e){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const Singup()));
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
              title: Text('Ошибка'),
              content: Text('E-mail занят или введён неверно'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {Navigator.pop(context, 'OK');},
                  child: const Text('OK'),
                ),]

          ));

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading ?  const Loading():Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30, top: 10,),
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
                    child: const Text(
                      'Создать',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30, top: 2, right: 30),
                    child: const Text(
                      'новый аккаунт',
                      style: TextStyle(fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2),
                    )),
                Form(child: Column(
                  key: formKey,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 32, top: 20, bottom: 5),
                        padding: const EdgeInsets.only(top: 0, bottom: 5),
                        child: const Text(
                          'Имя пользователя',
                          style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2),
                        )),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xffF1F1F1)),
                      margin: const EdgeInsets.only(
                          left: 30, top: 0, right: 30),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                        controller: usernameController,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, bottom: 0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 32, top: 20, bottom: 5),
                        padding: const EdgeInsets.only(top: 0, bottom: 5),
                        child: const Text(
                          'Пароль',
                          style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2),
                        )),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xffF1F1F1)),
                      margin: const EdgeInsets.only(
                          left: 30, top: 0, right: 30),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                        obscureText: true,
                        controller: passwordController,
                        onChanged: (value) {
                          pas = value;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, bottom: 0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(
                            left: 32, top: 20, bottom: 5),
                        padding: const EdgeInsets.only(top: 0, bottom: 5),
                        child: const Text(
                          'Повторите пароль',
                          style: TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2),
                        )),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color(0xffF1F1F1)),
                      margin: const EdgeInsets.only(
                          left: 30, top: 0, right: 30),
                      child: TextFormField(
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                        obscureText: true,
                        controller: passwordConfirmController,
                        onChanged: (value) {
                          pas1 = value;
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, bottom: 0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                )),

                Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 60),
                    padding: const EdgeInsets.only(
                      left: 40, top: 0, right: 40,),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color(0xffED694A)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      child: const Text('Продолжить',
                        style: TextStyle(fontSize: 18,
                            fontWeight: FontWeight.w600),),
                      onPressed: () {if(pas == pas1){
                        print(name);
                        print(pas);
                        singup(name, pas,'koklush', '34', 'jydjyytdhr');
                        singMeUp();}
                        else {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                            title: Text('Ошибка'),
                            content: Text('Пароли не совпадают'),
                                actions: <Widget>[
                            TextButton(
                            onPressed: () {Navigator.pop(context, 'OK');},
                            child: const Text('OK'),
                        ),]

                        ));
                      }
                      },
                    )
                ),
                Row(
                  children: <Widget>[
                    const Text('У вас уже есть аккаунт?'),
                    TextButton(
                      child: const Text(
                        'Войти',
                        style: TextStyle(fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const Login()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )));
  }}
