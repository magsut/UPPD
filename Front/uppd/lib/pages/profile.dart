import 'package:flutter/material.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';


class ExampleExpert extends StatefulWidget {
  @override
  _ExampleExpertState createState() => _ExampleExpertState();
}

class _ExampleExpertState extends State<ExampleExpert> {
  GlobalKey<ExpandableBottomSheetState> key = new GlobalKey();
  int _contentAmount = 0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: ExpandableBottomSheet(
          background: Container(

            child: Center(
              child: Image.asset("assets/maz.png", width: 396, height: 611,),
            ),
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
                        padding: const EdgeInsets.only(left: 30),
                        child: const Text(
                          'MAZUTIK',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing:2),
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 30),
                        child: const Text(
                          'MAZUTIK',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              letterSpacing:2),
                        )),
                  ]))
          ),

        ),
      ),
    );
  }
}