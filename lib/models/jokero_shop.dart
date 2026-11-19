import "dart:math";

import "jokero_joker.dart";

class JokeroShop {
  List<JokeroJoker> itemsInStore = [];

  int rerollCost = 5;

  int getWeight(JokerRarity rarity) {
    return switch (rarity) {
      .common => 50,
      .uncommon => 25,
      .rare => 15,
      .legendary => 10,
    };
  }

  void restock(List<JokeroJoker> allAvailableJokers, {int count = 3}) {
    itemsInStore.clear();
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
  }

  void removeItem(JokeroJoker joker) {
    itemsInStore.remove(joker);
  }
}
