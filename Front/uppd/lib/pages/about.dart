import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uppd/pages/chatRoom.dart';
import 'package:audioplayers/audioplayers.dart';


class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  static AudioCache player = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
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
              child: const Text(
                'О приложении',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2),
              )),

          Container(
            margin: const EdgeInsets.only(top: 200),
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: (){player.play('rig.mp3');},
              child:
              const Image(
                image: AssetImage('assets/logo.png'),
              ),
            )
              ),
          Container(
            alignment: Alignment.bottomRight,
            child: Container(
            height: 346,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [


                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      "Версия 1.0",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Text(
                      "от 7 апреля 2022",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      "By LukaGora, maksimnanabak, nikisham",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text(
                      "2022",
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Manrope-bold',
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          )
        ]),
      ),
    );
  }
}
