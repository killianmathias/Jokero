import 'package:jokero/constants/jokero_constants.dart';
import 'package:jokero/models/jokero_hand_evaluator.dart';
import 'package:jokero/models/jokero_score.dart';
import 'package:jokero/viewmodels/game_view_model.dart';

import 'dart:math';

import "package:flutter/material.dart";

import "jokero_card.dart";

enum JokerRarity {
  common("Commun", commonColor),
  uncommon("Peu commun", uncommonColor),
  rare("Rare", rareColor),
  legendary("Légendaire", legendaryColor);

  JokerRarity(this.label, this.color);

  final String label;
  final Color color;
}

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

  String get imageAsset => "$jokerImagePathPrefix$id.png";

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
    int remainingHands,
    int remainingDiscards,
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
    int remainingHands,
    int remainingDiscards,
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

class JokerAbstrait extends JokeroJoker {
  JokerAbstrait()
    : super(
        id: 'joker_abstrait',
        name: 'Joker Abstrait',
        rarity: .common,
        description: "+3 Multi pour chaque carte Joker",
        cost: 4,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    score.multi += (allJokers.length - 1) * 3;
  }
}

class JokerAncient extends JokeroJoker {
  Suit suit;

  JokerAncient()
    : suit = Suit.values[Random().nextInt(Suit.values.length)],
      super(
        id: 'joker_ancient',
        name: 'Joker Ancien',
        rarity: .rare,
        description: "",
        cost: 8,
      );

  @override
  String get description =>
      "Les cartes jouées de couleur ${suit.name} donnent x1.5 Multi.";

  @override
  void onRoundEnd(GameViewModel viewmodel) {
    final availableSuits = Suit.values.toList();
    suit = availableSuits[Random().nextInt(availableSuits.length)];
  }

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == this.suit) {
      score.multi *= 1.5;
    }
  }
}

class ArrowHead extends JokeroJoker {
  ArrowHead()
    : super(
        id: 'arrowhead',
        name: 'Pointe de flèche',
        rarity: .uncommon,
        description: "Les cartes jouées de la suite de pique donnent +50 jetons lorsqu'elles marquent des points.",
        cost: 7,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .spade) {
      score.chips += 50;
    }
  }
}

class JokeroBanner extends JokeroJoker {
  JokeroBanner()
    : super(
        id: 'banner',
        name: 'Bannière',
        rarity: .common,
        description: "+30 jetons pour chaque défausse restante.",
        cost: 5,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    score.chips += 30 * remainingDiscards;
  }
}

class Acrobat extends JokeroJoker {
  Acrobat()
    : super(
        id: "acrobat",
        name: "Acrobate",
        rarity: .uncommon,
        description: "X3 Multi sur la dernière main de la manche.",
        cost: 6,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (remainingHands == 1) {
      score.multi *= 3;
    }
  }
}

class Baron extends JokeroJoker {
  Baron()
    : super(
        id: "baron",
        name: "Baron",
        rarity: .rare,
        description: "Chaque Roi dans la main donne x1.5 multi.",
        cost: 8,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .king) {
      score.multi += 1.5;
    }
  }
}

class JokerJovial extends JokeroJoker {
  JokerJovial()
    : super(
        id: 'joker_jovial',
        name: 'Joker Jovial',
        rarity: .common,
        description: "+8 Multi si la main jouée contient une Paire.",
        cost: 3,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .pair ||
        combinaison.pokerHand == .twoPair ||
        combinaison.pokerHand == .threeOfAKind ||
        combinaison.pokerHand == .fullHouse ||
        combinaison.pokerHand == .fourOfAKind) {
      score.multi += 8;
    }
  }
}

class JokerDrole extends JokeroJoker {
  JokerDrole()
    : super(
        id: 'joker_drole',
        name: 'Joker Drôle',
        rarity: .common,
        description: "+12 Multi si la main jouée contient un Brelan.",
        cost: 4,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .threeOfAKind ||
        combinaison.pokerHand == .fullHouse ||
        combinaison.pokerHand == .fourOfAKind) {
      score.multi += 12;
    }
  }
}

