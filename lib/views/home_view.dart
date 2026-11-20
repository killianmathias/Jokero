import 'package:flutter/material.dart';
import 'package:jokero/constants/jokero_constants.dart';
import 'package:jokero/models/jokero_stats_manager.dart';
import 'package:jokero/viewmodels/game_view_model.dart';
import 'package:jokero/views/custom_text.dart';
import 'package:jokero/views/stats_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.viewModel});
  final GameViewModel viewModel;

  void showAllTimeStats(BuildContext context, JokeroStatsManager manager) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: lightGrey,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(children: [CustomText(text: "Vos statistiques")]),
        content: SizedBox(
          width: double.maxFinite,
          child: FutureBuilder<JokeroStats>(
            future: viewModel.statsManager.getAllTimeStats(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  heightFactor: 1,
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text("Erreur : ${snapshot.error}"));
              }

              if (snapshot.hasData) {
                return StatsView(stats: snapshot.data!);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: CustomText(text: "Fermer"),
          ),
        ],
      ),
    );
  }

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
            Row(
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue100,
                    foregroundColor: white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: viewModel.startGame,
                  child: CustomText(text: "Jouer"),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () =>
                      showAllTimeStats(context, viewModel.statsManager),
                  child: CustomText(text: "Stats"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
