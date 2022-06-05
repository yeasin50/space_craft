import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

// import 'package:audioplayers/audioplayers.dart' as audio_players;
// import 'package:assets_audio_player/assets_audio_player.dart' as assets_audio;

class SoundManager {
  static const _fileSilencer = "assets/sound/Gun_Silencer.mp3";
  static const _fileLuger = "assets/sound/Gun_Luger.mp3";

  SoundManager() {
    init();
  }
  static void init() async {}

  static playSilencer() async {
    final _player = AudioPlayer();
    await _player.setAsset(_fileSilencer);
    await _player.play();
  }

  static playLuger() async {
    final player = AudioPlayer();
    await player.setAsset(_fileLuger);
    player.play();
  }

  // static playerAudioPlayer() async {
  //   final audioPlayer =
  //       audio_players.AudioPlayer(mode: audio_players.PlayerMode.LOW_LATENCY);
  //   await audioPlayer.play(_fileSilencer, isLocal: true);
  // }
}