class JokerLoufoque extends JokeroJoker {
  JokerLoufoque()
    : super(
        id: 'joker_loufoque',
        name: 'Joker Loufoque',
        rarity: .common,
        description: "+10 Multi si la main jouée contient une Double Paire.",
        cost: 4,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .twoPair ||
        combinaison.pokerHand == .fullHouse) {
      score.multi += 10;
    }
  }
}

class JokerCingle extends JokeroJoker {
  JokerCingle()
    : super(
        id: 'joker_cingle',
        name: 'Joker Cinglé',
        rarity: .common,
        description: "+12 Multi si la main jouée contient une Suite.",
        cost: 4,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .straight ||
        combinaison.pokerHand == .straightFlush) {
      score.multi += 12;
    }
  }
}

class JokerMaboul extends JokeroJoker {
  JokerMaboul()
    : super(
        id: 'joker_maboul',
        name: 'Joker Maboul',
        rarity: .common,
        description: "+10 Multi si la main jouée contient une Couleur.",
        cost: 4,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .flush ||
        combinaison.pokerHand == .straightFlush) {
      score.multi += 10;
    }
  }
}

class JokerFute extends JokeroJoker {
  JokerFute()
    : super(
        id: 'joker_fute',
        name: 'Joker Futé',
        rarity: .common,
        description: "+50 Jetons si la main jouée contient une Paire.",
        cost: 3,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .pair ||
        combinaison.pokerHand == .twoPair ||
        combinaison.pokerHand == .threeOfAKind ||
        combinaison.pokerHand == .fullHouse ||
        combinaison.pokerHand == .fourOfAKind) {
      score.chips += 50;
    }
  }
}

class JokerRuse extends JokeroJoker {
  JokerRuse()
    : super(
        id: 'joker_ruse',
        name: 'Joker Rusé',
        rarity: .common,
        description: "+100 Jetons si la main jouée contient un Brelan.",
        cost: 4,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .threeOfAKind ||
        combinaison.pokerHand == .fullHouse ||
        combinaison.pokerHand == .fourOfAKind) {
      score.chips += 100;
    }
  }
}

class JokerAstucieux extends JokeroJoker {
  JokerAstucieux()
    : super(
        id: 'joker_astucieux',
        name: 'Joker Astucieux',
        rarity: .common,
        description: "+80 Jetons si la main jouée contient une Double Paire.",
        cost: 4,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .twoPair ||
        combinaison.pokerHand == .fullHouse) {
      score.chips += 80;
    }
  }
}

class JokerSournois extends JokeroJoker {
  JokerSournois()
    : super(
        id: 'joker_sournois',
        name: 'Joker Sournois',
        rarity: .common,
        description: "+100 Jetons si la main jouée contient une Suite.",
        cost: 4,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .straight ||
        combinaison.pokerHand == .straightFlush) {
      score.chips += 100;
    }
  }
}

class JokerHabile extends JokeroJoker {
  JokerHabile()
    : super(
        id: 'joker_habile',
        name: 'Joker Habile',
        rarity: .common,
        description: "+80 Jetons si la main jouée contient une Couleur.",
        cost: 4,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .flush ||
        combinaison.pokerHand == .straightFlush) {
      score.chips += 80;
    }
  }
}

class LeDuo extends JokeroJoker {
  LeDuo()
    : super(
        id: 'the_duo',
        name: 'Le Duo',
        rarity: .rare,
        description: "X2 Multi si la main jouée contient une Paire.",
        cost: 8,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .pair ||
        combinaison.pokerHand == .twoPair ||
        combinaison.pokerHand == .threeOfAKind ||
        combinaison.pokerHand == .fullHouse ||
        combinaison.pokerHand == .fourOfAKind) {
      score.multi *= 2;
    }
  }
}

