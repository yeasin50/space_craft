import 'dart:async';
import 'dart:developer' as dbg;
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

  List<Bullet> playerBullets = [];
  Timer timerBulletMove, timerBulletmaker;
  final fps = 1 / 24;
  Bullet b = Bullet();

  final Random random = Random();

  ///`Enemy`
  Player enemy = Player(dx: 10, dy: 10);
  Timer timerEnemyMovement, timerEnemyMaker, timerEnemyShootOut;
  List<Player> enemies = [];
  List<Bullet> enemyBullets = [];
  Timer timerEBulletM;
  int numOfBullet = 1;
  var prevB_ID = 0;
  Bullet eTestBullet = Bullet(id: 2, position: BVector(123, 123), radius: 30);

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

      ///` bullet per second`
      // timerBulletmaker =
      //     Timer.periodic(Duration(seconds: 1), preOdicBulletThrow);
      // timerBulletMove = Timer.periodic(
      //     Duration(milliseconds: (100 * fps).floor()), frameBuild);

      ///`Enemy`

      //Enemy maker sheduler
      // timerEnemyMaker = Timer.periodic(Duration(seconds: 3), enemyGenarator);

      // timerEnemyMovement = Timer.periodic(
      //     Duration(milliseconds: (fps * 500).floor()),
      //     enemyFrameBuilde); //fps*bigNum = slower

      ///`enemies shootOut`
      // timerEnemyShootOut = Timer.periodic(Duration(seconds: 4), enemiesBullet);
      // timerEBulletM = Timer.periodic(
      //     Duration(milliseconds: (fps * 200).floor()), eneBulletsMov);
    });
  }

  ///`Ènemies maker`
  enemyGenarator(Timer timer) {
    /// `number of enemy per schedule`
    for (int i = 0; i < 1; i++) {
      var x = random.nextDouble().clamp(.1, .9) * (size.width);
      var y = random.nextDouble() * (-300.0);
      Player player = Player(dx: x, dy: y);
      enemies.add(player);
    }
  }

  ///`Enemy moveMent`
  enemyFrameBuilde(Timer timer) {
    if (enemies.length > 40) {
      dbg.log("CleanUp enemy");
      enemies.removeRange(0, 20);
    }

    enemies.forEach((enemy) {
      enemy.dy += 1;
    });
    // dbg.log(enemies.length.toString());
    setState(() {});
  }

  /// `enemies bullets`
  enemiesBullet(Timer timer) {
    enemies.forEach((e) {
      // dbg.log(e.dy.toString());
      if (e.dy > 0 && e.dy < size.height - 10) {
        /// shoot
        Bullet b = Bullet();
        b.id = numOfBullet++;
        b.position = BVector(e.dx, e.dy);
        b.radius = 5;
        b.mass = 10; //later workOn
        enemyBullets.add(b);
      }
    });
  }

  //enemies bullets movement
  eneBulletsMov(Timer timer) {
    if (enemyBullets.length > 100) {
      enemyBullets.removeRange(0, 30);
      dbg.log(" E bullets cleanUP");
    }
    enemyBullets.forEach((bl) {
      bl.position = BVector(bl.position.x, bl.position.y + 1);
      playerHit(bl);
    });
    setState(() {});
  }

  playerHit(Bullet b) {
    print(
        " bx: ${b.position.x} bY: ${b.position.y} ${player.dx} bY: ${player.dy} ");
    if (b.id != prevB_ID &&
        b.position.x < player.dx + player.width &&
        b.position.x > player.dx - player.width &&
        b.position.y < player.dy + player.height &&
        b.position.y > player.dy - player.height) {
      print("player Damage: bullet prev: $prevB_ID C: ${b.id}");
      setState(() {
        prevB_ID = b.id;
      });
    }
  }

////`For Player`
  preOdicBulletThrow(Timer timer) {
    bulletMaker();
  }

  ////`For Player`
  frameBuild(Timer timer) {
    b.position.x += 10;
    if (playerBullets.length > 20) playerBullets.removeRange(0, 5);
    playerBullets.forEach((element) {
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
    timerEnemyMaker.cancel();
    timerEnemyMovement.cancel();
    super.dispose();
  }

  void updatePlayerPosition(double dx, double dy) {
    setState(() {
      player.dx = dx;
      player.dy = dy;

      print(
          "P: ${dx.ceil()} ${dy.ceil()} B: ${eTestBullet.position.x} ${eTestBullet.position.y}");
    });
  }

// player Bullet
  void bulletMaker() {
    if (playerBullets.length > 20) {
      playerBullets.removeRange(0, 10);
    }
    Bullet b = Bullet();
    // b.position = BVector(random.nextDouble() * 360, 0);
    b.position = BVector(player.dx, player.dy == size.height ? 10 : player.dy);
    print(b.position.x);
    b.radius = random.nextInt(20).clamp(4, 20).ceilToDouble();
    playerBullets.add(b);

    print(" bullets ${playerBullets.length}");
  }

  @override
  Widget build(BuildContext context) {
    // log("Player dx : ${player.dx}  dy : ${player.dy}");
    return GestureDetector(
      onPanUpdate: (details) {
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
          ///`Player`
          Positioned(
            bottom: player.dy == size.height ? 10 : player.dy,
            left: player.dx,
            child: CustomPaint(
              painter: PlayerShip(player),
            ),
          ),

          ///`Player` `bullet List`
          ...playerBullets
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

          ////`Enemies`
          ...enemies
              .map(
                (e) => Positioned(
                  top: e.dy,
                  left: e.dx,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blue),
                  ),
                ),
              )
              .toList(),

          ...enemyBullets
              .map((eblt) => Positioned(
                    top: eblt.position.y,
                    left: eblt.position.x,
                    child: Container(
                      width: eblt.radius * 2,
                      height: eblt.radius * 2,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                    ),
                  ))
              .toList(),

          Positioned(
            top: eTestBullet.position.y,
            left: eTestBullet.position.x,
            child: Container(
              width: eTestBullet.radius * 2,
              height: eTestBullet.radius * 2,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            ),
          )
        ],
      ),
    );
  }
}
