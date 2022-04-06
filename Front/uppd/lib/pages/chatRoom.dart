
import 'package:flutter/material.dart';
import 'package:uppd/helper/helperfunctions.dart';
import 'package:uppd/manager/auth.dart';
import 'package:uppd/pages/loading.dart';
import 'package:uppd/pages/login.dart';
import 'package:uppd/pages/profile.dart';
import 'package:uppd/pages/search.dart';

import '../helper/constants.dart';
import '../manager/database.dart';


class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthServices authServices = AuthServices();
  bool isLoading = false;

  singMeOut(){
    setState(() {
      isLoading  = true;
    });
    authServices.singOut().then((val){
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const Login()));
    });
  }
  @override
  void initState() {
    getUserInfoGetChats();
    super.initState();
  }

  getUserInfoGetChats() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return isLoading ?  const Loading():Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffED694A),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const SearchScreen()));
          },
          child: const Icon(Icons.search),

      ),
      endDrawer: Drawer(
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                  image: AssetImage('assets/logo.png')
              ),
              Container(
                padding: const EdgeInsets.only(top: 100),
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                        Padding(
                          padding: const EdgeInsets.only(right: 60,top: 50,left: 10),
                          child: GestureDetector(
                            onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (_) => Profile()));},
                            child: const Text(
                              'Личный кабинет',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.only(right: 60),
                          child: GestureDetector(

                            child: const Text(
                              'О Приложении',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                              ),
                            ),
                          ),


                    ),
                  ],
                ),
              ),

              Container(
                  padding: const EdgeInsets.only(top: 100, right: 20),
                  height: 260,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        singMeOut();
                      },
                      child: const Text(
                        'Выйти с аккаунта',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 30,top: 0),
                child: IconButton(
                  onPressed: () { _scaffoldKey.currentState?.openEndDrawer(); },
                  icon:const Image(
                    image:AssetImage('assets/topBar.png') ) ,
                  
                )
            ),
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 30,top: 20),
                child: const Text(
                  'Чаты',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing:2),
                )),
          ],
        ),
      ),

    );
  }

}