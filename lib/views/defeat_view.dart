import 'package:flutter/material.dart';
import 'package:jokero/constants/jokero_constants.dart';
import 'package:jokero/models/jokero_stats_manager.dart';
import 'package:jokero/viewmodels/game_view_model.dart';
import 'package:jokero/views/custom_text.dart';

class DefeatView extends StatelessWidget {
  const DefeatView({super.key, required this.viewModel});
  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: .spaceAround,
              crossAxisAlignment: .center,
              children: [
                CustomText(
                  text: viewModel.gameState == .defeat
                      ? "Game Over"
                      : "Victoire",
                  fontSize: 60,
                  color: viewModel.gameState == .defeat
                      ? scoreToReachColor
                      : green,
                ),
                const SizedBox(width: 24),

                if (viewModel.gameState == .defeat) ...[
                  Column(
                    children: [
                      CustomText(
                        text:
                            'Vous avez atteint la mise ${viewModel.currentAnteLevel}',
                        fontSize: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            viewModel.currentBlind.imageAsset,
                            width: 48,
                          ),
                          const SizedBox(width: 6),
                          CustomText(text: 'vous a battu.', fontSize: 24),
                        ],
                      ),
                    ],
                  ),
                ],
              ],
            ),

            const SizedBox(height: 12),
            StatsView(manager: viewModel.statsManager),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: scoreToReachColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () => viewModel.startGame(),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(text: "Rejouer"),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: moneyColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () => viewModel.goToMenu(),
                  // FittedBox empêche le texte de déborder sur petits écrans
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(text: "Menu Principal"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({super.key, required this.manager});
  final JokeroStatsManager manager;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Meilleure main"),
                      Row(
                        children: [
                          Image.asset("assets/blinds/token.png", width: 12),
                          const SizedBox(width: 6),
                          CustomText(text: manager.bestHand.toString()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Main favorite"),
                      Row(
                        children: [
                          CustomText(
                            text: manager.getMostPlayedHand().name.toString(),
                          ),
                          const SizedBox(width: 4),
                          CustomText(
                            text:
                                "(${manager.playedHands[manager.getMostPlayedHand()]})",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Cartes jouees"),
                      CustomText(
                        text: manager.cardsPlayed.toString(),
                        color: blue100,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Cartes defaussees"),
                      CustomText(
                        text: manager.cardsDiscarded.toString(),
                        color: scoreToReachColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Jokers acquis"),
                      CustomText(
                        text: manager.jokerPurchased.toString(),
                        color: moneyColor,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Nombre de relance"),
                      CustomText(text: manager.numberOfReroll.toString()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
