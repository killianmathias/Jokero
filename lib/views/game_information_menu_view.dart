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
        BlindInformationView(
          ante: viewModel.currentAnte,
          blind: viewModel.currentBlind,
        ),
        const SizedBox(height: 6),
        RoundScoreView(score: viewModel.score),
        const SizedBox(height: 6),
        PokerHandView(pokerHand: viewModel.currentCombinaison.pokerHand),
        const SizedBox(height: 6),
        OtherGameInformationView(viewModel: viewModel),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: blind.name, fontSize: 14),
        const SizedBox(height: 2),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Image.asset(blind.imageAsset, width: 32, height: 32),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 6,
                  ),
                  decoration: BoxDecoration(
                    color: darkGrey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Objectif", fontSize: 10),
                      Row(
                        children: [
                          Image.asset(
                            "assets/blinds/token.png",
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(width: 4),
                          CustomText(
                            text: blind.scoreToReach.toString(),
                            fontSize: 20,
                            color: scoreToReachColor,
                          ),
                        ],
                      ),
                      CustomText(
                        text: "Gagnez " + ("\$" * blind.reward),
                        fontSize: 12,
                        color: const Color.fromRGBO(248, 180, 73, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RoundScoreView extends StatelessWidget {
  const RoundScoreView({super.key, required this.score});
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: "Round score", fontSize: 14),
          Row(
            children: [
              Image.asset("assets/blinds/token.png", width: 20, height: 20),
              const SizedBox(width: 6),
              CustomText(text: score.toString(), fontSize: 20),
            ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: pokerHand.name, fontSize: 14),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: blue100,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomText(
                  text: pokerHand.chips.toString(),
                  fontSize: 18,
                ),
              ),
              CustomText(text: " X ", fontSize: 18, color: scoreToReachColor),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: scoreToReachColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomText(
                  text: pokerHand.multi.toString(),
                  fontSize: 18,
                ),
              ),
            ],
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
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: darkGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMiniStat(
                  "Mains",
                  viewModel.remainingHands.toString(),
                  blue100,
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: _buildMiniStat(
                  "Défausses",
                  viewModel.remainingDiscards.toString(),
                  scoreToReachColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: "${viewModel.money}\$",
              fontSize: 20,
              color: moneyColor,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _buildMiniStat(
                  "Mise",
                  "${viewModel.currentAnteLevel.toString()}/8",
                  white,
                ),
              ),
              const SizedBox(width: 6),
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
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          CustomText(text: label, fontSize: 11),
          CustomText(text: value, fontSize: 16, color: color),
        ],
      ),
    );
  }
}
