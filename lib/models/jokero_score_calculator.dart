import 'package:jokero/models/jokero_hand.dart';
import 'package:jokero/models/jokero_hand_evaluator.dart';
import 'package:jokero/models/jokero_joker.dart';
import 'package:jokero/models/jokero_score.dart';

class JokeroScoreCalculator {
  int totalScore(JokeroHandCombinaison combinaison, List<JokeroJoker> jokers) {
    final score = JokeroScore(
      chips: combinaison.pokerHand.chips,
      multi: combinaison.pokerHand.multi,
    );

    for (var card in combinaison.scoringCards) {
      score.addChips(card.rank.value);

      for (var joker in jokers) {
        joker.onCardScored(card, score);
      }
    }

    for (var joker in jokers) {
      joker.onHandPlayed(combinaison, score);
    }

    for (int i = 0; i < jokers.length; i++) {
      jokers[i].onEvaluateJoker(score, jokers, i);
    }

    return score.totalScore;
  }
}
