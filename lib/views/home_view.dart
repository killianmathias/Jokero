import 'package:flutter/material.dart';
import 'package:jokero/viewmodels/game_view_model.dart';
import 'package:jokero/views/custom_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.viewModel});
  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: "Jokero", fontSize: 64),
            TextButton(
              onPressed: viewModel.startGame,
              child: CustomText(text: "Jouer"),
            ),
          ],
        ),
      ),
    );
  }
}
