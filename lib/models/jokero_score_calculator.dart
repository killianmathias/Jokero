import 'package:jokero/models/jokero_hand.dart';
import 'package:jokero/models/jokero_hand_evaluator.dart';
import 'package:jokero/models/jokero_joker.dart';

class JokeroScoreCalculator {
  JokeroHandCombinaison combinaison;
  List<JokeroJoker> jokeros;

  JokeroScoreCalculator(this.combinaison, this.jokeros);

  int totalScore() {
    int multiplier = combinaison.pokerHand.multi;
    int chips = combinaison.pokerHand.tokens;

    for (var card in combinaison.scoringCards) {
      chips += card.rank.power;
    }

    return chips * multiplier;
  }
}