class LeTrio extends JokeroJoker {
  LeTrio()
    : super(
        id: 'the_trio',
        name: 'Le Trio',
        rarity: .rare,
        description: "X3 Multi si la main jouée contient un Brelan.",
        cost: 8,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .threeOfAKind ||
        combinaison.pokerHand == .fullHouse ||
        combinaison.pokerHand == .fourOfAKind) {
      score.multi *= 3;
    }
  }
}

class LaFamille extends JokeroJoker {
  LaFamille()
    : super(
        id: 'the_family',
        name: 'La Famille',
        rarity: .rare,
        description: "X4 Multi si la main jouée contient un Carré.",
        cost: 8,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .fourOfAKind) {
      score.multi *= 4;
    }
  }
}

class LOrdre extends JokeroJoker {
  LOrdre()
    : super(
        id: 'the_order',
        name: "L'Ordre",
        rarity: .rare,
        description: "X3 Multi si la main jouée contient une Suite.",
        cost: 8,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .straight ||
        combinaison.pokerHand == .straightFlush) {
      score.multi *= 3;
    }
  }
}

class LaTribu extends JokeroJoker {
  LaTribu()
    : super(
        id: 'the_tribe',
        name: 'La Tribu',
        rarity: .rare,
        description: "X2 Multi si la main jouée contient une Couleur.",
        cost: 8,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    if (combinaison.pokerHand == .flush ||
        combinaison.pokerHand == .straightFlush) {
      score.multi *= 2;
    }
  }
}

class OnyxAgate extends JokeroJoker {
  OnyxAgate()
    : super(
        id: 'onyx_agate',
        name: 'Agate Onyx',
        rarity: .uncommon,
        description: "Les cartes jouées de couleur Trèfle donnent +7 Multi lorsqu'elles marquent des points.",
        cost: 7,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .club) {
      score.multi += 7;
    }
  }
}

class Bloodstone extends JokeroJoker {
  Bloodstone()
    : super(
        id: 'bloodstone',
        name: 'Pierre de sang',
        rarity: .uncommon,
        description: "1 chance sur 2 pour que les cartes jouées de couleur Cœur donnent X1.5 Multi.",
        cost: 7,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .heart && Random().nextBool()) {
      score.multi *= 1.5;
    }
  }
}

class RoughGem extends JokeroJoker {
  RoughGem()
    : super(
        id: 'rough_gem',
        name: 'Gemme brute',
        rarity: .uncommon,
        description: "Les cartes jouées de couleur Carreau donnent +25 Jetons lorsqu'elles marquent.",
        cost: 7,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .diamond) {
      score.chips += 25;
    }
  }
}

class Fibonacci extends JokeroJoker {
  Fibonacci()
    : super(
        id: 'fibonacci',
        name: 'Fibonacci',
        rarity: .uncommon,
        description: "Chaque As, 2, 3, 5 ou 8 joué donne +8 Multi lorsqu'il marque des points.",
        cost: 8,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .ace ||
        card.rank == .two ||
        card.rank == .three ||
        card.rank == .five ||
        card.rank == .eight) {
      score.multi += 8;
    }
  }
}

class EvenSteven extends JokeroJoker {
  EvenSteven()
    : super(
        id: 'even_steven',
        name: 'Pair-fect',
        rarity: .common,
        description: "Les cartes jouées de valeur paire (10, 8, 6, 4, 2) donnent +4 Multi lorsqu'elles marquent.",
        cost: 4,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .two ||
        card.rank == .four ||
        card.rank == .six ||
        card.rank == .eight ||
        card.rank == .ten) {
      score.multi += 4;
    }
  }
}

