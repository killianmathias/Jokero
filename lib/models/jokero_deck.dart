import "jokero_card.dart";

const NUMBER_OF_CARDS_IN_HAND = 7;

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
    deck.shuffle(null);
  }

  List<JokeroCard> draw(int numberOfcardsToDraw) {
    deck.shuffle();

    var cardsToDraw = deck.sublist(0, numberOfcardsToDraw);

    deck.removeRange(0, numberOfcardsToDraw);
    return cardsToDraw;
  }
}
