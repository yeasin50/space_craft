import 'dart:async';
import 'dart:developer' as dbg;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/configs/size.dart';
import 'package:spaceCraft/rive_player.dart';
import 'package:spaceCraft/widget/headerLive.dart';
import 'package:spaceCraft/widget/headerScore.dart';
import 'package:spaceCraft/widget/models/bullet.dart';
import 'package:spaceCraft/widget/playerShip.dart';

import 'widget/models/player.dart';

import 'GameManager/sound_manager.dart';

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

  /// enemy destroyer

  var prevPlayerBulletId = 0;
  int pBC = 1;

  ///`Enemy`
  Player enemy = Player(dx: 10, dy: 10);
  Timer timerEnemyMovement, timerEnemyMaker, timerEnemyShootOut;
  List<Player> enemies = [];
  List<Bullet> enemyBullets = [];
  Timer timerEBulletM;
  int numOfBullet = 1;
  var prevB_ID = 0;
  Bullet eTestBullet = Bullet(id: 2, position: BVector(166, 123), radius: 30);

  /// `Provider`
  // var eProvider;

  @override
  void initState() {
    super.initState();
    b.position = BVector(100, 100);
    b.radius = 10;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// init provider
      // eProvider = Provider.of<EnemyProvider>(context);

      size = _rootSCRnKey.currentContext.size;
      print("size  $size");
      setState(() {
        player.dx = size.width / 2;
        player.dy = size.height;
      });
      //
      boxSize = Rect.fromLTRB(0, 0, size.width, size.height);

      ///` bullet per second player`
      timerBulletmaker =
          Timer.periodic(Duration(seconds: 1), preOdicBulletThrow);
      timerBulletMove = Timer.periodic(
          Duration(milliseconds: (100 * fps).floor()), frameBuild);

      ///`Enemy`

      // // Enemy maker sheduler
      timerEnemyMaker = Timer.periodic(Duration(seconds: 2), enemyGenarator);

      timerEnemyMovement = Timer.periodic(
          Duration(milliseconds: (fps * 500).floor()),
          enemyFrameBuilde); //fps*bigNum = slower
      // ///`enemies shootOut`
      timerEnemyShootOut = Timer.periodic(Duration(seconds: 3), enemiesBullet);
      timerEBulletM = Timer.periodic(
          Duration(milliseconds: (fps * 200).floor()), eneBulletsMov);
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

      ///TODO:: using provider
      // eProvider.addEnemy(player);
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

  /// `enemies bullets Maker`
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

        ///TODO:: using provider
        // Provider.of<EnemyProvider>(context).addEBullet(b);
      }
    });
  }

  ///`enemies bullets movement`
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

  ///`Take damage Player`
  playerHit(Bullet b) {
    // print(
    // " bx: ${b.position.x} bY: ${b.position.y} ${player.dx} bY: ${player.dy} ");
    if (b.id != prevB_ID &&
        b.position.x < player.dx + player.width &&
        b.position.x > player.dx - player.width &&
        size.height - b.position.y < player.dy + player.height &&
        size.height - b.position.y > player.dy - player.height) {
      /// remove bullet and take damage
      print("player Damage: bullet prev: $prevB_ID C: ${b.id}");
      setState(() {
        prevB_ID = b.id;
        enemyBullets.remove(b);
      });

      ///Provider
      Provider.of<PlayerManager>(context)
          .damageHealth(DamageOnCollision.bullet);
    }
  }

