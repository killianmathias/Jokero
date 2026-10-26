import "package:jokero/models/jokero_joker.dart";

const cardImagePathPrefix = "assets/cards/";
const numberOfCardsInHand = 7;
const startingMoney = 4;
const maximumCardsToPlay = 5;
const initialRemainingDiscards = 3;
const initialRemainingHands = 4;
const maxJokers = 5;

const Map<int, int> baseChips = {
  1: 300,
  2: 800,
  3: 2000,
  4: 5000,
  5: 11000,
  6: 20000,
  7: 35000,
  8: 50000,
};

List<JokeroJoker> allJokers = [
  Joker(),
  JokerAvide(),
  JokerFurieux(),
  JokerGlouton(),
  JokerLubrique(),
];
