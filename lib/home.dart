import 'dart:async';
import 'dart:developer' as dbg;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spaceCraft/GameManager/playerManager.dart';
import 'package:spaceCraft/GameManager/uiManager.dart';
import 'package:spaceCraft/configs/size.dart';
import 'package:spaceCraft/widget/explosion.dart';
import 'package:spaceCraft/widget/models/demo.dart';
import 'package:spaceCraft/widget/models/particle.dart';
import 'package:spaceCraft/widget/rives/rive_player.dart';
import 'package:spaceCraft/widget/headerLive.dart';
import 'package:spaceCraft/widget/headerScore.dart';
import 'package:spaceCraft/widget/health_meter.dart';
import 'package:spaceCraft/widget/models/bullet.dart';

import 'widget/models/player.dart';

import 'GameManager/sound_manager.dart';
import 'widget/rives/rive_explosion1.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  /// `Explosion on Collision`
  List<Demo> explosions = [];

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var provider;

  bool _isPlaying = false;
  bool _tempMoveable = false;
  bool _testModeStartG = false;

  final GlobalKey _rootSCRnKey = GlobalKey();
  Player player = Player(dx: 0, dy: 0);
  Size size = Size(0, 0);
  Rect boxSize = Rect.zero;

  ///startUp player Size
  double _playerSize;
  bool _large = true;
  double maxSize;
  double minSize;

  void _updateSize() {
    setState(() {
      _large = !_large;
      _playerSize = _large ? maxSize : minSize;
      _tempMoveable = !_tempMoveable;
      // player.dx = SizeConfig.screenWidth / 2 - minSize / 2;
      player.dy = 10;

      startGame();

      ///TODO:: Lets pass provider from here, does it improve performence 🤔
    });
  }

  ///`Engine Manager`
  startGame() {
    _isPlaying = true;
    // _testModeStartG = true;
    playerEngine();
    enemyEngine();
  }

  // List<Bullet> playerBullets = [];
  //   List<Player> enemies = [];
  // List<Bullet> enemyBullets = [];

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

  Timer timerEBulletM;
  int numOfBullet = 1;
  var prevB_ID = 0;
  Bullet eTestBullet = Bullet(id: 2, position: BVector(166, 123), radius: 40);
  Bullet eTestBullet2 = Bullet(id: 4, position: BVector(286, 143), radius: 30);

  // Demo demoEx = Demo(
  //   text: Text('C'),
  // );

  Explosion ex;

  ///`Game engine`
  @override
  void initState() {
    super.initState();
    b.position = BVector(100, 100);
    b.radius = 10;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      maxSize = getProportionateScreenWidth(400.0);
      minSize = getProportionateScreenWidth(150.0);
      _playerSize = maxSize;
      //center of x axis

      size = _rootSCRnKey.currentContext.size;
      print("size  $size");
      setState(() {
        maxSize = getProportionateScreenWidth(400.0);
        minSize = getProportionateScreenWidth(100.0);

        _playerSize = maxSize;
        player.width = minSize;
        player.height = minSize;

        player.dx = size.width / 2 - player.width / 2;
        player.dy = size.height / 2;
      });
      //
      boxSize = Rect.fromLTRB(0, 0, size.width, size.height);

      provider = Provider.of<UIManager>(context, listen: false);

      ///`Start Game engine`
      // playerEngine();
      // enemySchedular();
    });
  }

  playerEngine() {
    ///` bullet per second player`
    timerBulletmaker = Timer.periodic(Duration(seconds: 1), preOdicBulletThrow);
    timerBulletMove =
        Timer.periodic(Duration(milliseconds: (100 * fps).floor()), frameBuild);
  }

  /// `Enemy  maker sheduler`
  enemyEngine() {
    timerEnemyMaker = Timer.periodic(Duration(seconds: 2), enemyGenarator);

    timerEnemyMovement = Timer.periodic(
        Duration(milliseconds: (fps * 500).floor()),
        enemyFrameBuilde); //fps*bigNum = slower
    // ///`enemies shootOut`
    timerEnemyShootOut = Timer.periodic(Duration(seconds: 3), enemiesBullet);
    timerEBulletM = Timer.periodic(
        Duration(milliseconds: (fps * 200).floor()), eneBulletsMov);
  }

  ///`Ènemies maker`
  enemyGenarator(Timer timer) {
    final provider = Provider.of<UIManager>(context, listen: false);

    /// `number of enemy per schedule`
    for (int i = 0; i < 1; i++) {
      var x = random.nextDouble().clamp(.1, .9) * (size.width);
      var y = random.nextDouble() * (-300.0);
      Player player = Player(dx: x, dy: y);

      // enemies.add(player);

      ///TODO:: using provider
      provider.addEnemy(player);
    }
  }

  ///`Enemy moveMent`
  enemyFrameBuilde(Timer timer) {
    // if (provider.enemies.length > provider) {
    //   dbg.log("CleanUp enemy");
    //   enemies.removeRange(0, 20);
    // }

    provider.enemies.forEach((enemy) {
      enemy.dy += 1;
    });
    // dbg.log(enemies.length.toString());
    // setState(() {});
  }

  /// `enemies bullets Maker`
  enemiesBullet(Timer timer) {
    provider.enemies.forEach((e) {
      // dbg.log(e.dy.toString());
      if (e.dy > 0 && e.dy < size.height - 10) {
        /// shoot
        Bullet b = Bullet();
        b.id = numOfBullet++;
        b.position = BVector(e.dx, e.dy);
        b.radius = 5;
        b.mass = 10; //later workOn
        // enemyBullets.add(b);

        ///TODO:: using provider Add EnemyBullets here
        provider.addEnemyBullet(b);
      }
    });
  }

  ///`enemies bullets movement`
  ///It's making laggy, FIXMED:: because of printing on console
  eneBulletsMov(Timer timer) {
    List<Bullet> tempB = [];

    if (provider.enemyBullets.length != null)
      provider.enemyBullets.forEach((b) {
        // bl.position = BVector(bl.position.x, bl.position.y + 1);

        b.position.y += 1;

        ///`Take damage Player`
        if (b.id != prevB_ID &&
            b.position.x < player.dx + player.width &&
            b.position.x > player.dx - player.width &&
            size.height - b.position.y < player.dy + player.height &&
            size.height - b.position.y > player.dy - player.height) {
          /// remove bullet and take damage
          prevB_ID = b.id;
          tempB.add(b);

          Provider.of<PlayerManager>(context, listen: false)
              .damageHealth(DamageOnCollision.bullet);
        }
      });
    if (tempB.length > 0) provider.remEnemyBullet(bullets: tempB);
  }

