import 'package:flutter/material.dart';
import 'package:jokero/models/jokero_blind.dart';
import 'package:jokero/viewmodels/game_view_model.dart';
import 'package:jokero/views/game_information_menu_view.dart';
import 'package:jokero/views/custom_text.dart';
import 'package:jokero/constants/jokero_constants.dart';

class BlindSelectionView extends StatelessWidget {
  const BlindSelectionView({super.key, required this.viewModel});
  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GameInformationMenuView(viewModel: viewModel),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var (index, blind)
                      in viewModel.currentAnte.blinds.indexed)
                    DisabledView(
                      disabled: index != viewModel.currentBlindIndex,
                      child: BlindView(
                        blind: blind,
                        choseBlind: () => viewModel.choseBlind(),
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

class BlindView extends StatelessWidget {
  const BlindView({super.key, required this.blind, required this.choseBlind});
  final JokeroBlind blind;
  final VoidCallback choseBlind;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          decoration: BoxDecoration(
            color: darkGrey,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: choseBlind,
                style: ElevatedButton.styleFrom(
                  backgroundColor: moneyColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size.zero,
                ),
                child: CustomText(text: 'Sélectionner', fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                decoration: BoxDecoration(
                  color: blue50,
                  borderRadius: BorderRadius.circular(12.0),
                  border: BoxBorder.all(color: blue100, width: 2),
                ),
                child: CustomText(text: blind.name),
              ),
              SizedBox(height: 10),
              Image.asset(blind.imageAsset, width: 40),
              SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: .center,
                  children: [
                    CustomText(text: "Marquez au moins", fontSize: 10),
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
                    // Correction de la syntaxe de la chaîne de caractères
                    CustomText(
                      text: "Récompense: \$${blind.reward}+",
                      fontSize: 12,
                      color: const Color.fromRGBO(248, 180, 73, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}

class DisabledView extends StatelessWidget {
  const DisabledView({super.key, required this.disabled, required this.child});

  final bool disabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: disabled ? 0.4 : 1.0,
        child: child,
      ),
    );
  }
}
