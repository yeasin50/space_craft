import 'package:assets_audio_player/assets_audio_player.dart';

class SoundManager {
  static playSilencer() async {
    final fileSilencer = "assets/sound/Gun_Silencer.mp3";

    AssetsAudioPlayer player = AssetsAudioPlayer();
    player.open(Audio(fileSilencer));
  }

  static playLuger() async {
    final fileLuger = "assets/sound/Gun_Luger.mp3";
    AssetsAudioPlayer player = AssetsAudioPlayer();
    player.open(Audio(fileLuger));
  }
}
