import 'package:jokero/models/jokero_joker.dart';

import "dart:math" as math;

class JokeroScore {
  int chips;
  double multi;

  JokeroScore({required this.chips, required this.multi});

  void addChips(int amount) => chips += amount;

  void addMulti(int amount) => multi += amount;

  void multiplyMulti(double factor) => multi *= factor;

  int get totalScore => (chips * multi).ceil();
}