class OddTodd extends JokeroJoker {
  OddTodd()
    : super(
        id: 'odd_todd',
        name: 'Impair-méable',
        rarity: .common,
        description: "Les cartes jouées de valeur impaire (As, 9, 7, 5, 3) donnent +31 Jetons lorsqu'elles marquent.",
        cost: 4,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .ace ||
        card.rank == .three ||
        card.rank == .five ||
        card.rank == .seven ||
        card.rank == .nine) {
      score.chips += 31;
    }
  }
}

class Scholar extends JokeroJoker {
  Scholar()
    : super(
        id: 'scholar',
        name: 'Érudit',
        rarity: .common,
        description: "Les As joués donnent +20 Jetons et +4 Multi lorsqu'ils marquent des points.",
        cost: 4,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .ace) {
      score.chips += 20;
      score.multi += 4;
    }
  }
}

class ScaryFace extends JokeroJoker {
  ScaryFace()
    : super(
        id: 'scary_face',
        name: 'Visage effrayant',
        rarity: .common,
        description: "Les cartes Figures jouées donnent +30 Jetons lorsqu'elles marquent des points.",
        cost: 4,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .jack || card.rank == .queen || card.rank == .king) {
      score.chips += 30;
    }
  }
}

class SmileyFace extends JokeroJoker {
  SmileyFace()
    : super(
        id: 'smiley_face',
        name: 'Visage souriant',
        rarity: .common,
        description: "Les cartes Figures jouées donnent +5 Multi lorsqu'elles marquent des points.",
        cost: 4,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .jack || card.rank == .queen || card.rank == .king) {
      score.multi += 5;
    }
  }
}

class WalkieTalkie extends JokeroJoker {
  WalkieTalkie()
    : super(
        id: 'walkie_talkie',
        name: 'Talkie-walkie',
        rarity: .common,
        description: "Chaque 10 ou 4 joué donne +10 Jetons et +4 Multi lorsqu'il marque des points.",
        cost: 4,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .ten || card.rank == .four) {
      score.chips += 10;
      score.multi += 4;
    }
  }
}

class Triboulet extends JokeroJoker {
  Triboulet()
    : super(
        id: 'triboulet',
        name: 'Triboulet',
        rarity: .legendary,
        description: "Les Rois et Reines joués donnent chacun X2 Multi lorsqu'ils marquent des points.",
        cost: 20,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .king || card.rank == .queen) {
      score.multi *= 2;
    }
  }
}

class Photograph extends JokeroJoker {
  bool triggeredThisHand = false;

  Photograph()
    : super(
        id: 'photograph',
        name: 'Photographie',
        rarity: .common,
        description: "La première carte Figure jouée donne X2 Multi lorsqu'elle marque des points.",
        cost: 5,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    triggeredThisHand = false;
  }

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (!triggeredThisHand &&
        (card.rank == .jack || card.rank == .queen || card.rank == .king)) {
      score.multi *= 2;
      triggeredThisHand = true;
    }
  }
}

class WeeJoker extends JokeroJoker {
  int bonusChips = 0;

  WeeJoker()
    : super(
        id: 'wee_joker',
        name: 'P\'tit Joker',
        rarity: .rare,
        description: "",
        cost: 8,
      );

  @override
  String get description =>
      "Ce Joker gagne +8 Jetons lorsqu'un 2 joué marque des points (Actuellement +$bonusChips Jetons).";

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.rank == .two) {
      bonusChips += 8;
    }
  }

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    score.chips += bonusChips;
  }
}

class Hiker extends JokeroJoker {
  Hiker()
    : super(
        id: 'hiker',
        name: 'Randonneur',
        rarity: .uncommon,
        description: "Chaque carte jouée gagne de façon permanente +5 Jetons lorsqu'elle marque des points.",
        cost: 5,
      );

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    score.chips += 5;
  }
}

class MysticSummit extends JokeroJoker {
  MysticSummit()
    : super(
        id: 'mystic_summit',
        name: 'Sommet mystique',
        rarity: .common,
        description: "+15 Multi lorsqu'il reste 0 défausse.",
        cost: 5,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (remainingDiscards == 0) {
      score.multi += 15;
    }
  }
}

