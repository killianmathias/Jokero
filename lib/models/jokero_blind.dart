import 'package:jokero/models/jokero_hand_evaluator.dart';
import 'package:jokero/viewmodels/game_view_model.dart';
import 'package:jokero/models/jokero_card.dart';
import 'package:jokero/models/jokero_score.dart';

import "dart:math";

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
  final String description;

  JokeroBossBlind({
    required super.name,
    required super.scoreToReach,
    required super.reward,
    required super.imageAsset,
    required this.description,
  });

  void onRoundStart(GameViewModel viewModel) {}

  bool isCardDebuffed(JokeroCard card) => false;

  bool canPlayHand(
    JokeroHandCombinaison combinaison,
    List<JokeroCard> cards,
    GameViewModel viewModel,
  ) => true;

  void onEvaluateScore(JokeroScore score) {}

  void onHandPlayed(
    JokeroHandCombinaison combinaison,
    GameViewModel viewModel,
  ) {}
}

class JokeroSmallBlind extends JokeroBlind {
  JokeroSmallBlind(int baseScore)
    : super(
        name: "Petite Blinde",
        scoreToReach: baseScore,
        reward: 3,
        imageAsset: "${blindImagePathPrefix}Small_Blind.png",
      );
}

class JokeroBigBlind extends JokeroBlind {
  JokeroBigBlind(int baseScore)
    : super(
        name: "Grosse Blinde",
        scoreToReach: (baseScore * 1.5).toInt(),
        reward: 4,
        imageAsset: "${blindImagePathPrefix}Big_Blind.png",
      );
}

typedef JokeroBossBlindBuilder = JokeroBossBlind Function(int baseScore);

class TheHook extends JokeroBossBlind {
  TheHook(int baseScore)
    : super(
        name: "L'Hameçon",
        description: "Défausse 2 cartes aléatoires par main jouée.",
        scoreToReach: baseScore * 2,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_hook.png",
      );

  @override
  void onHandPlayed(
    JokeroHandCombinaison combinaison,
    GameViewModel viewModel,
  ) {
    for (var i = 0; i < 2; i++) {
      int handSize = viewModel.hand.hand.length;
      int random = Random().nextInt(handSize);
      viewModel.hand.hand.removeAt(random);
    }
  }
}
