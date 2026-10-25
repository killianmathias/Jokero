import 'package:jokero/models/jokero_card.dart';
import 'package:jokero/models/jokero_hand.dart';

class JokeroHandCombinaison {
  final JokeroPokerHand pokerHand;
  final List<JokeroCard> scoringCards;

  const JokeroHandCombinaison(this.pokerHand, this.scoringCards);
}

class JokeroHandEvaluator {
  const JokeroHandEvaluator();

  JokeroHandCombinaison evaluate(List<JokeroCard> selectedCards) {
    if (selectedCards.isEmpty) {
      return const JokeroHandCombinaison(JokeroPokerHand.highCard, []);
    }

    final sortedCards = List<JokeroCard>.from(selectedCards)
      ..sort((a, b) => b.rank.power.compareTo(a.rank.power));

    final rankGroups = groupCardsByRank(sortedCards);

    if (isRoyalFlush(sortedCards)) {
      return JokeroHandCombinaison(JokeroPokerHand.royalFlush, sortedCards);
    }

    if (isStraightFlush(sortedCards)) {
      return JokeroHandCombinaison(JokeroPokerHand.straightFlush, sortedCards);
    }

    if (isFourOfAKind(rankGroups)) {
      final scoringCards = rankGroups.values.firstWhere(
        (cards) => cards.length == 4,
      );
      return JokeroHandCombinaison(JokeroPokerHand.fourOfAKind, scoringCards);
    }

    if (isFullHouse(rankGroups)) {
      return JokeroHandCombinaison(JokeroPokerHand.fullHouse, sortedCards);
    }

    if (isFlush(sortedCards)) {
      return JokeroHandCombinaison(JokeroPokerHand.flush, sortedCards);
    }

    if (isStraight(sortedCards)) {
      return JokeroHandCombinaison(JokeroPokerHand.straight, sortedCards);
    }

    if (isThreeOfAKind(rankGroups)) {
      final scoringCards = rankGroups.values.firstWhere(
        (cards) => cards.length == 3,
      );
      return JokeroHandCombinaison(JokeroPokerHand.threeOfAKind, scoringCards);
    }

    if (isTwoPair(rankGroups)) {
      final scoringCards = rankGroups.values
          .where((cards) => cards.length == 2)
          .expand((cards) => cards)
          .toList();
      return JokeroHandCombinaison(JokeroPokerHand.twoPair, scoringCards);
    }

    if (isPair(rankGroups)) {
      final scoringCards = rankGroups.values.firstWhere(
        (cards) => cards.length == 2,
      );
      return JokeroHandCombinaison(JokeroPokerHand.pair, scoringCards);
    }

    return JokeroHandCombinaison(JokeroPokerHand.highCard, [sortedCards.first]);
  }

  Map<Rank, List<JokeroCard>> groupCardsByRank(List<JokeroCard> cards) {
    final Map<Rank, List<JokeroCard>> map = {};
    for (final card in cards) {
      (map[card.rank] ??= []).add(card);
    }
    return map;
  }

  bool isRoyalFlush(List<JokeroCard> sortedCards) {
    return isStraightFlush(sortedCards) &&
        sortedCards.first.rank == Rank.ace &&
        sortedCards[1].rank == Rank.king;
  }

  bool isStraightFlush(List<JokeroCard> sortedCards) {
    return isStraight(sortedCards) && isFlush(sortedCards);
  }

  bool isFourOfAKind(Map<Rank, List<JokeroCard>> rankGroups) {
    return rankGroups.values.any((cards) => cards.length == 4);
  }

  bool isFullHouse(Map<Rank, List<JokeroCard>> rankGroups) {
    return rankGroups.values.any((cards) => cards.length == 3) &&
        rankGroups.values.any((cards) => cards.length == 2);
  }

  bool isFlush(List<JokeroCard> cards) {
    if (cards.length != 5) return false;
    final firstSuit = cards.first.suit;
    return cards.every((card) => card.suit == firstSuit);
  }

  bool isStraight(List<JokeroCard> sortedCards) {
    if (sortedCards.length != 5) return false;

    bool isStandardStraight = true;
    for (int i = 1; i < sortedCards.length; i++) {
      if (sortedCards[i].rank.power != sortedCards[i - 1].rank.power - 1) {
        isStandardStraight = false;
        break;
      }
    }
    if (isStandardStraight) return true;

    if (sortedCards[0].rank == Rank.ace &&
        sortedCards[1].rank == Rank.five &&
        sortedCards[2].rank == Rank.four &&
        sortedCards[3].rank == Rank.three &&
        sortedCards[4].rank == Rank.two) {
      return true;
    }

    return false;
  }

  bool isThreeOfAKind(Map<Rank, List<JokeroCard>> rankGroups) {
    return rankGroups.values.any((cards) => cards.length == 3);
  }

  bool isTwoPair(Map<Rank, List<JokeroCard>> rankGroups) {
    return rankGroups.values.where((cards) => cards.length == 2).length == 2;
  }

  bool isPair(Map<Rank, List<JokeroCard>> rankGroups) {
    return rankGroups.values.any((cards) => cards.length == 2);
  }
}
