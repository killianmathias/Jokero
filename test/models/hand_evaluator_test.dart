import 'package:flutter_test/flutter_test.dart';
import 'package:jokero/models/jokero_card.dart';
import 'package:jokero/models/jokero_hand.dart';
import 'package:jokero/models/jokero_hand_evaluator.dart';

void main() {
  group('Tests of JokeroHandEvaluator', () {
    const evaluator = JokeroHandEvaluator();

    test('Carte Haute (High Card)', () {
      final kingOfClub = JokeroCard(Rank.king, Suit.club);
      final tenOfSpade = JokeroCard(Rank.ten, Suit.spade);
      final threeOfDiamond = JokeroCard(Rank.three, Suit.diamond);
      final fourOfHeart = JokeroCard(Rank.four, Suit.heart);

      final result = evaluator.evaluate([
        kingOfClub,
        tenOfSpade,
        threeOfDiamond,
        fourOfHeart,
      ]);

      expect(result.pokerHand, JokeroPokerHand.highCard);
      expect(result.scoringCards, [kingOfClub]);
    });

    test('Paire (Pair) - seule la paire marque des jetons', () {
      final kingOfClub = JokeroCard(Rank.king, Suit.club);
      final kingOfSpade = JokeroCard(Rank.king, Suit.spade);
      final threeOfDiamond = JokeroCard(Rank.three, Suit.diamond);
      final fourOfHeart = JokeroCard(Rank.four, Suit.heart);
      final twoOfSpade = JokeroCard(Rank.two, Suit.spade);

      // Joué avec 5 cartes (1 paire + 3 kickeurs)
      final result = evaluator.evaluate([
        threeOfDiamond,
        kingOfClub,
        fourOfHeart,
        kingOfSpade,
        twoOfSpade,
      ]);

      expect(result.pokerHand, JokeroPokerHand.pair);
      expect(result.scoringCards.length, 2);
      expect(result.scoringCards, containsAll([kingOfClub, kingOfSpade]));
    });

    test(
      'Double Paire (Two Pair) - seules les 4 cartes des paires marquent',
      () {
        final kingOfClub = JokeroCard(Rank.king, Suit.club);
        final kingOfSpade = JokeroCard(Rank.king, Suit.spade);
        final fourOfHeart = JokeroCard(Rank.four, Suit.heart);
        final fourOfSpade = JokeroCard(Rank.four, Suit.spade);
        final twoOfDiamond = JokeroCard(Rank.two, Suit.diamond);

        final result = evaluator.evaluate([
          kingOfClub,
          kingOfSpade,
          fourOfHeart,
          fourOfSpade,
          twoOfDiamond,
        ]);

        expect(result.pokerHand, JokeroPokerHand.twoPair);
        expect(result.scoringCards.length, 4);
        expect(
          result.scoringCards,
          containsAll([kingOfClub, kingOfSpade, fourOfHeart, fourOfSpade]),
        );
        expect(result.scoringCards.contains(twoOfDiamond), isFalse);
      },
    );

    test(
      'Brelan (Three of a Kind) - seules les 3 cartes identiques marquent',
      () {
        final kingOfClub = JokeroCard(Rank.king, Suit.club);
        final kingOfSpade = JokeroCard(Rank.king, Suit.spade);
        final kingOfDiamond = JokeroCard(Rank.king, Suit.diamond);
        final fourOfHeart = JokeroCard(Rank.four, Suit.heart);
        final twoOfSpade = JokeroCard(Rank.two, Suit.spade);

        final result = evaluator.evaluate([
          kingOfClub,
          fourOfHeart,
          kingOfSpade,
          twoOfSpade,
          kingOfDiamond,
        ]);

        expect(result.pokerHand, JokeroPokerHand.threeOfAKind);
        expect(result.scoringCards.length, 3);
        expect(
          result.scoringCards,
          containsAll([kingOfClub, kingOfSpade, kingOfDiamond]),
        );
      },
    );

    test('Suite standard (Straight)', () {
      final nineOfHeart = JokeroCard(Rank.nine, Suit.heart);
      final eightOfSpade = JokeroCard(Rank.eight, Suit.spade);
      final sevenOfClub = JokeroCard(Rank.seven, Suit.club);
      final sixOfDiamond = JokeroCard(Rank.six, Suit.diamond);
      final fiveOfHeart = JokeroCard(Rank.five, Suit.heart);

      final result = evaluator.evaluate([
        sevenOfClub,
        nineOfHeart,
        fiveOfHeart,
        eightOfSpade,
        sixOfDiamond,
      ]);

      expect(result.pokerHand, JokeroPokerHand.straight);
      expect(result.scoringCards.length, 5);
    });

    test('Suite basse avec As (Wheel: A-5-4-3-2)', () {
      final aceOfHeart = JokeroCard(Rank.ace, Suit.heart);
      final fiveOfSpade = JokeroCard(Rank.five, Suit.spade);
      final fourOfClub = JokeroCard(Rank.four, Suit.club);
      final threeOfDiamond = JokeroCard(Rank.three, Suit.diamond);
      final twoOfHeart = JokeroCard(Rank.two, Suit.heart);

      final result = evaluator.evaluate([
        aceOfHeart,
        fiveOfSpade,
        fourOfClub,
        threeOfDiamond,
        twoOfHeart,
      ]);

      expect(result.pokerHand, JokeroPokerHand.straight);
      expect(result.scoringCards.length, 5);
    });

    test('Couleur (Flush)', () {
      final aceOfHeart = JokeroCard(Rank.ace, Suit.heart);
      final tenOfHeart = JokeroCard(Rank.ten, Suit.heart);
      final sevenOfHeart = JokeroCard(Rank.seven, Suit.heart);
      final fourOfHeart = JokeroCard(Rank.four, Suit.heart);
      final twoOfHeart = JokeroCard(Rank.two, Suit.heart);

      final result = evaluator.evaluate([
        aceOfHeart,
        tenOfHeart,
        sevenOfHeart,
        fourOfHeart,
        twoOfHeart,
      ]);

      expect(result.pokerHand, JokeroPokerHand.flush);
      expect(result.scoringCards.length, 5);
    });

    test('Main Pleine (Full House)', () {
      final queenOfClub = JokeroCard(Rank.queen, Suit.club);
      final queenOfDiamond = JokeroCard(Rank.queen, Suit.diamond);
      final queenOfHeart = JokeroCard(Rank.queen, Suit.heart);
      final threeOfSpade = JokeroCard(Rank.three, Suit.spade);
      final threeOfClub = JokeroCard(Rank.three, Suit.club);

      final result = evaluator.evaluate([
        queenOfClub,
        threeOfSpade,
        queenOfDiamond,
        threeOfClub,
        queenOfHeart,
      ]);

      expect(result.pokerHand, JokeroPokerHand.fullHouse);
      expect(result.scoringCards.length, 5);
    });

    test('Carré (Four of a Kind) - le kickeur ne marque pas', () {
      final jackOfClub = JokeroCard(Rank.jack, Suit.club);
      final jackOfSpade = JokeroCard(Rank.jack, Suit.spade);
      final jackOfDiamond = JokeroCard(Rank.jack, Suit.diamond);
      final jackOfHeart = JokeroCard(Rank.jack, Suit.heart);
      final aceOfSpade = JokeroCard(Rank.ace, Suit.spade);

      final result = evaluator.evaluate([
        jackOfClub,
        jackOfSpade,
        aceOfSpade,
        jackOfDiamond,
        jackOfHeart,
      ]);

      expect(result.pokerHand, JokeroPokerHand.fourOfAKind);
      expect(result.scoringCards.length, 4);
      expect(
        result.scoringCards,
        containsAll([jackOfClub, jackOfSpade, jackOfDiamond, jackOfHeart]),
      );
      expect(result.scoringCards.contains(aceOfSpade), isFalse);
    });

    test('Quinte Flush (Straight Flush)', () {
      final nineOfClub = JokeroCard(Rank.nine, Suit.club);
      final eightOfClub = JokeroCard(Rank.eight, Suit.club);
      final sevenOfClub = JokeroCard(Rank.seven, Suit.club);
      final sixOfClub = JokeroCard(Rank.six, Suit.club);
      final fiveOfClub = JokeroCard(Rank.five, Suit.club);

      final result = evaluator.evaluate([
        nineOfClub,
        eightOfClub,
        sevenOfClub,
        sixOfClub,
        fiveOfClub,
      ]);

      expect(result.pokerHand, JokeroPokerHand.straightFlush);
      expect(result.scoringCards.length, 5);
    });

    test('Quinte Flush Royale (Royal Flush)', () {
      final aceOfSpade = JokeroCard(Rank.ace, Suit.spade);
      final kingOfSpade = JokeroCard(Rank.king, Suit.spade);
      final queenOfSpade = JokeroCard(Rank.queen, Suit.spade);
      final jackOfSpade = JokeroCard(Rank.jack, Suit.spade);
      final tenOfSpade = JokeroCard(Rank.ten, Suit.spade);

      final result = evaluator.evaluate([
        queenOfSpade,
        tenOfSpade,
        aceOfSpade,
        jackOfSpade,
        kingOfSpade,
      ]);

      expect(result.pokerHand, JokeroPokerHand.royalFlush);
      expect(result.scoringCards.length, 5);
    });
  });
}
