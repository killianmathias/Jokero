import 'package:jokero/models/jokero_hand_evaluator.dart';
import 'package:jokero/models/jokero_joker.dart';
import 'package:jokero/models/jokero_score.dart';
import "package:jokero/models/jokero_blind.dart";

class JokeroScoreCalculator {
  int totalScore(
    JokeroHandCombinaison combinaison,
    List<JokeroJoker> jokers,
    int remainingHands,
    int remainingDiscards,
    JokeroBlind currentBlind, {
    int? baseChips,
    double? baseMulti,
  }) {
    final score = JokeroScore(
      chips: baseChips ?? combinaison.pokerHand.chips,
      multi: baseMulti ?? combinaison.pokerHand.multi,
    );

    for (var joker in jokers) {
      joker.onHandPlayed(combinaison, score);
    }

    for (var card in combinaison.scoringCards) {
      final isDebuffed =
          currentBlind is JokeroBossBlind && currentBlind.isCardDebuffed(card);

      if (isDebuffed) continue;

      score.addChips(card.rank.value);

      for (var joker in jokers) {
        joker.onCardScored(card, score);
      }
    }

    if (currentBlind is JokeroBossBlind) {
      currentBlind.onEvaluateScore(score);
    }

    for (int i = 0; i < jokers.length; i++) {
      jokers[i].onEvaluateJoker(
        score,
        jokers,
        i,
        remainingHands,
        remainingDiscards,
      );
    }

    return score.totalScore;
  }
}
