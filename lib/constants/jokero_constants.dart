import "package:jokero/models/jokero_blind.dart";
import "package:jokero/models/jokero_joker.dart";
import "package:flutter/material.dart";

const cardImagePathPrefix = "assets/cards/";
const blindImagePathPrefix = "assets/blinds/";
const jokerImagePathPrefix = "assets/jokers/";
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
  JokerAbstrait(),
  JokerAncient(),
  ArrowHead(),
  JokeroBanner(),
  Acrobat(),
  Baron(),
  JokerJovial(),
  JokerDrole(),
  JokerLoufoque(),
  JokerCingle(),
  JokerMaboul(),
  JokerFute(),
  JokerRuse(),
  JokerAstucieux(),
  JokerSournois(),
  JokerHabile(),
  LeDuo(),
  LeTrio(),
  LaFamille(),
  LOrdre(),
  LaTribu(),
  OnyxAgate(),
  Bloodstone(),
  RoughGem(),
  Fibonacci(),
  EvenSteven(),
  OddTodd(),
  Scholar(),
  ScaryFace(),
  SmileyFace(),
  WalkieTalkie(),
  Triboulet(),
  Photograph(),
  WeeJoker(),
  Hiker(),
  MysticSummit(),
  Misprint(),
  HalfJoker(),
  StencilJoker(),
  Swashbuckler(),
  CeremonialDagger(),
  Blueprint(),
  Brainstorm(),
  Cavendish(),
  GrosMichel(),
  Blackboard(),
  SeeingDouble(),
  FlowerPot(),
  CardSharp(),
  Monkey(),
];

List<JokeroBossBlindBuilder> allBossBlinds = [
  ((baseScore) => TheHook(baseScore)),
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
Color green = Color.fromRGBO(97, 187, 138, 1);

const Color commonColor = Color(0xFF009DFF);
const Color uncommonColor = Color(0xFF4BC292);
const Color rareColor = Color(0xFFFE5F55);
const Color legendaryColor = Color(0xFFB26CBB);