class Misprint extends JokeroJoker {
  Misprint()
    : super(
        id: 'misprint',
        name: 'Erreur d\'impression',
        rarity: .common,
        description: "+0 à +23 Multi aléatoirement.",
        cost: 4,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    score.multi += Random().nextInt(24);
  }
}

class HalfJoker extends JokeroJoker {
  int cardsCount = 0;

  HalfJoker()
    : super(
        id: 'half_joker',
        name: 'Demi-Joker',
        rarity: .common,
        description: "+20 Multi si la main jouée contient 3 cartes ou moins.",
        cost: 5,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    cardsCount = 0;
  }

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    cardsCount++;
  }

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (cardsCount <= 3) {
      score.multi += 20;
    }
  }
}

class StencilJoker extends JokeroJoker {
  StencilJoker()
    : super(
        id: 'joker_stencil',
        name: 'Pochoir de Joker',
        rarity: .uncommon,
        description:
            "X1 Multi pour chaque emplacement de Joker vide (Pochoir inclus).",
        cost: 8,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    final stencilCount = allJokers.whereType<StencilJoker>().length;
    final emptySlots = max(0, maxJokers - allJokers.length);
    final multiplier = max(1, emptySlots + stencilCount);
    score.multi *= multiplier;
  }
}

class Swashbuckler extends JokeroJoker {
  Swashbuckler()
    : super(
        id: 'swashbuckler',
        name: 'Bretteur',
        rarity: .common,
        description: "Ajoute la valeur de vente de tous les autres Jokers possédés au Multi.",
        cost: 4,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    int totalSellValue = 0;
    for (int i = 0; i < allJokers.length; i++) {
      if (i != index) {
        totalSellValue += allJokers[i].sellPrice;
      }
    }
    score.multi += totalSellValue;
  }
}

class CeremonialDagger extends JokeroJoker {
  int bonusMulti = 0;

  CeremonialDagger()
    : super(
        id: 'ceremonial_dagger',
        name: 'Dague cérémonielle',
        rarity: .uncommon,
        description: "",
        cost: 6,
      );

  @override
  String get description =>
      "Ajoute le double de la valeur de vente du Joker à sa droite au Multi (Actuellement +$bonusMulti Multi).";

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (index + 1 < allJokers.length) {
      score.multi += allJokers[index + 1].sellPrice * 2;
    }
    score.multi += bonusMulti;
  }
}

class Blueprint extends JokeroJoker {
  Blueprint()
    : super(
        id: 'blueprint',
        name: 'Plan',
        rarity: .rare,
        description:
            "Copie la capacité du Joker situé immédiatement à sa droite.",
        cost: 10,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (index + 1 < allJokers.length) {
      final target = allJokers[index + 1];
      if (target is! Blueprint && target is! Brainstorm) {
        target.onEvaluateJoker(
          score,
          allJokers,
          index + 1,
          remainingHands,
          remainingDiscards,
        );
      }
    }
  }
}

class Brainstorm extends JokeroJoker {
  Brainstorm()
    : super(
        id: 'brainstorm',
        name: 'Remue-méninges',
        rarity: .rare,
        description: "Copie la capacité du Joker situé tout à gauche.",
        cost: 10,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (allJokers.isNotEmpty && index != 0) {
      final target = allJokers.first;
      if (target is! Blueprint && target is! Brainstorm) {
        target.onEvaluateJoker(
          score,
          allJokers,
          0,
          remainingHands,
          remainingDiscards,
        );
      }
    }
  }
}

class Cavendish extends JokeroJoker {
  Cavendish()
    : super(
        id: 'cavendish',
        name: 'Cavendish',
        rarity: .common,
        description: "X3 Multi. 1 chance sur 1000 que cette carte soit détruite à la fin de la manche.",
        cost: 4,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    score.multi *= 3;
    int randomInt = Random().nextInt(1000);
    if (randomInt == 0) {
      allJokers.removeAt(index);
    }
  }
}

