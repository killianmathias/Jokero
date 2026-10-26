import "dart:math";

import "jokero_joker.dart";

class JokeroShop {
  List<JokeroJoker> itemsInStore = [];

  int rerollCost = 5;

  void restock(List<JokeroJoker> allAvailableJokers, {int count = 3}) {
    itemsInStore.clear();

    if (allAvailableJokers.isEmpty) return;

    final random = Random();

    final pool = List<JokeroJoker>.from(allAvailableJokers);
    pool.shuffle(random);

    itemsInStore = pool.take(min(count, pool.length)).toList();
  }

  void removeItem(JokeroJoker joker) {
    itemsInStore.remove(joker);
  }
}
