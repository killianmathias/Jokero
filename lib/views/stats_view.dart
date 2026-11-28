import 'package:flutter/material.dart';
import "package:jokero/models/jokero_stats_manager.dart";
import 'package:jokero/views/custom_text.dart';
import 'package:jokero/constants/jokero_constants.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key, required this.stats});
  final JokeroStats stats;

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
                          CustomText(text: stats.bestHand.toString()),
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
                            text: stats.getMostPlayedHand()?.name ?? "Aucune",
                          ),
                          const SizedBox(width: 4),
                          CustomText(
                            text:
                                "(${stats.getMostPlayedHand() != null ? stats.playedHands[stats.getMostPlayedHand()!] ?? 0 : 0})",
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
                        text: stats.cardsPlayed.toString(),
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
                        text: stats.cardsDiscarded.toString(),
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
                        text: stats.jokerPurchased.toString(),
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
                      CustomText(text: stats.numberOfReroll.toString()),
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
