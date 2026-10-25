import "jokero_card.dart";

enum JokeroPokerHand {
  royalFlush(100, 10, "Quinte Flush Royale"),
  straightFlush(100, 8, "Quinte Flush"),
  fourOfAKind(60, 7, "Carré"),
  fullHouse(40, 4, "Main Pleine"),
  flush(35, 4, "Couleur"),
  straight(30, 4, "Suite"),
  threeOfAKind(30, 3, "Brelan"),
  twoPair(20, 2, "Double Paire"),
  pair(10, 2, "Paire"),
  highCard(5, 1, "Carte Haute");

  const JokeroPokerHand(this.tokens, this.multi, this.rawValue);
  final int tokens;
  final int multi;
  final String rawValue;
}

class JokeroHand {
  List<JokeroCard> hand;
  List<JokeroCard> selectedCards;

  JokeroHand(this.hand, this.selectedCards);

  void addCards(List<JokeroCard> cards) {
    for (var card in cards) {
      hand.add(card);
    }
  }

  void playCards() {
    for (var card in selectedCards) {
      hand.remove(card);
    }
    selectedCards.clear();
  }

  List<JokeroCard> discardCards() {
    List<JokeroCard> discardDeck = [];
    for (var card in selectedCards) {
      discardDeck.add(card);
      hand.remove(card);
    }
    selectedCards.clear();
    return discardDeck;
  }
}
