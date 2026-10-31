import 'package:flutter/material.dart';
import 'package:jokero/models/jokero_game_state.dart';
import 'package:jokero/viewmodels/game_view_model.dart';
import 'package:jokero/views/blind_selection_view.dart';
import 'package:jokero/views/defeat_view.dart';
import 'package:jokero/views/game_information_menu_view.dart';
import 'package:jokero/views/round_view.dart';
import 'package:jokero/views/shop_view.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const JokeroGame());
  });
}

class JokeroGame extends StatefulWidget {
  const JokeroGame({super.key});

  @override
  State<JokeroGame> createState() => _JokeroGameState();
}

class _JokeroGameState extends State<JokeroGame> {
  late final GameViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = GameViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, child) {
          return Scaffold(
            backgroundColor: const Color(0xFF0F1B1A),

            body: SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GameInformationMenuView(viewModel: _viewModel),
                      ),
                      Expanded(flex: 3, child: _buildCurrentScreen(_viewModel)),
                      // const Expanded(flex: 2, child: Column(
                      //   children: [

                      //     const Expanded(child: )
                      //     const Expanded(flex: 3, child: CenterPlayAreaWidget()),

                      //     const Expanded(flex: 2, child: PlayerHandWidget()),
                      //   ],
                      // )),
                    ],
                  ),
                ],
              ),
            ),

            //  _buildCurrentScreen(_viewModel),
          );
        },
      ),
    );
  }

  Widget _buildCurrentScreen(GameViewModel vm) {
    switch (vm.gameState) {
      case JokeroGameState.blindSelection:
        return BlindSelectionView(viewModel: vm);
      case JokeroGameState.round:
        return RoundView(viewModel: vm);
      case JokeroGameState.shop:
        return ShopView(viewModel: vm);
      case JokeroGameState.defeat:
        return DefeatView(viewModel: vm);
    }
  }
}
