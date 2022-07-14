import 'package:flutter/material.dart';

import '../../../core/entities/entities.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/widget/widget.dart';
import '../models/default_setting.dart';

class SettingView extends StatefulWidget {
  const SettingView({
    Key? key,
    this.onTapClose,
  }) : super(key: key);

  final VoidCallback? onTapClose;
  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final DefaultUserSetting settings = DefaultUserSetting.instance;

  static const TextStyle _textStyle = TextStyle(
    color: Color.fromARGB(255, 135, 152, 158),
  );

  static const TextStyle _textStyleTitle = TextStyle(
    color: Color.fromARGB(245, 252, 252, 252),
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
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
              style: _textStyleTitle,
            ),
            const SizedBox(height: 16),
            musicSetting(settings, _textStyle),
            soundSetting(settings, _textStyle),
            effectSetting(settings, _textStyle),
            const SizedBox(height: 16),
            movementSensitivity(
              settings,
              titleTextStyle: _textStyleTitle,
              textStyle: _textStyle,
            ),
            const SizedBox(height: 16),
            playMode(settings, _textStyleTitle),
            const SizedBox(height: 16),
            controlMode(settings, _textStyleTitle),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 124,
                  child: CustomButton(
                    value: false,
                    defaultColor: Color.fromARGB(137, 30, 80, 95),
                    text: "Reset",
                    callback: () {
                      setState(() {
                        settings.defaultSetting();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 124,
                  child: CustomButton(
                    value: false,
                    defaultColor: Color.fromARGB(106, 45, 55, 58),
                    text: "Close",
                    callback: widget.onTapClose,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget controlMode(DefaultUserSetting settings, TextStyle textStyle) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Control mode",
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
                  setState(() {});
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Widget playMode(DefaultUserSetting settings, TextStyle textStyle) {
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
          children: GamePlayMode.values.map(
            (mode) {
              return CustomButton(
                text: mode.name.sentenceCase,
                value: settings.gamePlayMode == mode,
                callback: () {
                  settings.update(playMode: mode);
                  setState(() {});
                },
              );
            },
          ).toList(),
        ),
      ],
    );
  }

  Row effectSetting(DefaultUserSetting settings, TextStyle textStyle) {
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
            setState(() {});
          },
        ),
      ],
    );
  }

  Row soundSetting(DefaultUserSetting settings, TextStyle textStyle) {
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
            settings.update(sound: !settings.sound);
            setState(() {});
          },
        ),
      ],
    );
  }

  Row musicSetting(DefaultUserSetting settings, TextStyle textStyle) {
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
            settings.update(music: !settings.music);
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget movementSensitivity(
    DefaultUserSetting settings, {
    required TextStyle titleTextStyle,
    required TextStyle textStyle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Sensitivity",
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
              min: settings.minSensitivity,
              max: settings.maxSensitivity,
              value: settings.movementSensitivity,
              onChanged: (value) {
                settings.update(movementSensitivity: value);
                setState(() {});
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
