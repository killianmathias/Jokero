import "package:jokero/models/jokero_blind.dart";
import "package:jokero/models/jokero_joker.dart";
import "package:flutter/material.dart";

const cardImagePathPrefix = "assets/cards/";
const blindImagePathPrefix = "assets/blinds/";
const jokerImagePathPrefix = "assets/jokers/";
const initialNumberOfCardsInHand = 7;
var numberOfCardsInHand = initialNumberOfCardsInHand;
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
  MysticSummit(),
  Misprint(),
  HalfJoker(),
  StencilJoker(),
  Swashbuckler(),
  Blueprint(),
  Brainstorm(),
  Blackboard(),
  SeeingDouble(),
  FlowerPot(),
  CardSharp(),
  Monkey(),
];

List<JokeroBossBlindBuilder> allBossBlinds = [
  ((baseScore) => TheHook(baseScore)),
  (((baseScore) => TheOx(baseScore))),
  (((baseScore) => TheWall(baseScore))),
  ((baseScore) => TheClub(baseScore)),
  ((baseScore) => TheGoad(baseScore)),
  ((baseScore) => TheWindow(baseScore)),
  ((baseScore) => ThePlant(baseScore)),
  ((baseScore) => TheHead(baseScore)),
  ((baseScore) => ThePsychic(baseScore)),
  ((baseScore) => TheWater(baseScore)),
  (((baseScore) => TheManacle(baseScore))),
  ((baseScore) => TheEye(baseScore)),
  ((baseScore) => TheMouth(baseScore)),
  ((baseScore) => TheSnake(baseScore)),
  ((baseScore) => TheNeedle(baseScore)),
  ((baseScore) => TheTooth(baseScore)),
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
