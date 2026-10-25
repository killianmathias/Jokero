import 'package:flutter/foundation.dart';
import 'package:jokero/models/jokero_ante.dart';
import 'package:jokero/models/jokero_deck.dart';
import 'package:jokero/models/jokero_hand.dart';
import "package:jokero/models/jokero_blind.dart";
import "package:jokero/constants/jokero_constants.dart";

class GameViewModel extends ChangeNotifier {
  JokeroDeck deck = JokeroDeck.createStartingDeck();
  JokeroHand hand = JokeroHand();

  int score = 0;
  int money = startingMoney;

  int currentAnteLevel = 1;
  int currentBlindIndex = 0;

  int numberOfPlays = 4;
  int numberOfDiscards = 4;

  late JokeroAnte currentAnte;

  GameViewModel() {
    _initGame();
  }

  void _initGame() {
    currentAnteLevel = 1;
    currentAnte = JokeroAnte(currentAnteLevel);
    currentBlindIndex = 0;
    score = 0;
    hand.addCards(deck.draw(numberOfCardsInHand));
  }

  JokeroBlind get currentBlind => currentAnte.blinds[currentBlindIndex];
}
