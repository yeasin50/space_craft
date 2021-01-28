import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:spaceCraft/widget/sound_manager.dart';
/// in main funtion
// AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
//   print(notification.audioId);
//   return true;
// });
class Tester extends StatefulWidget {
  Tester({Key key}) : super(key: key);

  @override
  _TesterState createState() => _TesterState();
}

class _TesterState extends State<Tester> {
  bool _playingOne = false, _playingSecond = false;
  var _playingSong = false;

  String fileSilencer = "assets/sound/Gun_Silencer.mp3";
  String fileLuger = "assets/sound/Gun_Luger.mp3";

  handleSong() {
    setState(() {
      _playingSong = !_playingSong;
    });
  }

  handleGLuger() async {
    // AssetsAudioPlayer player = AssetsAudioPlayer();
    // player.open(Audio(fileLuger));

    setState(() {
      _playingSecond = !_playingSecond;
    });
  }

  handleSilencer() async {
    setState(() {
      // if (!_playingOne) {
      //   AssetsAudioPlayer player = AssetsAudioPlayer();
      //   player.open(Audio(fileSilencer));
      // }
      _playingOne = !_playingOne;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                splashRadius: 30,
                splashColor: Colors.yellow,
                color: Colors.blue,
                icon: _playingOne
                    ? Icon(
                        Icons.pause,
                        size: 40,
                      )
                    : Icon(
                        Icons.play_arrow,
                        size: 40,
                      ),
                onPressed: SoundManager.playSilencer,
              ),
              Text("Gun Silencer"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                splashRadius: 30,
                splashColor: Colors.yellow,
                color: Colors.pink,
                icon: _playingSecond
                    ? Icon(
                        Icons.pause,
                        size: 40,
                      )
                    : Icon(
                        Icons.play_arrow,
                        size: 40,
                      ),
                onPressed: SoundManager.playLuger,
              ),
              Text("Gun Luger"),
            ],
          ),
        ],
      ),
    );
  }
}
