
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uppd/helper/helperfunctions.dart';
import 'package:uppd/manager/auth.dart';
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

  Widget chatRoomList(){
    return StreamBuilder(
      stream:chatRoomsStream,
        builder: (BuildContext context,snapshot){
          if (!snapshot.hasData) {
            return Loading();
          }


        QuerySnapshot data = snapshot.requireData as QuerySnapshot;
          print('${data.docs[0].get('chatroomID').toString().replaceAll("_", "")
              .replaceAll(Constants.myName, "")}');
        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context,index) {
            return ChatRoomTile(
              chatRoomId: data.docs[index].get('chatroomID'),
                userName: data.docs[index].get('chatroomID').toString().replaceAll("_", "")
                    .replaceAll(Constants.myName, ""));

          },

        );
        }
    );
  }

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
    setState(() {
      databaseMethods.getChatRooms(Constants.myName).then((val){
        chatRoomsStream = val;
        print(
            "we got the data + ${chatRoomsStream.toString()} this is name  ${Constants.myName}");
      });
    });
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
        child: Stack(
          children: <Widget>[
            Container(
                alignment: Alignment.topRight,
            margin: EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(right: 30,top: 0),
                child: IconButton(
                  onPressed: () { _scaffoldKey.currentState?.openEndDrawer(); },
                  icon:const Image(
                    image:AssetImage('assets/topBar.png') ) ,

                )
            ),
            Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 50),
                padding: const EdgeInsets.only(left: 30,top: 20),
                child: const Text(
                  'Чаты',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing:2),
                )),
            Container(child:
            chatRoomList(),
            margin: EdgeInsets.only(top: 100),)

          ],
        ),
      ),

    );
  }

}
class ChatRoomTile extends StatefulWidget {
  final String userName;
  final String chatRoomId;
  const ChatRoomTile({Key? key,required this.userName,required this.chatRoomId}) : super(key: key);

  @override
  State<ChatRoomTile> createState() => _ChatRoomTileState(userName,chatRoomId);
}

class _ChatRoomTileState extends State<ChatRoomTile> {
  final String userName;
  final String chatRoomId;
  _ChatRoomTileState(this.userName, this.chatRoomId);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Conversation(chatroomId: chatRoomId,userName: userName
            )
        ));
      },
      child: Container(

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: Colors.black12),
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(30)),
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
