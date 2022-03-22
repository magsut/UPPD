import 'package:flutter/material.dart';

class Singup extends StatefulWidget {
  const Singup({Key? key}) : super(key: key);

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
        padding: const EdgeInsets.only(left: 10,top: 20),
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
              padding: const EdgeInsets.only(left: 30,top: 20,right: 30),
              child: TextField(
                controller: nameController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  fillColor: Color(0xffF1F1F1),
                  filled: true,
                  labelText: 'E-mail',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30,top: 20,right: 30),
              child: TextField(
                controller: nameController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xffF1F1F1))
                  ),
                  fillColor: Color(0xffF1F1F1),
                  filled: true,
                  labelText: 'Пароль',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30,top: 20, right: 30,bottom: 50),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  fillColor: Color(0xffF1F1F1),
                  filled: true,
                  labelText: 'Повторите пароль',
                ),
              ),
            ),

            Container(
                height: 50,
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
                    print(nameController.text);
                    print(passwordController.text);
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
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        )));
  }
}