class GrosMichel extends JokeroJoker {
  GrosMichel()
    : super(
        id: 'gros_michel',
        name: 'Gros Michel',
        rarity: .common,
        description:
            "+15 Multi. 1 chance sur 6 d'être détruit à la fin de la manche.",
        cost: 5,
      );

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    score.multi += 15;
  }
}

class Blackboard extends JokeroJoker {
  bool allBlack = true;

  Blackboard()
    : super(
        id: 'blackboard',
        name: 'Tableau noir',
        rarity: .uncommon,
        description: "X3 Multi si toutes les cartes jouées sont de couleur Pique ou Trèfle.",
        cost: 6,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    allBlack = true;
  }

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit != .spade && card.suit != .club) {
      allBlack = false;
    }
  }

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (allBlack) {
      score.multi *= 3;
    }
  }
}

class SeeingDouble extends JokeroJoker {
  bool hasClub = false;
  bool hasOtherSuit = false;

  SeeingDouble()
    : super(
        id: 'seeing_double',
        name: 'Vision double',
        rarity: .uncommon,
        description: "X2 Multi si la main jouée contient une carte Trèfle qui marque et une carte d'une autre couleur qui marque.",
        cost: 6,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    hasClub = false;
    hasOtherSuit = false;
  }

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    if (card.suit == .club) {
      hasClub = true;
    } else {
      hasOtherSuit = true;
    }
  }

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (hasClub && hasOtherSuit) {
      score.multi *= 2;
    }
  }
}

class FlowerPot extends JokeroJoker {
  final Set<Suit> scoredSuits = {};

  FlowerPot()
    : super(
        id: 'flower_pot',
        name: 'Pot de fleurs',
        rarity: .uncommon,
        description: "X3 Multi si la main jouée contient une carte Carreau, Trèfle, Cœur et Pique qui marquent.",
        cost: 6,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    scoredSuits.clear();
  }

  @override
  void onCardScored(JokeroCard card, JokeroScore score) {
    scoredSuits.add(card.suit);
  }

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (scoredSuits.length == 4) {
      score.multi *= 3;
    }
  }
}

class CardSharp extends JokeroJoker {
  final Set<JokeroHandCombinaison> playedThisRound = {};
  JokeroHandCombinaison? currentCombinaison;

  CardSharp()
    : super(
        id: 'card_sharp',
        name: 'Tricheur',
        rarity: .uncommon,
        description: "X3 Multi si la main de poker jouée a déjà été jouée durant cette manche.",
        cost: 6,
      );

  @override
  void onHandPlayed(JokeroHandCombinaison combinaison, JokeroScore score) {
    currentCombinaison = combinaison;
  }

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    if (currentCombinaison != null) {
      if (playedThisRound.contains(currentCombinaison)) {
        score.multi *= 3;
      } else {
        playedThisRound.add(currentCombinaison!);
      }
    }
  }

  @override
  void onRoundEnd(GameViewModel viewmodel) {
    playedThisRound.clear();
  }
}

class Monkey extends JokeroJoker {
  double multi = 1.0;

  Monkey()
    : super(
        id: 'monkey',
        name: 'Le Singe',
        description: "",
        rarity: .legendary,
        cost: 1,
      );

  @override
  String get description =>
      "Augmente de 0.1 le multi à chaque blinde vaincue. Actuellement ${multi.toStringAsFixed(1)}";

  @override
  void onRoundEnd(GameViewModel viewModel) {
    multi += 0.1;
  }

  @override
  void onEvaluateJoker(
    JokeroScore score,
    List<JokeroJoker> allJokers,
    int index,
    int remainingHands,
    int remainingDiscards,
  ) {
    score.multi *= multi;
  }
}
