import 'package:flutter/material.dart';
import "package:jokero/constants/jokero_constants.dart";
import "package:jokero/models/jokero_card.dart";
import "package:jokero/viewmodels/game_view_model.dart";
import "package:jokero/views/custom_text.dart";
import "package:jokero/views/game_information_menu_view.dart";
import "package:jokero/views/joker_list_view.dart";

class RoundView extends StatelessWidget {
  const RoundView({super.key, required this.viewModel});
  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GameInformationMenuView(viewModel: viewModel),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // Plus d'espace pour les Jokers (et leurs boutons au clic)
                  Expanded(flex: 4, child: JokerListView(viewModel: viewModel)),
                  // Espace central réduit
                  const Expanded(flex: 1, child: SizedBox.shrink()),
                  // Plus d'espace pour la main de cartes
                  Expanded(flex: 4, child: CardListView(viewModel: viewModel)),
                  const SizedBox(height: 8),
                  // Les boutons prennent uniquement la hauteur dont ils ont besoin
                  PlayButtons(viewModel: viewModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardListView extends StatelessWidget {
  const CardListView({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final cards = viewModel.hand.hand;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final card in cards)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: SelectableCard(
                  imageAsset: card.imageAsset,
                  isSelected: viewModel.hand.selectedCards.contains(card),
                  onTap: () {
                    final isSelected = viewModel.hand.selectedCards.contains(
                      card,
                    );
                    final selectedCount = viewModel.hand.selectedCards.length;

                    if (!isSelected && selectedCount >= 5) {
                      return;
                    }

                    viewModel.selectCard(card);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SelectableCard extends StatelessWidget {
  const SelectableCard({
    super.key,
    required this.imageAsset,
    required this.isSelected,
    this.onTap,
  });

  final String imageAsset;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const double lift = 10;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          top: isSelected ? 0 : lift,
          bottom: isSelected ? lift : 0,
        ),
        child: Image.asset(imageAsset, fit: BoxFit.contain),
      ),
    );
  }
}

class PlayButtons extends StatelessWidget {
  const PlayButtons({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: ElevatedButton(
            onPressed: viewModel.canPlayHand ? viewModel.playHand : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: blue100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomText(text: "Jouer la main", color: white),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: ElevatedButton(
            onPressed: viewModel.canDiscard ? viewModel.discardCards : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: scoreToReachColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomText(text: "Défausser", color: white),
            ),
          ),
        ),
      ],
    );
  }
}
