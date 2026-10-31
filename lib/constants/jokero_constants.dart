import "package:jokero/models/jokero_joker.dart";
import "package:flutter/material.dart";

const cardImagePathPrefix = "assets/cards/";
const blindImagePathPrefix = "assets/blinds/";
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

Color scoreToReachColor = Color.fromRGBO(254, 71, 75, 1);
Color moneyColor = Color.fromRGBO(248, 180, 73, 1);
Color lightGrey = Color.fromRGBO(47, 58, 60, 1);
Color darkGrey = Color.fromRGBO(29, 43, 45, 1);

Color blue100 = Color.fromRGBO(0, 146, 255, 1);
Color blue75 = Color.fromRGBO(0, 146, 255, 0.75);
Color blue50 = Color.fromRGBO(0, 146, 255, 0.5);

Color yellow100 = Color.fromRGBO(255, 151, 0, 1);
Color yellow75 = Color.fromRGBO(255, 151, 0, 0.75);
Color yellow50 = Color.fromRGBO(255, 151, 0, 0.5);

Color white = Color.fromRGBO(255, 255, 255, 1);
