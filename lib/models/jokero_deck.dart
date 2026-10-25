import "jokero_card.dart";

import "dart:math";

class JokeroDeck {
  List<JokeroCard> deck;

  JokeroDeck(this.deck);

  static JokeroDeck createStartingDeck() {
    List<JokeroCard> deck = [];

    for (var rank in Rank.values) {
      for (var suit in Suit.values) {
        deck.add(JokeroCard(rank, suit));
      }
    }

    return JokeroDeck(deck);
  }

  void addCard(JokeroCard card) {
    deck.add(card);
  }

  void removeCard(JokeroCard card) {
    deck.remove(card);
  }

  void shuffle() {
    deck.shuffle();
  }

  List<JokeroCard> draw(int numberOfCardsToDraw) {
    var numberOfCardsAbleToDraw = min(numberOfCardsToDraw, deck.length);
    var cardsToDraw = deck.sublist(0, numberOfCardsAbleToDraw);

    deck.removeRange(0, numberOfCardsAbleToDraw);
    return cardsToDraw;
  }
}
