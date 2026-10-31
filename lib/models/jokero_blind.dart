import 'jokero_ante.dart';

import 'package:jokero/constants/jokero_constants.dart';

class JokeroBlind {
  final String name;
  final int scoreToReach;
  final int reward;
  final String imageAsset;

  JokeroBlind({
    required this.name,
    required this.scoreToReach,
    required this.reward,
    required this.imageAsset,
  });
}

class JokeroBossBlind extends JokeroBlind {
  JokeroBossBlind(int baseScore)
    : super(
        name: "Boss blind",
        scoreToReach: baseScore * 2,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}The_Eye.png",
      );
}

class JokeroSmallBlind extends JokeroBlind {
  JokeroSmallBlind(int baseScore)
    : super(
        name: "Small Blind",
        scoreToReach: baseScore,
        reward: 3,
        imageAsset: "${blindImagePathPrefix}Small_Blind.png",
      );
}

class JokeroBigBlind extends JokeroBlind {
  JokeroBigBlind(int baseScore)
    : super(
        name: "Big Blind",
        scoreToReach: (baseScore * 1.5).toInt(),
        reward: 4,
        imageAsset: "${blindImagePathPrefix}Big_Blind.png",
      );
}
