import 'package:jokero/models/jokero_hand_evaluator.dart';
import 'package:jokero/models/jokero_score.dart';
import 'package:jokero/viewmodels/game_view_model.dart';

import "jokero_card.dart";

enum JokerRarity { common, uncommon, rare, legendary }

class JokeroJoker {
  final String id;
  final String name;
  final JokerRarity rarity;
  final String description;
  final int cost;

  JokeroJoker({
    required this.id,
    required this.name,
    required this.rarity,
    required this.description,
    required this.cost,
  });

  int get sellPrice => (cost / 2).ceil();

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is JokeroJoker && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;

  void onCardScored(JokeroCard card, JokeroScore score) {}

  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {}

  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
  ) {}

  void onRoundEnd(GameViewModel viewmodel) {}
}

class Joker extends JokeroJoker {
  Joker()
    : super(
        id: 'joker',
        name: 'Joker',
        rarity: .common,
        description: "+4 Multi",
        cost: 2,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
  ) {
    score.multi += 4;
  }
}

class JokerAvide extends JokeroJoker {
  JokerAvide()
    : super(
        id: 'joker_avide',
        name: 'Joker Avide',
        rarity: .common,
        description: "Les cartes jouées de la suite Carreau octroient +3 Multi. lorsqu'elles marquent des points.",
        cost: 5,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .diamond) {
      score.multi += 3;
    }
  }
}

class JokerLubrique extends JokeroJoker {
  JokerLubrique()
    : super(
        id: 'joker_lubrique',
        name: 'Joker Lubrique',
        rarity: .common,
        description: "Les cartes jouées de suite Cœur octroient +3 Multi, lorsqu'elles marquent des points.",
        cost: 5,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .heart) {
      score.multi += 3;
    }
  }
}

class JokerFurieux extends JokeroJoker {
  JokerFurieux()
    : super(
        id: 'joker_furieux',
        name: 'Joker Furieux',
        rarity: .common,
        description: "Les cartes jouées de la suite Pique octroient +3 Multi, lorsqu'elles marquent des points.",
        cost: 5,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .spade) {
      score.multi += 3;
    }
  }
}

class JokerGlouton extends JokeroJoker {
  JokerGlouton()
    : super(
        id: 'joker_glouton',
        name: 'Joker Glouton',
        rarity: .common,
        description: "Les cartes jouées de la suite Trèfle octroient +3 Multi, lorsqu'elles marquent des points.",
        cost: 5,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .club) {
      score.multi += 3;
    }
  }
}
