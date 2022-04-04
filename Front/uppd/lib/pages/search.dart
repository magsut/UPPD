
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
        itemCount: ,
        itemBuilder:(context, index){
          return SearchTitle(
            username: "",
            userEmail: "",
          )
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
       child: Column(
         children: [
           Container(
             color: Colors.orange,
             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),

             child: Row(
               children: [
                 Expanded(
       child:TextField(
         decoration: InputDecoration(
           hintText: "search...",
           hintStyle: TextStyle(
             color: Colors.white
           )
         ),
       )
                 ),
                 GestureDetector(
                   onTap: (){
                     databaseMethods.getUserbyUsername(searchEditingController.text).then(val){
                       print(val.toString());
                     };
                   },
                 ),
                 Container(
                     height: 40,
                     width: 40,
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [
                           const Color(0x36FFFFFF),
                           const Color(0x0FFFFFFF)
                         ]
                       ),
                       borderRadius: BorderRadius.circular(40)
                     ),
                     padding: EdgeInsets.all(12),
                     child: Image.asset("assets/search_white.png"))

               ],
             ),
           )
         ],
       ),
     ),
    );
  }
}

class SearchTitle extends StatelessWidget {
  final String username;
  final String userEmail;
  SearchTitle({this.username, this.userEmail});


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
          )
          Spacer(),
          Container(
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(30)
                  
            ) ,
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8) ,
            child: Text("Message"),
          )
        ],
      ),
    );
  }
}
