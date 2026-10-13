import 'package:flutter_test/flutter_test.dart';
import 'package:jokero/models/card.dart';
import 'package:jokero/constants/card_constants.dart';

void main() {
  group('Tests of class Card', () {
    test('Verify image path', () {
      // Arrange
      final kingOfClub = King(Suit.club);
      final kingOfSpade = King(Suit.spade);
      final kingOfDiamond = King(Suit.diamond);
      final kingOfHeart = King(Suit.heart);

      // Act & Assert
      expect(kingOfClub.image_asset, "${IMAGE_ASSET_PREFIX}club_king.png");
      expect(kingOfSpade.image_asset, "${IMAGE_ASSET_PREFIX}spade_king.png");
      expect(
        kingOfDiamond.image_asset,
        "${IMAGE_ASSET_PREFIX}diamond_king.png",
      );
      expect(kingOfHeart.image_asset, "${IMAGE_ASSET_PREFIX}heart_king.png");
    });
  });
}
