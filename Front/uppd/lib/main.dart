import 'package:flutter/material.dart';
import 'package:uppd/pages/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MazutLive',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: ThemeData(
      canvasColor: const Color(0xFFFFFFFF),
    ),
    home: Scaffold(
      endDrawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Luka's Weather",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontFamily: 'Manrope-bold',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 60),
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('assets/Settings.png'),
                            height: 25,
                            width: 25,
                            fit: BoxFit.fill),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            child: const Text(
                              'Настройки',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('assets/Favourite.png'),
                            height: 25,
                            width: 25,
                            fit: BoxFit.fill),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            child: const Text(
                              'Избранные',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Image(
                            image: AssetImage('assets/AboutUs.png'),
                            height: 25,
                            width: 25,
                            fit: BoxFit.fill),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: GestureDetector(
                            onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (_) => const Loading()));},
                            child: const Text(
                              'О Приложении',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body:
            const Loading()

    ),
  );
}
