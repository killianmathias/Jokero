import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:jokero/models/jokero_ante.dart';
import 'package:jokero/models/jokero_card.dart';
import 'package:jokero/models/jokero_deck.dart';
import 'package:jokero/models/jokero_game_state.dart';
import 'package:jokero/models/jokero_hand.dart';
import "package:jokero/models/jokero_blind.dart";
import "package:jokero/constants/jokero_constants.dart";
import 'package:jokero/models/jokero_hand_evaluator.dart';
import 'package:jokero/models/jokero_joker.dart';
import 'package:jokero/models/jokero_score_calculator.dart';
import 'package:jokero/models/jokero_shop.dart';
import 'package:jokero/models/jokero_stats_manager.dart';
import 'package:jokero/services/sound_service.dart';

class GameViewModel extends ChangeNotifier {
  JokeroDeck deck = JokeroDeck.createStartingDeck();
  JokeroHand hand = JokeroHand();
  JokeroHandEvaluator evaluator = JokeroHandEvaluator();
  JokeroScoreCalculator calculator = JokeroScoreCalculator();
  JokeroShop shop = JokeroShop();
  JokeroStatsManager statsManager = JokeroStatsManager();

  JokeroGameState gameState = .blindSelection;

  List<JokeroJoker> jokers = [];

  int score = 0;
  int money = startingMoney;

  int currentAnteLevel = 1;
  int currentBlindIndex = 0;

  int remainingHands = initialRemainingHands;
  int remainingDiscards = initialRemainingDiscards;

  late JokeroAnte currentAnte;

  GameViewModel() {
    _initGame();
  }

  void _initGame() {
    gameState = .menu;
    currentAnteLevel = 1;
    currentAnte = JokeroAnte(currentAnteLevel);
    currentBlindIndex = 0;
    score = 0;
    hand.addCards(deck.draw(numberOfCardsInHand));
  }

  JokeroBlind get currentBlind => currentAnte.blinds[currentBlindIndex];
  bool get canPlayHand {
    if (hand.selectedCards.isEmpty ||
        hand.selectedCards.length > 5 ||
        remainingHands <= 0) {
      return false;
    }
    if (currentBlind is JokeroBossBlind) {
      return (currentBlind as JokeroBossBlind).canPlayHand(
        currentCombinaison,
        hand.selectedCards,
        this,
      );
    }
    return true;
  }

  bool get canDiscard =>
      hand.selectedCards.isNotEmpty &&
      hand.selectedCards.length <= 5 &&
      remainingDiscards > 0;

  List<JokeroJoker> get availableJokers =>
      allJokers.where((joker) => !jokers.contains(joker)).toList();

  JokeroHandCombinaison get currentCombinaison =>
      evaluator.evaluate(hand.selectedCards);

  int get currentPreviewScore => calculator.totalScore(
    currentCombinaison,
    jokers,
    remainingHands,
    remainingDiscards,
    currentBlind,
  );

  bool canBuyJoker(JokeroJoker joker) {
    return money >= joker.cost && jokers.length < maxJokers;
  }

  bool canRerollShop() {
    return money >= shop.rerollCost;
  }

  void toggleCard(JokeroCard card) {
    hand.selectCard(card);
    notifyListeners();
  }

  void playHand() {
    SoundService.pressButton();
    JokeroHandCombinaison combinaison = evaluator.evaluate(hand.selectedCards);
    if (currentBlind is JokeroBossBlind) {
      (currentBlind as JokeroBossBlind).onHandPlayed(combinaison, this);
    }
    var handScore = calculator.totalScore(
      combinaison,
      jokers,
      remainingHands,
      remainingDiscards,
      currentBlind,
    );
    statsManager.stats.cardsPlayed += hand.selectedCards.length;
    hand.discardCards();
    score += handScore;
    remainingHands--;

    //stats
    statsManager.setBestHand(handScore);
    statsManager.stats.playedHands[combinaison.pokerHand] =
        (statsManager.stats.playedHands[combinaison.pokerHand] ?? 0) + 1;

    if (score >= currentBlind.scoreToReach) {
      money += currentBlind.reward;
      SoundService.earnMoney();

      shop.restock(availableJokers);

      gameState = JokeroGameState.shop;
      notifyListeners();
      return;
    }

    if (remainingHands == 0) {
      gameState = .defeat;
      statsManager.saveUserData();
      notifyListeners();
      return;
    }

    hand.addCards(deck.draw(hand.numberOfCardsToDraw));
    notifyListeners();
  }

