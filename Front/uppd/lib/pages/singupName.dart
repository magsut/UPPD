import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:uppd/pages/singup.dart';
import 'package:uppd/pages/singupAge.dart';

class SingupName extends StatefulWidget {
  const SingupName({Key? key}) : super(key: key);

  @override
  State<SingupName> createState() => _SingupNameState();
}

class _SingupNameState extends State<SingupName> {
  TextEditingController ageController = TextEditingController();
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
                    child: GestureDetector(
                      onTap: (){Navigator.pop(context);},
                    child: const Image(
                      image: AssetImage('assets/arrow-point-to-right 1.png'),
                    ))
                    ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30,top: 20),
                    child: const Text(
                      'Ваше',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing:2),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 30,top: 2,right: 30),
                    child: const Text(
                      'Имя',
                      style: TextStyle(fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing:2),
                    )),

                Container(
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0xffF1F1F1)),
                  margin: const EdgeInsets.only(left: 30,top: 20,right: 30),
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                    controller: ageController,
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
                        print(ageController.text);
                        Navigator.push(context,MaterialPageRoute(builder: (context) => const SingupAge()));
                      },
                    )
                ),
              ],
            )));
  }
}