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

class GameViewModel extends ChangeNotifier {
  JokeroDeck deck = JokeroDeck.createStartingDeck();
  JokeroHand hand = JokeroHand();
  JokeroHandEvaluator evaluator = JokeroHandEvaluator();
  JokeroScoreCalculator calculator = JokeroScoreCalculator();
  JokeroShop shop = JokeroShop();

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
    gameState = .blindSelection;
    currentAnteLevel = 1;
    currentAnte = JokeroAnte(currentAnteLevel);
    currentBlindIndex = 0;
    score = 0;
    hand.addCards(deck.draw(numberOfCardsInHand));
  }

  JokeroBlind get currentBlind => currentAnte.blinds[currentBlindIndex];
  bool get canPlayHand =>
      hand.selectedCards.isNotEmpty &&
      hand.selectedCards.length <= 5 &&
      remainingHands > 0;

  bool get canDiscard =>
      hand.selectedCards.isNotEmpty &&
      hand.selectedCards.length <= 5 &&
      remainingDiscards > 0;

  List<JokeroJoker> get availableJokers =>
      allJokers.where((joker) => !jokers.contains(joker)).toList();

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
    JokeroHandCombinaison combinaison = evaluator.evaluate(hand.selectedCards);
    var handScore = calculator.totalScore(combinaison, jokers);
    hand.discardCards();
    score += handScore;
    remainingHands--;

    if (score >= currentBlind.scoreToReach) {
      money += currentBlind.reward;

      shop.restock(availableJokers);

      gameState = JokeroGameState.shop;
      notifyListeners();
      return;
    }

    if (remainingHands == 0) {
      gameState = .defeat;
      return;
    }

    hand.addCards(deck.draw(hand.numberOfCardsToDraw));
  }

  void discardCards() {
    if (remainingDiscards == 0 || hand.selectedCards.isEmpty) return;
    hand.discardCards();
    hand.addCards(deck.draw(hand.numberOfCardsToDraw));
    remainingDiscards--;
  }

  void startNextRound() {
    if (currentBlindIndex == 2) {
      currentAnteLevel += 1;
      currentAnte = JokeroAnte(currentAnteLevel);
    } else {
      currentBlindIndex += 1;
    }

    score = 0;
    remainingHands = initialRemainingHands;
    remainingDiscards = initialRemainingHands;

    deck.addCards(hand.alreadyPlayedCards);
    deck.addCards(hand.hand);
    hand.hand.clear();
    hand.alreadyPlayedCards.clear();
    deck.shuffle();
  }

  void choseBlind() {
    gameState = .round;
  }

  void buyJoker(JokeroJoker joker) {
    if (!canBuyJoker(joker)) return;

    money -= joker.cost;
    jokers.add(joker);
    shop.removeItem(joker);

    notifyListeners();
  }

  void sellJoker(JokeroJoker joker) {
    if (!jokers.contains(joker)) return;

    money += joker.sellPrice;
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

    money -= shop.rerollCost;
    shop.restock(availableJokers);
    notifyListeners();
  }

  void leaveShop() {
    startNextRound();

    gameState = .blindSelection;

    notifyListeners();
  }
}
