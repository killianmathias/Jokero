import 'package:jokero/constants/jokero_constants.dart';
import 'package:jokero/models/jokero_hand.dart';

class JokeroPlanet {
  String id;
  String name;
  int cost;
  JokeroPokerHand pokerHand;
  int chipsToAdd;
  int multiToAdd;

  JokeroPlanet(
    this.id,
    this.name,
    this.pokerHand,
    this.chipsToAdd,
    this.multiToAdd, {
    this.cost = 3,
  });

  String get imageAsset => "$planetImagePathPrefix$id.png";
}
