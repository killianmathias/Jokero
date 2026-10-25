import 'package:jokero/models/jokero_blind.dart';
import "package:jokero/constants/jokero_constants.dart";

class JokeroAnte {
  final int level;
  late final List<JokeroBlind> blinds;

  JokeroAnte(this.level) {
    int baseScore = baseChips[level] ?? (level * 10000);

    blinds = [
      JokeroSmallBlind(baseScore),
      JokeroBigBlind(baseScore),
      JokeroBossBlind(baseScore),
    ];
  }
}
