import 'package:flutter_test/flutter_test.dart';
import 'package:jokero/models/JokeroDeck.dart';
import 'package:jokero/constants/card_constants.dart';

void main() {
  group('Tests of class Deck', () {
    test('Verify number of cards', () {
      final deck = JokeroDeck.createStartingDeck();

      expect(deck.deck.length, 52);
    });
  });
}
