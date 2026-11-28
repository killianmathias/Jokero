import "package:flutter/material.dart";
import 'package:jokero/models/jokero_card.dart';

class JokeroCardWidget extends StatelessWidget {
  final JokeroCard card;

  const JokeroCardWidget(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Image.asset(card.imageAsset), const SizedBox(height: 8)],
      ),
    );
  }
}
