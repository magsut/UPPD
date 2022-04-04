import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class DatabaseMethods {
   getUserbyUsername(String username) async{
     return await FirebaseFirestore.instance.collection("users").where("name", isEqualTo: username).getDocuments();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap).cathError((e){
      print(e.toString());
    });
  }


}
