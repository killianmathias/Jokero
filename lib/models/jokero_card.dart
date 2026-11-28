import "package:jokero/constants/jokero_constants.dart";

enum Rank {
  ace(11, "ace", 14),
  two(2, "2", 2),
  three(3, "3", 3),
  four(4, "4", 4),
  five(5, "5", 5),
  six(6, "6", 6),
  seven(7, "7", 7),
  eight(8, "8", 8),
  nine(9, "9", 9),
  ten(10, "10", 10),
  jack(10, "jack", 11),
  queen(10, "queen", 12),
  king(10, "king", 13);

  const Rank(this.value, this.rawValue, this.power);
  final int value;
  final String rawValue;
  final int power;
}

enum Suit {
  spade("spade", "Pique"),
  club("club", "Trèfle"),
  diamond("diamond", "Carreau"),
  heart("heart", "Coeur");

  const Suit(this.rawValue, this.name);
  final String rawValue;
  final String name;
}

class JokeroCard {
  final Rank rank;
  final Suit suit;

  JokeroCard(this.rank, this.suit);

  String get imageAsset =>
      "$cardImagePathPrefix${rank.rawValue}_of_${suit.rawValue}.png";

  @override
  bool operator ==(Object other) {
    return (other is JokeroCard) && rank == other.rank && suit == other.suit;
  }

  @override
  int get hashCode => Object.hash(rank, suit);

  @override
  String toString() => '${rank.rawValue} of ${suit.rawValue}';

  bool isSameRank(JokeroCard other) {
    return rank == other.rank;
  }
}
