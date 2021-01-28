import 'package:flutter/material.dart';
import 'package:spaceCraft/home.dart';
import 'package:spaceCraft/provider/tempSafer/testFile.dart';
import 'package:spaceCraft/rive_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          body: HomeScreen(),
          // body: PlayerRive(),
          // body: Tester(),
        
        ));
  }
}
