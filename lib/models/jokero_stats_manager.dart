import 'package:jokero/models/jokero_hand.dart';
import "package:shared_preferences/shared_preferences.dart";

class JokeroStatsManager {
  late int bestHand;
  late int cardsPlayed;
  late int cardsDiscarded;
  late int jokerPurchased;
  late int numberOfReroll;
  late int earnedMoney;
  late Map<JokeroPokerHand, int> playedHands;

  JokeroStatsManager() {
    initStatsManager();
  }

  void initStatsManager() {
    bestHand = 0;
    cardsPlayed = 0;
    cardsDiscarded = 0;
    jokerPurchased = 0;
    numberOfReroll = 0;
    earnedMoney = 0;
    playedHands = {};

    for (var hand in JokeroPokerHand.values) {
      playedHands[hand] = 0;
    }
  }

  void setBestHand(int newHand) {
    if (newHand > bestHand) {
      bestHand = newHand;
    }
  }

  JokeroPokerHand getMostPlayedHand() {
    return JokeroPokerHand.values.reduce(
      (a, b) => (playedHands[a] ?? 0) >= (playedHands[b] ?? 0) ? a : b,
    );
  }

  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int globalBestHand = prefs.getInt("bestHand") ?? 0;
    int globalCardsPlayed = prefs.getInt("cardsPlayed") ?? 0;
    int globalCardsDiscarded = prefs.getInt("cardsDiscarded") ?? 0;
    int globalJokerPurchased = prefs.getInt("jokerPurchased") ?? 0;
    int globalNumberOfReroll = prefs.getInt("numberOfReroll") ?? 0;
    int globalEarnedMoney = prefs.getInt("earnedMoney") ?? 0;

    await prefs.setInt('bestHand', globalBestHand += bestHand);
    await prefs.setInt('cardsPlayed', globalCardsPlayed += cardsPlayed);
    await prefs.setInt(
      'cardsDiscarded',
      globalCardsDiscarded += cardsDiscarded,
    );
    await prefs.setInt(
      'jokerPurchased',
      globalJokerPurchased += jokerPurchased,
    );
    await prefs.setInt(
      'numberOfReroll',
      globalNumberOfReroll += numberOfReroll,
    );
    await prefs.setInt('earnedMoney', globalEarnedMoney += earnedMoney);
  }
}