////`For Player`
  preOdicBulletThrow(Timer timer) {
    bulletMaker();
  }

  ////`For Player `
  ///Bullets move
  frameBuild(Timer timer) {
    // b.position.x += 10;

    // if (playerBullets.length > 20) playerBullets.removeRange(0, 5);

    List<Bullet> tempPb = [];
    provider.playerBullets.forEach((pBullet) {
      if (pBullet != null) pBullet.position.y += 1;

      // print(pBullet.position.y);
      // if(pBullet.position.d)
      ///`direct remove will show a little error,  adding or removing objects from a collection during iteration. This is not allowed,`
      /// `since adding or removing items will change the collection size and mess up subsequent iteration`
      /// `we can store on temp variable later we remove this`
      if (pBullet.position.y > size.height) tempPb.add(pBullet);

      ///`Destroy Enemy`
      checkEnemyPoss(pBullet);
      //   if (prevPlayerBulletId != pBullet.id) {
      //     checkEnemyPoss(pBullet);
      //     prevPlayerBulletId = pBullet.id;
      //   }
    });
    // playerBullets.removeWhere((b) => tempPb.contains(b));
    provider.remPlayerBullet(bullets: tempPb);
    // setState(() {});
  }

  /// need to find an optimize way
  /// `destroy Enemy and Make explosions`
  /// TODO:: Little shape/radius bugs here
  checkEnemyPoss(Bullet pb) {
    ///`Test Object`
    // testObj(pb);

    List<Player> tempEnemy = [];
    List<Bullet> tempPb = [];

    provider.enemies.forEach((enemy) {
      if (size.height - pb.position.y < enemy.dy + enemy.height / 2 &&
          size.height - pb.position.y > enemy.dy - enemy.height / 2 &&
          pb.position.x < enemy.dx + enemy.width / 2 &&
          pb.position.x > enemy.dx - enemy.width / 2) {
        // dbg.log(" Destroy Enemy On bullet");

        tempEnemy.add(enemy);
        tempPb.add(pb);

        ///`Explosion` list makes laggy
        brust(PVector(enemy.dx, enemy.dy));

        // if (widget.explosions.isNotEmpty && widget.explosions.length > 4)
        //   widget.explosions.removeRange(0, 2);
        // dbg.log(" ex: ${widget.explosions.length}");

        addScore();
      }
    });

    ///`direct remove cause errors, check line251`
    // enemies.removeWhere((element) => tempEnemy.contains(element));
    // playerBullets.removeWhere((element) => playerBullets.contains(element));

    ///Using provider
    if (tempEnemy.length > 0) provider.remEnemy(enemies: tempEnemy);
  }

  ///`Explosion` list makes laggy
  brust(PVector pVector) {
    provider.addExplosion(ExplosionType.neonBrust, pVector);

    // dbg.log("Brust");
  }

  testObj(Bullet pb) {
    ///`Test Object`
    // dbg.log(
    //     "Epos: ${eTestBullet.position.y.toString()} B: ${(size.height - pb.position.y).ceil().toString()} $prevPlayerBulletId");
    if (size.height - pb.position.y <
            eTestBullet.position.y + eTestBullet.radius / 2 &&
        size.height - pb.position.y >
            eTestBullet.position.y - eTestBullet.radius / 2 &&
        pb.position.x < eTestBullet.position.x + eTestBullet.radius / 2 &&
        pb.position.x > eTestBullet.position.x - eTestBullet.radius / 2) {
      // dbg.log("Hit 1");
      // TODO:: make brust radius then sub hope it gonna work
      brust(PVector(eTestBullet.position.x, eTestBullet.position.y));
      // setState(() => playerBullets.remove(pb));
      provider.remPlayerBullet(b: pb);
    }

    if (size.height - pb.position.y <
            eTestBullet2.position.y + eTestBullet2.radius / 2 &&
        size.height - pb.position.y >
            eTestBullet2.position.y - eTestBullet2.radius / 2 &&
        pb.position.x < eTestBullet2.position.x + eTestBullet2.radius / 2 &&
        pb.position.x > eTestBullet2.position.x - eTestBullet2.radius / 2) {
      // dbg.log("Hit 2");
      brust(PVector(eTestBullet2.position.x, eTestBullet2.position.y));
      // setState(() => playerBullets.remove(pb));
      provider.remPlayerBullet(b: pb);
    }
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
    // print("PB maker");
    // if (playerBullets==null) return;

    ///TODO:: `player Bullet properties`
    Bullet b = Bullet();
    // b.position = BVector(random.nextDouble() * 360, 0);
    b.position =
        BVector(player.dx + player.height / 2, player.dy + player.height - 28);
    // print(b.position.x);
    // b.radius = random.nextInt(20).clamp(4, 20).ceilToDouble();
    b.radius = 5;
    b.color = Colors.yellow;

    // setState(() {
    b.id = pBC++;
    // playerBullets.add(b);
    // });
    provider.addPlayerBullet(b);

    /// player bullet sound
    SoundManager.playLuger();
  }

  /// `Score Managment`
  addScore() {
    Provider.of<PlayerManager>(context, listen: false).incrementScore();
  }

  minScore() {
    Provider.of<PlayerManager>(context, listen: false).decrementScore();
  }

  increaseHealth() {
    Provider.of<PlayerManager>(context, listen: false).increaseHealth();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // log("Player dx : ${player.dx}  dy : ${player.dy}");
    player.height = _playerSize;
    player.width = _playerSize;

    return GestureDetector(
      onPanUpdate: (details) {
        /// tuch possition
        var posX = details.globalPosition.dx;
        var posY = details.globalPosition.dy;

        /// we are separating in two section, it'll help to move though another axis stuck
        /// it'll make sure that even One axis will work even other axis stuc
        if (posY >= size.height - _playerSize / 2 ||
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
    var pdXL = player.dx;
    var scrw = size.width;
    var pdXR = scrw - player.dx;
    var w = pdXR + pdXL;
    // print("left: $pdXL  Right:$pdXR ${SizeConfig.screenWidth}==$w");
    return Container(
      ///TODO:: Background
      color: Colors.black38,
      key: _rootSCRnKey,
      child: Consumer<UIManager>(
        builder: (context, dataUI, child) => Stack(
          children: <Widget>[
            /// score and live
            if (_isPlaying || _testModeStartG)
              Positioned(
                top: 10,
                left: 10,
                child: HeaderScore(),
              ),
            if (_isPlaying || _testModeStartG)
              Positioned(
                top: getProportionateScreenHeight(20),
                left: getProportionateScreenWidth(80),
                right: getProportionateScreenHeight(120),
                child: HealthMeter(),
              ),
            if (_isPlaying || _testModeStartG)
              Positioned(
                right: 10,
                child: HeaderLive(),
              ),

            /// `Start Button`
            /// DONE:: fix anime
            Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: RaisedButton(
                child: Text("ps"),
                onPressed: _updateSize,
              ),
            ),

            ///`Player`
            Positioned(
              bottom: _tempMoveable ? player.dy : 150,
              left: _tempMoveable ? pdXL : 0,
              right: _tempMoveable ? pdXR - player.width : null,
              // child: CustomPaint(
              //   painter: PlayerShip(player),
              // ),
              child: AnimatedSize(
                curve: Curves.easeInOutBack,
                duration: Duration(seconds: 1),
                vsync: this,
                child: Container(
                  width: _playerSize,
                  height: _playerSize,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: PlayerRive(),
                  ),
                ),
              ),
            ),

            ///`Player` `bullet List`
            if (_isPlaying || _testModeStartG)
              ...dataUI.playerBullets
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
            if (_isPlaying)
              ...dataUI.enemies
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

            if (_isPlaying)
              ...dataUI.enemyBullets
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

            ///TODO:: on Explosion UI gets laggy
            /// `Single Explosion bug handler`
            /// Im changing rive to use explosion on game startUP UI
            if (dataUI.handleExpolosionBug)
              Positioned(
                left: dataUI.explosionBug.initPoss.x - 100,
                top: dataUI.explosionBug.initPoss.y - 100,
                child: Container(
                  width: 200,
                  height: 200,
                  child: RiveExplosion1(2),
                ),
              ),

            ...dataUI.explosion
                .map(
                  (e) => Positioned(
                    top: e.initPoss.y - 100,
                    left: e.initPoss.x - 100,
                    child: Container(
                      width: 200,
                      height: 200,
                      child: e.child,
                    ),
                  ),
                )
                .toList(),

            if (_testModeStartG)
              Positioned(
                top: eTestBullet.position.y,
                left: eTestBullet.position.x,
                child: Container(
                  width: eTestBullet.radius,
                  height: eTestBullet.radius,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
              ),
            if (_testModeStartG)
              Positioned(
                top: eTestBullet2.position.y,
                left: eTestBullet2.position.x,
                child: Container(
                  width: eTestBullet2.radius,
                  height: eTestBullet2.radius,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
