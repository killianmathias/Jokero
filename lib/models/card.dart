import "package:jokero/constants/card_constants.dart";

enum Suit {
  spade("spade"),
  club("club"),
  diamond("diamond"),
  heart("heart");

  const Suit(this.rawValue);
  final String rawValue;
}

abstract class Card {
  final int value;
  final Suit suit;
  final String image_asset;

  Card(this.value, this.suit, this.image_asset);
}

abstract class FaceCard extends Card {
  FaceCard(Suit suit, String image_asset) : super(10, suit, image_asset);
}

class King extends FaceCard {
  King(Suit suit) : super(suit, pathForFaceCard(suit, "king"));
}

class Queen extends FaceCard {
  Queen(Suit suit) : super(suit, pathForFaceCard(suit, "queen"));
}

class Jack extends FaceCard {
  Jack(Suit suit) : super(suit, pathForFaceCard(suit, "jack"));
}

class BaseCard extends Card {
  BaseCard(int value, Suit suit) : super(value, suit, pathForCard(suit, value));
}

String pathForCard(Suit suit, int value) {
  return "$IMAGE_ASSET_PREFIX${suit.rawValue}_${value.toString()}.png";
}

String pathForFaceCard(Suit suit, String name) {
  return "$IMAGE_ASSET_PREFIX${suit.rawValue}_$name.png";
}
