import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uppd/helper/helperfunctions.dart';
import 'package:uppd/manager/auth.dart';
import 'package:uppd/pages/about.dart';
import 'package:uppd/pages/loading.dart';
import 'package:uppd/pages/login.dart';
import 'package:uppd/pages/profile.dart';
import 'package:uppd/pages/search.dart';

import '../helper/constants.dart';
import '../manager/database.dart';
import 'conversation.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthServices authServices = AuthServices();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream? chatRoomsStream;
  bool isLoading = false;

  Widget chatRoomList() {
    return StreamBuilder(
        stream: chatRoomsStream,
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          if (snapshot.hasError) {
            return Loading();
          }

          QuerySnapshot data = snapshot.requireData as QuerySnapshot;
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: data.size,
                  itemBuilder: (context, index) {
                    return ChatRoomTile(
                        chatRoomId: data.docs[index].get('chatroomID'),
                        userName: data.docs[index]
                            .get('chatroomID')
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(Constants.myName, ""));
                  },
                )
              : Container();
        });
  }

  showOut() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Text('Выход'),
                content: Text('Вы точно хотите выйти с аккаунта?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      singMeOut();
                      Navigator.pop(context, 'ДА');
                    },
                    child: const Text('ДА'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'НЕТ');
                    },
                    child: const Text('НЕТ'),
                  ),
                ]));
  }

  singMeOut() {
    setState(() {
      isLoading = true;
    });
    authServices.singOut().then((val) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  @override
  void initState() {
    getUserInfoGetChats();
    super.initState();
  }

  getUserInfoGetChats() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    databaseMethods.getChatRooms(Constants.myName).then((val) {
      setState(() {
        chatRoomsStream = val;
        print(
            "we got the data + ${chatRoomsStream.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            key: _scaffoldKey,
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xffED694A),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
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
                    const Image(image: AssetImage('assets/logo.png')),
                    Container(
                      padding: const EdgeInsets.only(top: 100),
                      height: 500,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 60, top: 50, left: 10),
                            child: GestureDetector(
                              onTap: () async {
                                String name = await HelperFunctions
                                    .getUserNameSharedPreference() as String;
                                String email = await HelperFunctions
                                    .getUserEmailSharedPreference() as String;
                                String age =
                                await HelperFunctions.getUserAgeSharedPreference()
                                        as String;
                                String photo = await HelperFunctions
                                    .getUserPhotoSharedPreference() as String;
                                print(age);

                                Image image = await Image.network(
                                    'http://10.0.2.2:3000/api/photo/' + photo);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        Profile(name, age, email, image)));
                              },
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
                            padding: const EdgeInsets.only(right: 60, top: 30),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => const AboutUs()));
                              },
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
                          Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.only(right: 30, top: 40),
                            child: GestureDetector(
                              onTap: () {
                                showOut();
                              },
                              child: const Text(
                                'Выйти с аккаунта',
                                style: TextStyle(
                                  fontSize: 16,
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
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.only(right: 30, top: 0),
                      child: IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        icon:
                            const Image(image: AssetImage('assets/topBar.png')),
                      )),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 50),
                      padding: const EdgeInsets.only(left: 30, top: 20),
                      child: const Text(
                        'Чаты',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2),
                      )),
                  Container(
                    child: chatRoomList(),
                    margin: EdgeInsets.only(top: 100),
                  )
                ],
              ),
            ),
          );
  }
}

class ChatRoomTile extends StatefulWidget {
  final String userName;
  final String chatRoomId;
  const ChatRoomTile(
      {Key? key, required this.userName, required this.chatRoomId})
      : super(key: key);

  @override
  State<ChatRoomTile> createState() => _ChatRoomTileState(userName, chatRoomId);
}

class _ChatRoomTileState extends State<ChatRoomTile> {
  final String userName;
  final String chatRoomId;
  _ChatRoomTileState(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Conversation(chatroomId: chatRoomId, userName: userName)));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffF1F1F1)),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
