import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import 'package:jokero/models/JokeroCard.dart';

class JokeroCardWidget extends StatelessWidget {
  final JokeroCard card;

  JokeroCardWidget(this.card);

  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Image.asset(card.image_asset), const SizedBox(height: 8)],
      ),
    );
  }
}
