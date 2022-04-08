// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:uppd/helper/helperfunctions.dart';

import 'chatRoom.dart';


class Profile extends StatefulWidget {
  final String name;
  final String age;
  final String login;
  final Image image;


  Profile(this.name, this.age, this.login, this.image);

  @override
  _ProfileState createState() => _ProfileState(name,age,login,image);
}

class _ProfileState extends State<Profile> {
  final String name;
  final String age;
  final String login;
  final Image image;


  _ProfileState(this.name, this.age, this.login, this.image);

  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
  int _contentAmount = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: SafeArea(
          child: ExpandableBottomSheet(
            background: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 30, top: 20, bottom: 30, right: 320),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChatRoom()));
                        },
                        child: const Image(
                          image: AssetImage('assets/arrow-point-to-right 1.png'),
                        ))),
                Container(
                  child: Center(
                    child: image,
                  ),
                ),
              ],
            ),
            enableToggle: true,
            persistentContentHeight: 250,
            persistentHeader: Container(
              height: 40,

              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  color: Colors.white
              ),
              child: const Center(
                child: Image(
                  image: AssetImage('assets/bar.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            expandableContent: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .6,

                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.only(left: 30, top: 0),
                    child:
                    ListView(children: <Widget>[
                      Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 20, bottom: 20),
                          child: Text(
                            'Ваше имя: ' + name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing:2),
                          )),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 20, bottom: 20),
                          child: Text(
                            'Login: ' + login,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffED694A),
                                fontWeight: FontWeight.w900,
                                letterSpacing:2),
                          )),
                      Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 20, bottom: 20),
                          child: Text(
                            'Возраст: ' + age,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing:2),
                          )),
                    ]))
            ),

          ),
        ),
      ),
    );
  }
}