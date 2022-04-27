import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../../model/model.dart';
import '../../../provider/provider.dart';
import '../../../widget/widget.dart';
import 'custom_button.dart';

class SettingView extends ConsumerWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final UserSetting settings = ref.watch<UserSetting>(userSettingProvider);
    const TextStyle textStyle = TextStyle(
      color: Color.fromARGB(255, 135, 152, 158),
    );
    const TextStyle textStyleTitle = TextStyle(
      color: Color.fromARGB(245, 252, 252, 252),
      fontWeight: FontWeight.bold,
    );
    return GlassMorphism(
      blur: 1,
      opacity: .4,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "User Setting",
              style: textStyleTitle,
            ),
            const SizedBox(height: 16),
            musicSetting(settings, textStyle),
            soundSetting(settings, textStyle),
            effectSetting(settings, textStyle),
            const SizedBox(height: 16),
            movementSensivity(
              settings,
              titleTextStyle: textStyleTitle,
              textStyle: textStyle,
            ),
            const SizedBox(height: 16),
            playMode(settings, textStyleTitle),
            const SizedBox(height: 16),
            controlMode(settings, textStyleTitle),
            const SizedBox(height: 24),
            SizedBox(
              width: 124,
              child: CustomButton(
                value: false,
                defaultColor: Colors.deepPurpleAccent,
                text: "Reset",
                callback: () {
                  settings.defaultSetting();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget controlMode(UserSetting settings, TextStyle textStyle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Controll mode",
          style: textStyle,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: ControlMode.values.map(
            (cMode) {
              return CustomButton(
                text: cMode.name.sentenceCase,
                value: settings.controlMode == cMode,
                callback: () {
                  settings.update(controlMode: cMode);
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget playMode(UserSetting settings, TextStyle textStyle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Play Mode",
          style: textStyle,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: PlayMode.values.map(
            (mode) {
              return CustomButton(
                text: mode.name.sentenceCase,
                value: settings.playmode == mode,
                callback: () {
                  settings.update(playMode: mode);
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Row effectSetting(UserSetting settings, TextStyle textStyle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Effect",
          style: textStyle,
        ),
        Switch(
          value: settings.effect,
          onChanged: (v) {
            settings.update(
              effect: !settings.effect,
            );
          },
        ),
      ],
    );
  }

  Row soundSetting(UserSetting settings, TextStyle textStyle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Sound",
          style: textStyle,
        ),
        Switch(
          value: settings.sound,
          onChanged: (v) {
            settings.update(
              sound: !settings.sound,
            );
          },
        ),
      ],
    );
  }

  Row musicSetting(UserSetting settings, TextStyle textStyle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Music",
          style: textStyle,
        ),
        Switch(
          value: settings.music,
          onChanged: (v) {
            settings.update(
              music: !settings.music,
            );
          },
        ),
      ],
    );
  }

  Widget movementSensivity(
    UserSetting settings, {
    required TextStyle titleTextStyle,
    required TextStyle textStyle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Sensivity",
          style: titleTextStyle,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Slow",
              style: textStyle,
            ),
            Slider(
              min: settings.minSensivity,
              max: settings.maxSensivity,
              value: settings.movementSensivity,
              onChanged: (value) {
                settings.update(
                  movementSensitvity: value,
                );
              },
            ),
            Text(
              "Fast",
              style: textStyle,
            ),
          ],
        ),
      ],
    );
  }
}
