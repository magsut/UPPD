import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uppd/helper/constants.dart';
import 'package:uppd/manager/database.dart';
import 'package:uppd/pages/chatRoom.dart';

class Conversation extends StatefulWidget {
  final String chatroomId;
  final String userName;

  Conversation({Key? key, required this.chatroomId, required this.userName}) : super(key: key);

  @override
  State<Conversation> createState() => _ConversationState(chatroomId,userName);
}

class _ConversationState extends State<Conversation> {
  final String chatroomId;
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController messageController = TextEditingController();
  Stream? chatMessageStream;
  final String userName;

  _ConversationState(this.chatroomId,this.userName);

  Widget ChatMessageList(){
    return StreamBuilder(
      stream: chatMessageStream,
        builder: (BuildContext context,snapshot) {
        QuerySnapshot data = snapshot.requireData as QuerySnapshot;
          return snapshot.hasData ? ListView.builder(
            itemCount:data.size,
              itemBuilder: (context,index){
              return MessageTile(
                message:data.docs[index].get('message'),
                isSendByMe: data.docs[index].get('sendBy') == Constants.myName,
              );
              }
          ): Container();
        });

  }


  sendMessage(){
    if (messageController.text.isNotEmpty){
      Map<String,dynamic> messageMap ={
        'message': messageController.text,
        'sendBy': Constants.myName,
        'time': DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(chatroomId, messageMap);
      messageController.text = '';
    }
  }
  @override
  void initState() {
    super.initState();
    databaseMethods.getConversationMessages(chatroomId).then((val){
       setState(() {
         chatMessageStream = val;
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Stack(children: <Widget>[
            Container(
                padding: const EdgeInsets.only(left: 30, top: 20),
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
                padding: const EdgeInsets.only(left: 30, top: 20),
                margin: const EdgeInsets.only(top: 50),
                child: Text(
                  userName,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2),
                )),
            Container(
              margin: EdgeInsets.only(top: 100,bottom: 80),
              child: ChatMessageList(),
            ),

            Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(),
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xffF1F1F1)),
                  height: 70,
                  child: Row(children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Сообщение...',
                          hintStyle: TextStyle(color: Colors.black26),
                          contentPadding: EdgeInsets.only(left: 40, bottom: 0),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          sendMessage();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child:
                              Image(image: const AssetImage('assets/send.png')),
                        ))
                  ]),
                )),
          ])),
    );
  }
}
class MessageTile extends StatefulWidget {
  final String message;
  final bool isSendByMe;
  const MessageTile({Key? key,required this.message,required this.isSendByMe}) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState(message,isSendByMe);
}

class _MessageTileState extends State<MessageTile> {
  final String message;
  final bool isSendByMe;

  _MessageTileState(this.message,this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24 ,vertical: 15),
        decoration: BoxDecoration(
          color: isSendByMe ? Color(0xffFDEBE7): Color(0xffFFB3A1),
          borderRadius: isSendByMe ?
              const BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
              ) :
              const BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)
          )
        ),

        child: Text(message,
          style:const TextStyle(
            fontSize: 18
          ) ,),
      ),
    );
  }
}
