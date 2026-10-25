import 'package:jokero/models/jokero_hand.dart';
import 'package:jokero/models/jokero_hand_evaluator.dart';
import 'package:jokero/models/jokero_joker.dart';

class JokeroScoreCalculator {
  int totalScore(JokeroHandCombinaison combinaison, List<JokeroJoker> jokers) {
    int multiplier = combinaison.pokerHand.multi;
    int chips = combinaison.pokerHand.tokens;

    for (var card in combinaison.scoringCards) {
      chips += card.rank.value;
    }

    return chips * multiplier;
  }
}
