import 'jokero_ante.dart';

import 'package:jokero/constants/jokero_constants.dart';

class JokeroBlind {
  final String name;
  final int scoreToReach;
  final int reward;

  JokeroBlind({
    required this.name,
    required this.scoreToReach,
    required this.reward,
  });
}

class JokeroBossBlind extends JokeroBlind {
  JokeroBossBlind(int baseScore)
    : super(name: "Boss blind", scoreToReach: baseScore * 2, reward: 5);
}

class JokeroSmallBlind extends JokeroBlind {
  JokeroSmallBlind(int baseScore)
    : super(name: "Small Blind", scoreToReach: baseScore, reward: 3);
}

class JokeroBigBlind extends JokeroBlind {
  JokeroBigBlind(int baseScore)
    : super(
        name: "Big Blind",
        scoreToReach: (baseScore * 1.5).toInt(),
        reward: 4,
      );
}
