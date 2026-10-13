import "JokeroCard.dart";

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

  void shuffle() {
    deck.shuffle(null);
  }
}
