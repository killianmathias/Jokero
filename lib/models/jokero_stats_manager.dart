import 'package:jokero/models/jokero_hand.dart';
import "package:shared_preferences/shared_preferences.dart";

import 'dart:convert';
import 'dart:math';

class JokeroStats {
  late int bestHand;
  late int cardsPlayed;
  late int cardsDiscarded;
  late int jokerPurchased;
  late int numberOfReroll;
  late int earnedMoney;
  late Map<JokeroPokerHand, int> playedHands;

  JokeroStats() {
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

  JokeroPokerHand? getMostPlayedHand() {
    if (playedHands.values.every((count) => count == 0)) {
      return null;
    }
    return JokeroPokerHand.values.reduce(
      (a, b) => (playedHands[a] ?? 0) >= (playedHands[b] ?? 0) ? a : b,
    );
  }
}

class JokeroStatsManager {
  late JokeroStats stats;

  JokeroStatsManager() {
    initStatsManager();
  }

  void initStatsManager() {
    stats = JokeroStats();
  }

  void setBestHand(int newHand) {
    if (newHand > stats.bestHand) {
      stats.bestHand = newHand;
    }
  }

  void incrementPlayedHand(JokeroPokerHand hand) {
    stats.playedHands[hand] = (stats.playedHands[hand] ?? 0) + 1;
  }

  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int globalBestHand = prefs.getInt("bestHand") ?? 0;
    int globalCardsPlayed = prefs.getInt("cardsPlayed") ?? 0;
    int globalCardsDiscarded = prefs.getInt("cardsDiscarded") ?? 0;
    int globalJokerPurchased = prefs.getInt("jokerPurchased") ?? 0;
    int globalNumberOfReroll = prefs.getInt("numberOfReroll") ?? 0;
    int globalEarnedMoney = prefs.getInt("earnedMoney") ?? 0;

    await prefs.setInt('bestHand', max(globalBestHand, stats.bestHand));
    await prefs.setInt('cardsPlayed', globalCardsPlayed + stats.cardsPlayed);
    await prefs.setInt(
      'cardsDiscarded',
      globalCardsDiscarded + stats.cardsDiscarded,
    );
    await prefs.setInt(
      'jokerPurchased',
      globalJokerPurchased + stats.jokerPurchased,
    );
    await prefs.setInt(
      'numberOfReroll',
      globalNumberOfReroll + stats.numberOfReroll,
    );
    await prefs.setInt('earnedMoney', globalEarnedMoney + stats.earnedMoney);

    Map<JokeroPokerHand, int> globalPlayedHands = _decodePlayedHands(
      prefs.getString('playedHands'),
    );

    for (var hand in JokeroPokerHand.values) {
      int currentSessionCount = stats.playedHands[hand] ?? 0;
      int savedCount = globalPlayedHands[hand] ?? 0;
      globalPlayedHands[hand] = savedCount + currentSessionCount;
    }

    Map<String, int> jsonMap = globalPlayedHands.map(
      (key, value) => MapEntry(key.name, value),
    );

    await prefs.setString('playedHands', jsonEncode(jsonMap));
  }

  Future<JokeroStats> getAllTimeStats() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    JokeroStats globalStats = JokeroStats();

    globalStats.bestHand = prefs.getInt("bestHand") ?? 0;
    globalStats.cardsPlayed = prefs.getInt("cardsPlayed") ?? 0;
    globalStats.cardsDiscarded = prefs.getInt("cardsDiscarded") ?? 0;
    globalStats.jokerPurchased = prefs.getInt("jokerPurchased") ?? 0;
    globalStats.numberOfReroll = prefs.getInt("numberOfReroll") ?? 0;
    globalStats.earnedMoney = prefs.getInt("earnedMoney") ?? 0;

    globalStats.playedHands = _decodePlayedHands(
      prefs.getString('playedHands'),
    );

    return globalStats;
  }

  Map<JokeroPokerHand, int> _decodePlayedHands(String? jsonString) {
    Map<JokeroPokerHand, int> result = {
      for (var hand in JokeroPokerHand.values) hand: 0,
    };

    if (jsonString == null || jsonString.isEmpty) {
      return result;
    }

    Map<String, dynamic> decodedMap = jsonDecode(jsonString);

    for (var hand in JokeroPokerHand.values) {
      if (decodedMap.containsKey(hand.name)) {
        result[hand] = decodedMap[hand.name] as int;
      }
    }

    return result;
  }
}
