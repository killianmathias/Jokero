import "package:jokero/constants/jokero_constants.dart";

enum Rank {
  ace(11, "1"),
  two(2, "2"),
  three(3, "3"),
  four(4, "4"),
  five(5, "5"),
  six(6, "6"),
  seven(7, "7"),
  eight(8, "8"),
  nine(9, "9"),
  ten(10, "10"),
  jack(10, "jack"),
  queen(10, "queen"),
  king(10, "king");

  const Rank(this.value, this.rawValue);
  final int value;
  final String rawValue;
}

enum Suit {
  spade("spade"),
  club("club"),
  diamond("diamond"),
  heart("heart");

  const Suit(this.rawValue);
  final String rawValue;
}

class JokeroCard {
  final Rank rank;
  final Suit suit;

  JokeroCard(this.rank, this.suit);

  String get imageAsset =>
      "$cardImagePathPrefix${suit.rawValue}_${rank.rawValue}.png";
}
