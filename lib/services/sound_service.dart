import 'package:audioplayers/audioplayers.dart';

import "dart:math";

class SoundService {
  static final AudioPlayer _player = AudioPlayer();
  static bool enableAudio = true;

  static Future<void> pressButton() async {
    if (!enableAudio) return;
    try {
      await _player.play(AssetSource('sounds/button.wav'));
    } catch (_) {}
  }

  static Future<void> pressCancel() async {
    if (!enableAudio) return;
    try {
      await _player.play(AssetSource('sounds/cancel.wav'));
    } catch (_) {}
  }

  static Future<void> win() async {
    if (!enableAudio) return;
    try {
      await _player.play(AssetSource('sounds/win.wav'));
    } catch (_) {}
  }

  static Future<void> multiHit() async {
    if (!enableAudio) return;
    final random = Random();

    int randInt = random.nextInt(5);

    String soundString = randInt >= 4
        ? 'sounds/multihit2.wav'
        : "sounds/multihit1.wav";

    try {
      await _player.play(AssetSource(soundString));
    } catch (_) {}
  }

  static Future<void> earnMoney() async {
    if (!enableAudio) return;
    final random = Random();

    int randInt = 1 + random.nextInt(6);

    String soundString = "sounds/coin$randInt.wav";

    try {
      await _player.play(AssetSource(soundString));
    } catch (_) {}
  }
}
