import 'package:audioplayers/audioplayers.dart';

abstract class OnPlaySound {
  void playPlayerBulletSound();
  void stopPlayerBulletSound();

  void playOnPlayBackgroundMusic();
  void stopOnPlayBackgroundMusic();

  void playHealingSound();

  void playCollideSound();
}

class SoundManager extends OnPlaySound {
  static const _fileSilencer = "sound/gun_silencer.mp3";
  static const _fileLuger = "sound/gun_luger.mp3";
  static const _fileSilencer1 = "sound/gun_silencer.wav";
  static const _fileLuger1 = "sound/gun_luger.mp3";

  static final SoundManager instance = SoundManager._privateConstructor();
  SoundManager._privateConstructor();

  @override
  void playHealingSound() {
    UnimplementedError();
  }

  @override
  void playOnPlayBackgroundMusic() {
    UnimplementedError();
  }

  @override
  void playPlayerBulletSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource(_fileSilencer1));
  }

  @override
  void stopOnPlayBackgroundMusic() {
    UnimplementedError();
  }

  @override
  void stopPlayerBulletSound() {
    UnimplementedError();
  }

  @override
  void playCollideSound() {
    UnimplementedError();
  }
}
