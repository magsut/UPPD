
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uppd/helper/constants.dart';
import 'package:uppd/pages/conversation.dart';

import '../manager/database.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController searchEditingController = TextEditingController();
  QuerySnapshot? searchSnapshot;
  bool isLoading = false;
  bool haveUserSearched = false;

  initiateSearch() async {
    if(searchEditingController.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      await databaseMethods.getUserByUsername(searchEditingController.text)
          .then((val){
        searchSnapshot = val;
        print("$searchSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }
  Widget searchList(){
    return haveUserSearched ?ListView.builder(
        itemCount: searchSnapshot?.docs.length,
        shrinkWrap: true,
        itemBuilder:(context, index){
          return SearchTitle(
            searchSnapshot?.docs[index].get('name'),
            searchSnapshot?.docs[index].get('email'),
          );
        }):Container() ;
  }

  createChatRoomAndStartConversation(String userName)async{
    if(userName != Constants.myName){
     String chatroomId = getChatRoomId(Constants.myName,userName);
     List<String> users = [Constants.myName,userName];
     Map<String, dynamic>chatRoomMap = {
       'users': users,
       'chatroomID': chatroomId
     };
    await databaseMethods.createChatRoom(chatRoomMap,chatroomId);
     Navigator.push(this.context, MaterialPageRoute(
         builder: (context) => Conversation(chatroomId:chatroomId,userName: userName,)));
   }else{
     print('you can not send message');
     showDialog<String>(
         context: this.context,
         builder: (BuildContext context) => AlertDialog(
             title: Text('Ошибка'),
             content: Text('Вы не можете начать чат с собой'),
             actions: <Widget>[
               TextButton(
                 onPressed: () {Navigator.pop(context, 'OK');},
                 child: const Text('OK'),
               ),]

         ));
   }
  }

  Widget SearchTitle(String userName,String userEmail){
    return Container(
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: const Color(0xffF1F1F1)),
      margin: const EdgeInsets.only(left: 30,top: 20,right: 30),
      child: Row(
          children: <Widget> [
            Expanded(
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(userName,style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ), ),
                    Text(userEmail,style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                )),
            GestureDetector(
                onTap:(){
                  print('${Constants.myName}');
                  createChatRoomAndStartConversation(
                      userName
                  );
                },
                child:
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Color(0xffED694A),
                      borderRadius: BorderRadius.circular(40)
                  ),
                  padding: EdgeInsets.only(left: 0),
                  child: const Icon(Icons.message,color: Colors.white),
                )
            )


          ]),);
  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:Padding(
        padding: const EdgeInsets.only(top: 20),
    child: ListView(
    children: <Widget>[

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
            'Поиск',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing:2),
          )),
      Container(
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: const Color(0xffF1F1F1)),
        margin: const EdgeInsets.only(left: 30,top: 20,right: 30),
        child: Row(
          children: <Widget> [
             Expanded(child:
             TextField(
               textAlign: TextAlign.center,
               controller: searchEditingController,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),
              decoration:  const InputDecoration(
                hintText: 'Введите имя пользователя',
                hintStyle: TextStyle(color:Colors.black26),
                contentPadding:EdgeInsets.only(left: 20,bottom: 0) ,
                border: InputBorder.none,
              ),
            ),),
            GestureDetector(
              onTap:(){
                initiateSearch();
              },
              child:
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: Color(0xffED694A),
                      borderRadius: BorderRadius.circular(40)
                  ),
                  padding: EdgeInsets.only(left: 0),
                  child: const Icon(Icons.search,color: Colors.white),
                )
            )


      ]),),
      searchList()



       ]

    )
     ),
    );
  }
}




