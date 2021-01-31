import 'package:flutter/material.dart';
import 'package:spaceCraft/home.dart';
import 'package:spaceCraft/rive_player.dart';
import 'package:spaceCraft/widget/explosion.dart';
import 'package:spaceCraft/widget/header.dart';

import 'configs/size.dart';

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
          // body: HomeScreen(),
          // body: Header(),
          body: Explosion(),
          // body: PlayerRive(),
          // body: Tester(),
        ));
  }
}
