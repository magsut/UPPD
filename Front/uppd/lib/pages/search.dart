
import 'package:flutter/material.dart';

import '../manager/database.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();

  Widget searchList(){
    return ListView.builder(
        itemCount: 1,
        itemBuilder:(context, index){
          return SearchTitle(
            username: "",
            userEmail: "",
          );
    });
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
      ]),)

       ]
    )
     ),
    );
  }
}

class SearchTitle extends StatelessWidget {
  final String username;
  final String userEmail;
  SearchTitle({required this.username, required this.userEmail});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              Text(username),
              Text(userEmail)
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(30)

            ) ,
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8) ,
            child: const Text("Message"),
          )
        ],
      ),
    );
  }
}
