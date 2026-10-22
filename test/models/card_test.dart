import 'package:flutter_test/flutter_test.dart';
import 'package:jokero/constants/jokero_constants.dart';
import 'package:jokero/models/jokero_card.dart';
import 'package:jokero/constants/jokero_constants.dart';

void main() {
  group('Tests of class Card', () {
    test('Verify image path', () {
      // Arrange
      final kingOfClub = JokeroCard(Rank.king, Suit.club);
      final kingOfSpade = JokeroCard(Rank.king, Suit.spade);
      final kingOfDiamond = JokeroCard(Rank.king, Suit.diamond);
      final kingOfHeart = JokeroCard(Rank.king, Suit.heart);

      // Act & Assert
      expect(kingOfClub.imageAsset, "${cardImagePathPrefix}club_king.png");
      expect(kingOfSpade.imageAsset, "${cardImagePathPrefix}spade_king.png");
      expect(
        kingOfDiamond.imageAsset,
        "${cardImagePathPrefix}diamond_king.png",
      );
      expect(kingOfHeart.imageAsset, "${cardImagePathPrefix}heart_king.png");
    });
  });
}
