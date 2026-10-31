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
      expect(kingOfClub.imageAsset, "${cardImagePathPrefix}king_of_club.png");
      expect(kingOfSpade.imageAsset, "${cardImagePathPrefix}king_of_spade.png");
      expect(
        kingOfDiamond.imageAsset,
        "${cardImagePathPrefix}king_of_diamond.png",
      );
      expect(kingOfHeart.imageAsset, "${cardImagePathPrefix}king_of_heart.png");
    });
  });
}
