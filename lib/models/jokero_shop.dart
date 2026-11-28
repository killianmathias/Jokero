import "dart:math";

import "package:jokero/constants/jokero_constants.dart";
import "jokero_joker.dart";
import "jokero_planet.dart";

class JokeroShop {
  List<JokeroJoker> itemsInStore = [];
  List<JokeroPlanet> planetsInStore = [];

  int rerollCost = 5;

  int getWeight(JokerRarity rarity) {
    return switch (rarity) {
      .common => 50,
      .uncommon => 25,
      .rare => 15,
      .legendary => 10,
    };
  }

  void restock(
    List<JokeroJoker> allAvailableJokers, {
    int count = 3,
    int planetCount = 3,
  }) {
    itemsInStore.clear();
    planetsInStore.clear();
    final random = Random();
    final pool = List<JokeroJoker>.from(allAvailableJokers);

    for (int i = 0; i < count && pool.isNotEmpty; i++) {
      final totalWeight = pool.fold(0, (sum, j) => sum + getWeight(j.rarity));

      int roll = random.nextInt(totalWeight);
      for (final joker in pool) {
        roll -= getWeight(joker.rarity);
        if (roll < 0) {
          itemsInStore.add(joker);
          pool.remove(joker);
          break;
        }
      }
    }

    final planetPool = List<JokeroPlanet>.from(allPlanets)..shuffle(random);
    planetsInStore.addAll(planetPool.take(planetCount));
  }

  void removeItem(JokeroJoker joker) {
    itemsInStore.remove(joker);
  }

  void removePlanet(JokeroPlanet planet) {
    planetsInStore.remove(planet);
  }
}