////`For Player`
  preOdicBulletThrow(Timer timer) {
    bulletMaker();
  }

  ////`For Player `
  ///Bullets move
  frameBuild(Timer timer) {
    // b.position.x += 10;

    if (playerBullets.length > 20) playerBullets.removeRange(0, 5);
    setState(() {});
    playerBullets.forEach((pBullet) {
      if (pBullet != null) pBullet.position.y += 1;

      // print(pBullet.position.y);
      // if(pBullet.position.d)
      if (pBullet.position.y > size.height) {
        playerBullets.remove(pBullet);
      }

      ///`Destroy Enemy`
      checkEnemyPoss(pBullet);
      //   if (prevPlayerBulletId != pBullet.id) {
      //     checkEnemyPoss(pBullet);
      //     prevPlayerBulletId = pBullet.id;
      //   }
    });
  }

  /// need to find an optimize way
  /// `destroy Enemy`
  /// TODO:: Little shape/radius bugs here
  checkEnemyPoss(Bullet pb) {
    ///`Test Object`
    // dbg.log(
    //     "Epos: ${eTestBullet.position.y.toString()} B: ${(size.height - pb.position.y).ceil().toString()} $prevPlayerBulletId");
    // if (size.height - pb.position.y <
    //         eTestBullet.position.y + eTestBullet.radius/2 &&
    //     size.height - pb.position.y >
    //         eTestBullet.position.y - eTestBullet.radius/2 &&
    //     pb.position.x < eTestBullet.position.x + eTestBullet.radius/2 &&
    //     pb.position.x > eTestBullet.position.x - eTestBullet.radius/2
    //     ) {
    //   dbg.log("Hit");
    //   setState(() => playerBullets.remove(pb));
    // }
    enemies.forEach((enemy) {
      if (size.height - pb.position.y < enemy.dy + enemy.height / 2 &&
          size.height - pb.position.y > enemy.dy - enemy.height / 2 &&
          pb.position.x < enemy.dx + enemy.width / 2 &&
          pb.position.x > enemy.dx - enemy.width / 2) {
        dbg.log(" Destroy Enemy On bullet");
        setState(() {
          enemies.remove(enemy);
          playerBullets.remove(pb);
        });
        Provider.of<PlayerManager>(context, listen: true).incrementScore();
      }
    });
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

      // print(
      //     "P: ${dx.ceil()} ${dy.ceil()} B: ${eTestBullet.position.x} ${eTestBullet.position.y}");
    });
  }

  /// `Bullet collision approch`
  /// enemies bullets going top to bottm but player and its bullets travel bottom to top
  /// Better approce to make it in same flow

  /// `player Bullet`
  void bulletMaker() async {
    // if (playerBullets==null) return;
    if (playerBullets.length > 20) {
      playerBullets.removeRange(0, 10);
    }

    ///TODO:: `player Bullet properties`
    Bullet b = Bullet();
    // b.position = BVector(random.nextDouble() * 360, 0);
    b.position =
        BVector(player.dx + 32, player.dy == size.height ? 50 : player.dy + 50);
    // print(b.position.x);
    // b.radius = random.nextInt(20).clamp(4, 20).ceilToDouble();
    b.radius = 5;
    b.color = Colors.yellow;

    setState(() {
      b.id = pBC++;
      playerBullets.add(b);
    });

    /// player bullet sound
    SoundManager.playLuger();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          updatePlayerPosition(
              player.dx, size.height - posY - player.height / 2);
        }
        if (posX >= size.width - player.width / 2 || posX <= player.width / 2) {
          ///`we cant move in X axix` outScreen
        } else {
          updatePlayerPosition(posX - player.width / 2, player.dy);
        }

        // if (inScreen) updatePlayer(posX, size.height - posY);
      },
      child: buildContainer(),
    );
  }

  Container buildContainer() {
    return Container(
      ///TODO:: Background
      color: Colors.black38,
      key: _rootSCRnKey,
      child: Stack(
        children: <Widget>[
          /// score and live
          Positioned(
            top: 10,
            child: HeaderScore(),
          ),
          Positioned(
            right: 10,
            child: HeaderLive(),
          ),

          ///`Player`
          Positioned(
            bottom: player.dy == size.height ? 10 : player.dy,
            left: player.dx,
            // child: CustomPaint(
            //   painter: PlayerShip(player),
            // ),
            child: Container(
              height: 70,
              width: 70,
              child: PlayerRive(),
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
                        shape: BoxShape.circle,
                        color: bl.color,
                      )),
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

          ///impliment provider

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

          // Positioned(
          //   top: eTestBullet.position.y,
          //   left: eTestBullet.position.x,
          //   child: Container(
          //     width: eTestBullet.radius,
          //     height: eTestBullet.radius,
          //     decoration:
          //         BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          //   ),
          // )
        ],
      ),
    );
  }
}
