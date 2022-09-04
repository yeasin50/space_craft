import 'package:flutter/material.dart';

import 'sound_manager.dart';

class AudioTestPage extends StatefulWidget {
  const AudioTestPage({Key? key}) : super(key: key);

  @override
  State<AudioTestPage> createState() => _AudioTestPageState();
}

class _AudioTestPageState extends State<AudioTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          IconButton(
            onPressed: () async {
                SoundManager.instance.playPlayerBulletSound();
            },
            icon: Text("mp3 "),
          ),
          IconButton(
            onPressed: () async {
              // await SoundManager.playLuger();
            },
            icon: Text("AssetsAudioPlayer"),
          ),
          IconButton(
            onPressed: () async {
              // await SoundManager.playSilencer();
              // await SoundManager.playLuger();
            },
            icon: Text("playerAudioPlayer"),
          ),
        ],
      ),
    );
  }
}
