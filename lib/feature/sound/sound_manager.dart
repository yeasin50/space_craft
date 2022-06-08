import 'package:just_audio/just_audio.dart';

///FIXME:  add sound later
abstract class OnPlaySound {
  void playPlayerBulletSound();
  void stopPlayerBulletSound();

  void playOnPlayBackgroundMusic();
  void stopOnPlayBackgroundMusic();

  void playHealingSound();

  void playCollideSound();
}

class SoundManager extends OnPlaySound {
  static const _fileSilencer = "assets/sound/Gun_Silencer.mp3";
  static const _fileLuger = "assets/sound/Gun_Luger.mp3";

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
    await player.setAsset(_fileSilencer);
    player.play();
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