  void discardCards() {
    if (remainingDiscards == 0 || hand.selectedCards.isEmpty) return;
    SoundService.pressCancel();
    statsManager.stats.cardsDiscarded += hand.selectedCards.length;
    hand.discardCards();
    hand.addCards(deck.draw(hand.numberOfCardsToDraw));
    remainingDiscards--;

    notifyListeners();
  }

  void winGame() {
    SoundService.win();
    gameState = .win;
    statsManager.saveUserData();
    notifyListeners();
  }

  void startNextRound() {
    for (var joker in jokers) {
      joker.onRoundEnd(this);
    }
    if (currentBlindIndex == 2) {
      currentAnteLevel += 1;
      if (currentAnteLevel >= 8) {
        winGame();
        return;
      }
      currentAnte = JokeroAnte(currentAnteLevel);
      currentBlindIndex = 0;
    } else {
      currentBlindIndex += 1;
    }

    score = 0;
    remainingHands = initialRemainingHands;
    remainingDiscards = initialRemainingDiscards;

    deck.addCards(hand.alreadyPlayedCards);
    deck.addCards(hand.hand);
    hand.hand.clear();
    hand.alreadyPlayedCards.clear();
    deck.shuffle();
    hand.addCards(deck.draw(numberOfCardsInHand));
  }

  void choseBlind() {
    SoundService.pressButton();
    if (currentBlind is JokeroBossBlind) {
      (currentBlind as JokeroBossBlind).onRoundStart(this);
    }
    gameState = .round;
    notifyListeners();
  }

  void buyJoker(JokeroJoker joker) {
    if (!canBuyJoker(joker)) return;
    SoundService.pressButton();

    money -= joker.cost;
    jokers.add(joker);
    shop.removeItem(joker);
    statsManager.stats.jokerPurchased += 1;
    notifyListeners();
  }

  void sellJoker(JokeroJoker joker) {
    if (!jokers.contains(joker)) return;
    SoundService.pressButton();

    money += joker.sellPrice;
    SoundService.earnMoney();
    jokers.remove(joker);

    notifyListeners();
  }

  void reorderJokers(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final JokeroJoker item = jokers.removeAt(oldIndex);
    jokers.insert(newIndex, item);
    notifyListeners();
  }

  void rerollShop() {
    if (!canRerollShop()) return;
    SoundService.pressButton();

    money -= shop.rerollCost;
    shop.restock(availableJokers);
    statsManager.stats.numberOfReroll += 1;
    notifyListeners();
  }

  void leaveShop() {
    SoundService.pressButton();
    startNextRound();

    gameState = .blindSelection;

    notifyListeners();
  }

  void resetGame() {
    statsManager = JokeroStatsManager();
    money = startingMoney;
    jokers.clear();
    hand.selectedCards.clear();
    hand.alreadyPlayedCards.clear();
    currentAnteLevel = 1;
    currentAnte = JokeroAnte(currentAnteLevel);
    currentBlindIndex = 0;
    score = 0;
    remainingDiscards = initialRemainingDiscards;
    remainingHands = initialRemainingHands;
    deck = JokeroDeck.createStartingDeck();
    hand.hand.clear();
    hand.addCards(deck.draw(numberOfCardsInHand));
    notifyListeners();
  }

  void goToMenu() {
    SoundService.pressButton();
    gameState = .menu;
    resetGame();
  }

  void startGame() {
    SoundService.pressButton();
    gameState = .blindSelection;
    resetGame();
    notifyListeners();
  }

  void selectCard(JokeroCard card) {
    hand.selectCard(card);
    notifyListeners();
  }
}
