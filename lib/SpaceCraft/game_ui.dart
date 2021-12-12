import 'package:flutter/material.dart';
import '../model/model.dart';
 

class SpaceCraftBody extends StatefulWidget {
  @override
  _SpaceCraftBodyState createState() => _SpaceCraftBodyState();
}

class _SpaceCraftBodyState extends State<SpaceCraftBody> {
  /// Game is running or Not
  bool _isPlaying = false;
  Ship _player = Ship();

  _updatePlayerPosition(double _posX, double _posY) {
    setState(() {
      _player.leftPos = _posX;
      _player.topPos = _posY;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GestureDetector(
        onTap: () => print("taped"),
        onPanUpdate: (details) {
          /// tuch possition
          var posX = details.globalPosition.dx;
          var posY = details.globalPosition.dy;

          /// we are separating in two section, it'll help to move though another axis stuck
          /// it'll make sure that even One axis will work even other axis stuc
          if (posY >= constraints.maxHeight - _player.height / 2 ||
              posY <= _player.height / 2) {
            ///`we cant move in Y axix` outScreen
            ///may Add some effect like wave
          } else {
            _updatePlayerPosition(_player.leftPos, posY - (_player.height / 2));
          }
          if (posX >= constraints.maxWidth - _player.width / 2 ||
              posX <= _player.width / 2) {
            ///`we cant move in X axix` outScreen
          } else {
            _updatePlayerPosition(posX - _player.width / 2, _player.topPos);
          }

          // if (inScreen) updatePlayer(posX, size.height - posY);
        },
        child: Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          color: Colors.blue.withOpacity(.3),
          child: Stack(
            children: [
              Positioned(
                  top: _player.topPos,
                  left: _player.leftPos,
                  child: Container(
                    color: Colors.amber,
                    width: _player.width,
                    height: _player.height,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
