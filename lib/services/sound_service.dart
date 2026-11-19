import 'package:audioplayers/audioplayers.dart';

import "dart:math";

class SoundService {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> pressButton() async {
    await _player.play(AssetSource('sounds/button.wav'));
  }

  static Future<void> pressCancel() async {
    await _player.play(AssetSource('sounds/cancel.wav'));
  }

  static Future<void> win() async {
    await _player.play(AssetSource('sounds/win.wav'));
  }

  static Future<void> multiHit() async {
    final random = Random();

    int randInt = random.nextInt(5);

    String soundString = randInt >= 4
        ? 'sounds/multihit2.wav'
        : "sounds/multihit1.wav";

    await _player.play(AssetSource(soundString));
  }

  static Future<void> earnMoney() async {
    final random = Random();

    int randInt = 1 + random.nextInt(6);

    String soundString = "sounds/coin$randInt.wav";

    await _player.play(AssetSource(soundString));
  }
}
