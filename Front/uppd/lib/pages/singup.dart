import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:uppd/manager/ath.dart';
import 'package:uppd/pages/login.dart';
import 'package:uppd/pages/singupName.dart';
import 'package:uppd/pages/singupPhoto.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  var name;
  var pas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30,top: 10,),
                child: const Text(
                  'Регистрация',
                  style: TextStyle(
                      color: Color(0xffED694A),
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                )),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30,top: 20),
                child: const Text(
                  'Создать',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing:2),
                )),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30,top: 2,right: 30),
                child: const Text(
                  'новый аккаунт',
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing:2),
                )),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 32,top: 20,bottom: 5),
                padding: const EdgeInsets.only(top: 0,bottom: 5),
                child: const Text(
                  'E-mail',
                  style: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing:2),
                )),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color(0xffF1F1F1)),
              margin: const EdgeInsets.only(left: 30,top: 0,right: 30),
              child: TextField(
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
                controller: usernameController,
                onChanged: (value){
                  name = value;
                },
                decoration:  const InputDecoration(
                  contentPadding:EdgeInsets.only(left: 20,bottom: 0) ,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 32,top: 20,bottom: 5),
                padding: const EdgeInsets.only(top: 0,bottom: 5),
                child: const Text(
                  'Пароль',
                  style: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing:2),
                )),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color(0xffF1F1F1)),
              margin: const EdgeInsets.only(left: 30,top: 0,right: 30),
              child: TextField(
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
                obscureText: true,
                controller: passwordController,
                onChanged: (value){
                  pas = value;
                },
                decoration:  const InputDecoration(
                  contentPadding:EdgeInsets.only(left: 20,bottom: 0) ,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 32,top: 20,bottom: 5),
                padding: const EdgeInsets.only(top: 0,bottom: 5),
                child: const Text(
                  'Повторите пароль',
                  style: TextStyle(fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing:2),
                )),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: const Color(0xffF1F1F1)),
              margin: const EdgeInsets.only(left: 30,top: 0,right: 30),
              child: TextField(
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                ),
                obscureText: true,
                controller: passwordConfirmController,
                decoration:  const InputDecoration(
                  contentPadding:EdgeInsets.only(left: 20,bottom: 0) ,
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
                height: 50,
                margin: const EdgeInsets.only(top: 60),
                padding: const EdgeInsets.only(left: 40,top: 0, right: 40,),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xffED694A)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  child: const Text('Продолжить',
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w600),),
                  onPressed: () {
                    print(name);
                    print(pas);
                    singup(name, pas);
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const SingupName()));
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
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const Login()));
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        )));
  }
}
