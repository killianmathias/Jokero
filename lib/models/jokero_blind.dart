import 'package:jokero/models/jokero_hand.dart';
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

  void onRoundEnd(GameViewModel viewModel) {}
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
      if (viewModel.hand.hand.isEmpty) break;
      int handSize = viewModel.hand.hand.length;
      int random = Random().nextInt(handSize);
      viewModel.hand.hand.removeAt(random);
    }
  }
}

class TheOx extends JokeroBossBlind {
  TheOx(int baseScore)
    : super(
        name: "Le boeuf",
        description: "Jouer la main la plus jouée fixe l'argent à 0\$.",
        scoreToReach: baseScore * 2,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_ox.png",
      );

  @override
  void onHandPlayed(
    JokeroHandCombinaison combinaison,
    GameViewModel viewModel,
  ) {
    final mostPlayed = viewModel.statsManager.stats.getMostPlayedHand();
    if (mostPlayed != null && combinaison.pokerHand == mostPlayed) {
      viewModel.money = 0;
    }
  }
}

class TheWall extends JokeroBossBlind {
  TheWall(int baseScore)
    : super(
        name: "Le mur",
        description: "Super grosse Blinde.",
        scoreToReach: 4 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_wall.png",
      );
}

class TheClub extends JokeroBossBlind {
  TheClub(int baseScore)
    : super(
        name: "Le club",
        description: "Toutes les cartes Trèfle voient leur bonus disparaître.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_club.png",
      );

  @override
  bool isCardDebuffed(JokeroCard card) {
    return card.suit == .club;
  }
}

class TheGoad extends JokeroBossBlind {
  TheGoad(int baseScore)
    : super(
        name: "L'aiguillon",
        description: "Toutes les cartes Pique voient leur bonus disparaître.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_goad.png",
      );

  @override
  bool isCardDebuffed(JokeroCard card) {
    return card.suit == .spade;
  }
}

class TheWindow extends JokeroBossBlind {
  TheWindow(int baseScore)
    : super(
        name: "La fenêtre",
        description: "Toutes les cartes Carreau voient leur bonus disparaître.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_window.png",
      );

  @override
  bool isCardDebuffed(JokeroCard card) {
    return card.suit == .diamond;
  }
}

class ThePlant extends JokeroBossBlind {
  ThePlant(int baseScore)
    : super(
        name: "La plante",
        description: "Toutes les cartes Figure voient leur bonus disparaître.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_plant.png",
      );

  @override
  bool isCardDebuffed(JokeroCard card) {
    return card.rank == .jack || card.rank == .queen || card.rank == .king;
  }
}

class TheHead extends JokeroBossBlind {
  TheHead(int baseScore)
    : super(
        name: "La tête",
        description: "Toutes les cartes Cœur voient leur bonus disparaître",
        scoreToReach: baseScore * 2,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_head.png",
      );

  @override
  bool isCardDebuffed(JokeroCard card) {
    return card.suit == .heart;
  }
}

class ThePsychic extends JokeroBossBlind {
  ThePsychic(int baseScore)
    : super(
        name: "Le médium",
        description: "5 cartes doivent être jouées.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_psychic.png",
      );

  @override
  bool canPlayHand(
    JokeroHandCombinaison combinaison,
    List<JokeroCard> cards,
    GameViewModel viewModel,
  ) {
    return cards.length == 5;
  }
}

class TheWater extends JokeroBossBlind {
  TheWater(int baseScore)
    : super(
        name: "L'eau",
        description: "Commence avec 0 défausses.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_water.png",
      );

  @override
  void onRoundStart(GameViewModel viewModel) {
    viewModel.remainingDiscards = 0;
  }
}

class TheManacle extends JokeroBossBlind {
  TheManacle(int baseScore)
    : super(
        name: "Le carcan",
        description: "Taille de la main -1.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_manacle.png",
      );

  @override
  void onRoundStart(GameViewModel viewModel) {
    numberOfCardsInHand -= 1;
  }

  @override
  void onRoundEnd(GameViewModel viewModel) {
    numberOfCardsInHand = initialNumberOfCardsInHand;
  }
}

class TheEye extends JokeroBossBlind {
  Set<JokeroPokerHand> playedHands;
  TheEye(int baseScore)
    : playedHands = {},
      super(
        name: "L'œil",
        description: "Pas de types de main répétés cette manche-ci.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_eye.png",
      );

  @override
  void onHandPlayed(
    JokeroHandCombinaison combinaison,
    GameViewModel viewModel,
  ) {
    playedHands.add(combinaison.pokerHand);
  }

  @override
  bool canPlayHand(
    JokeroHandCombinaison combinaison,
    List<JokeroCard> cards,
    GameViewModel viewModel,
  ) {
    return !playedHands.contains(combinaison.pokerHand);
  }
}

class TheMouth extends JokeroBossBlind {
  JokeroPokerHand? playedHand;
  TheMouth(int baseScore)
    : playedHand = null,
      super(
        name: "La bouche",
        description: "Un seul type de main peut être jouée.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_mouth.png",
      );

  @override
  void onHandPlayed(
    JokeroHandCombinaison combinaison,
    GameViewModel viewModel,
  ) {
    playedHand ??= combinaison.pokerHand;
  }

  @override
  bool canPlayHand(
    JokeroHandCombinaison combinaison,
    List<JokeroCard> cards,
    GameViewModel viewModel,
  ) {
    return playedHand == null || combinaison.pokerHand == playedHand;
  }
}

class TheSnake extends JokeroBossBlind {
  TheSnake(int baseScore)
    : super(
        name: "Le serpent",
        description: "Après avoir joué ou défaussé, tire toujours 3 cartes.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_snake.png",
      );

  @override
  void onHandPlayed(
    JokeroHandCombinaison combinaison,
    GameViewModel viewModel,
  ) {
    viewModel.deck.draw(3);
  }
}

class TheNeedle extends JokeroBossBlind {
  TheNeedle(int baseScore)
    : super(
        name: "L'aiguille",
        description: "Ne jouez qu'une main.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_needle.png",
      );

  @override
  void onRoundStart(GameViewModel viewModel) {
    viewModel.remainingHands = 1;
  }
}

class TheTooth extends JokeroBossBlind {
  TheTooth(int baseScore)
    : super(
        name: "La dent",
        description: "Perte d'1\$ par carte jouée.",
        scoreToReach: 2 * baseScore,
        reward: 5,
        imageAsset: "${blindImagePathPrefix}boss/the_tooth.png",
      );

  @override
  void onHandPlayed(
    JokeroHandCombinaison combinaison,
    GameViewModel viewModel,
  ) {
    viewModel.money = max(
      viewModel.money - viewModel.hand.selectedCards.length,
      0,
    );
  }
}
