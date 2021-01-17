import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spaceCraft/widget/bullet.dart';
import 'package:spaceCraft/widget/playerShip.dart';

import 'player.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _rootSCRnKey = GlobalKey();
  Player player = Player(dx: 0, dy: 0);
  Size size = Size(0, 0);
  Rect boxSize = Rect.zero;

  List<Bullet> bullets = [];
  Timer timerBulletMove, timerBulletmaker;

  final fps = 1 / 24;

  Bullet b = Bullet();

  final Random random = Random();
  @override
  void initState() {
    super.initState();
    b.position = BVector(100, 100);
    b.radius = 10;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      size = _rootSCRnKey.currentContext.size;
      print("size  $size");
      setState(() {
        player.dx = size.width / 2;
        player.dy = size.height;
      });
      //
      boxSize = Rect.fromLTRB(0, 0, size.width, size.height);
      timerBulletmaker =
          Timer.periodic(Duration(seconds: 1), preOdicBulletThrow);
      timerBulletMove = Timer.periodic(
          Duration(milliseconds: (100 * fps).floor()), frameBuild);
    });
  }

  preOdicBulletThrow(Timer timer) {
    bulletMaker();
  }

  //tester
  frameBuild(Timer timer) {
    // b.position.x += 10;
    if (bullets.length > 20) bullets.removeRange(0, 5);
    bullets.forEach((element) {
      element.position.y += 10;

      // if (element.position.y > size.height - 10) timer.cancel();
    });
    setState(() {});
    print(b.position.y);
  }

  @override
  void dispose() {
    timerBulletMove.cancel();
    timerBulletmaker.cancel();
    super.dispose();
  }

  void updatePlayerPosition(double dx, double dy) {
    setState(() {
      player.dx = dx;
      player.dy = dy;
    });
  }

  void bulletMaker() {
    if (bullets.length > 20) {
      bullets.removeRange(0, 10);
    }
    Bullet b = Bullet();
    // b.position = BVector(random.nextDouble() * 360, 0);
    b.position = BVector(player.dx, player.dy == size.height ? 10 : player.dy);
    print(b.position.x);
    b.radius = random.nextInt(20).clamp(4, 20).ceilToDouble();
    bullets.add(b);

    print(" bullets ${bullets.length}");
  }

  @override
  Widget build(BuildContext context) {
    // log("Player dx : ${player.dx}  dy : ${player.dy}");
    return GestureDetector(
      onPanUpdate: (details) {
        // log("dx: ${details.globalPosition.dx.toString()} dy: ${details.globalPosition.dy.toString()} ");

        /// tuch possition
        var posX = details.globalPosition.dx;
        var posY = details.globalPosition.dy;

        /// we are separating in two section, it'll help to move though another axis stuck
        /// it'll make sure that even One axis will work even other axis stuc
        if (posY >= size.height - player.height / 2 ||
            posY <= player.height / 2) {
          ///`we cant move in Y axix` outScreen
        } else {
          updatePlayerPosition(player.dx, size.height - posY);
        }
        if (posX >= size.width - player.width / 2 || posX <= player.width / 2) {
          ///`we cant move in X axix` outScreen
        } else {
          updatePlayerPosition(posX, player.dy);
        }

        // if (inScreen) updatePlayer(posX, size.height - posY);
      },
      child: buildContainer(),
    );
  }

  Container buildContainer() {
    return Container(
      color: Colors.blue.shade100,
      key: _rootSCRnKey,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: player.dy == size.height ? 10 : player.dy,
            left: player.dx,
            child: CustomPaint(
              painter: PlayerShip(player),
            ),
          ),

          // bullet List
          ...bullets
              .map(
                (bl) => Positioned(
                  bottom: bl.position.y,
                  left: bl.position.x,
                  child: Container(
                    width: bl.radius,
                    height: bl.radius,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
