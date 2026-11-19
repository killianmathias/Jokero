import "package:flutter/material.dart";
import "package:jokero/constants/jokero_constants.dart";
import "package:jokero/models/jokero_ante.dart";
import "package:jokero/models/jokero_blind.dart";
import "package:jokero/models/jokero_hand.dart";
import "package:jokero/models/jokero_score.dart";
import "package:jokero/viewmodels/game_view_model.dart";
import "package:jokero/views/custom_text.dart";

class GameInformationMenuView extends StatelessWidget {
  const GameInformationMenuView({super.key, required this.viewModel});
  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Bloc 1 : Blind ou Shop (flex: 3)
        Expanded(
          flex: 3,
          child: viewModel.gameState == .shop
              ? Center(
                  child: Image.asset(
                    "assets/other_images/shop.gif",
                    fit: BoxFit.contain,
                  ),
                )
              : BlindInformationView(
                  ante: viewModel.currentAnte,
                  blind: viewModel.currentBlind,
                ),
        ),
        const SizedBox(height: 4),
        // Bloc 2 : Score du round (flex: 2)
        Expanded(flex: 2, child: RoundScoreView(score: viewModel.score)),
        const SizedBox(height: 4),
        // Bloc 3 : Main de poker & Multiplicateur (flex: 2)
        Expanded(
          flex: 2,
          child: PokerHandView(
            pokerHand: viewModel.currentCombinaison.pokerHand,
          ),
        ),
        const SizedBox(height: 4),
        // Bloc 4 : Mains, Défausses, Argent, Mise, Round (flex: 4)
        Expanded(
          flex: 4,
          child: OtherGameInformationView(viewModel: viewModel),
        ),
      ],
    );
  }
}

class BlindInformationView extends StatelessWidget {
  const BlindInformationView({
    super.key,
    required this.ante,
    required this.blind,
  });
  final JokeroAnte ante;
  final JokeroBlind blind;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(text: blind.name, fontSize: 13),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset(blind.imageAsset, fit: BoxFit.contain),
                ),
                const SizedBox(width: 6),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: darkGrey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: "Objectif", fontSize: 10),
                          Row(
                            children: [
                              Image.asset(
                                "assets/blinds/token.png",
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 4),
                              CustomText(
                                text: blind.scoreToReach.toString(),
                                fontSize: 18,
                                color: scoreToReachColor,
                              ),
                            ],
                          ),
                          CustomText(
                            text: "Gagnez ${"\$" * blind.reward}",
                            fontSize: 11,
                            color: const Color.fromRGBO(248, 180, 73, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RoundScoreView extends StatelessWidget {
  const RoundScoreView({super.key, required this.score});
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: CustomText(text: "Round score", fontSize: 13),
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  Image.asset("assets/blinds/token.png", width: 18, height: 18),
                  const SizedBox(width: 4),
                  CustomText(text: score.toString(), fontSize: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PokerHandView extends StatelessWidget {
  const PokerHandView({super.key, required this.pokerHand});
  final JokeroPokerHand pokerHand;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: CustomText(text: pokerHand.name, fontSize: 13),
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: blue100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CustomText(
                      text: pokerHand.chips.toString(),
                      fontSize: 16,
                    ),
                  ),
                  CustomText(
                    text: " X ",
                    fontSize: 16,
                    color: scoreToReachColor,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: scoreToReachColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CustomText(
                      text: pokerHand.multi.toString(),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OtherGameInformationView extends StatelessWidget {
  const OtherGameInformationView({super.key, required this.viewModel});
  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildMiniStat(
                    "Mains",
                    viewModel.remainingHands.toString(),
                    blue100,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _buildMiniStat(
                    "Défausses",
                    viewModel.remainingDiscards.toString(),
                    scoreToReachColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: lightGrey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: CustomText(
                  text: "${viewModel.money}\$",
                  fontSize: 18,
                  color: moneyColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: _buildMiniStat(
                    "Mise",
                    "${viewModel.currentAnteLevel}/8",
                    white,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _buildMiniStat(
                    "Round",
                    (viewModel.currentAnteLevel *
                            (viewModel.currentBlindIndex + 1))
                        .toString(),
                    white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: label, fontSize: 10),
            CustomText(text: value, fontSize: 15, color: color),
          ],
        ),
      ),
    );
  }
}
