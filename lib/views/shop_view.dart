import 'package:flutter/material.dart';
import 'package:jokero/constants/jokero_constants.dart';
import 'package:jokero/models/jokero_joker.dart';
import 'package:jokero/viewmodels/game_view_model.dart';
import 'package:jokero/views/custom_text.dart';
import 'package:jokero/views/game_information_menu_view.dart';
import 'package:jokero/views/joker_list_view.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key, required this.viewModel});
  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GameInformationMenuView(viewModel: viewModel),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(flex: 5, child: JokerListView(viewModel: viewModel)),
                  const SizedBox(height: 10),
                  Expanded(flex: 6, child: ShopJokerList(viewModel: viewModel)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopJokerList extends StatefulWidget {
  const ShopJokerList({super.key, required this.viewModel});
  final GameViewModel viewModel;

  @override
  State<ShopJokerList> createState() => ShopJokerListState();
}

class ShopJokerListState extends State<ShopJokerList> {
  String? selectedJokerId;

  void toggleSelection(String jokerId) {
    setState(() {
      selectedJokerId = (selectedJokerId == jokerId) ? null : jokerId;
    });
  }

  void showJokerDescription(BuildContext context, JokeroJoker joker) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: lightGrey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Image.asset(joker.imageAsset, width: 40),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: joker.name),
                  const SizedBox(height: 4),
                  RarityBadge(rarity: joker.rarity),
                ],
              ),
            ),
          ],
        ),
        content: CustomText(text: joker.description),
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
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: lightGrey.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  onPressed: () => widget.viewModel.leaveShop(),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(text: "Manche suivante"),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() => selectedJokerId = null);
                    widget.viewModel.rerollShop();
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CustomText(
                      text: "Relancer (${widget.viewModel.shop.rerollCost}\$)",
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              itemCount: widget.viewModel.shop.itemsInStore.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final joker = widget.viewModel.shop.itemsInStore[index];
                final isSelected = selectedJokerId == joker.id;

                return ShopJokerCard(
                  key: ValueKey(joker.id),
                  joker: joker,
                  isSelected: isSelected,
                  canBuy: widget.viewModel.canBuyJoker(joker),
                  onTap: () => toggleSelection(joker.id),
                  onBuy: () {
                    setState(() => selectedJokerId = null);
                    widget.viewModel.buyJoker(joker);
                  },
                  onInfo: () => showJokerDescription(context, joker),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShopJokerCard extends StatelessWidget {
  const ShopJokerCard({
    super.key,
    required this.joker,
    required this.isSelected,
    required this.canBuy,
    required this.onTap,
    required this.onBuy,
    required this.onInfo,
  });

  final JokeroJoker joker;
  final bool isSelected;
  final bool canBuy;
  final VoidCallback onTap;
  final VoidCallback onBuy;
  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutBack,
          transform: Matrix4.translationValues(0, isSelected ? -5 : 0, 0),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RarityBadge(rarity: joker.rarity),
              const SizedBox(height: 4),

              Flexible(
                child: AnimatedScale(
                  scale: isSelected ? 1.08 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Image.asset(joker.imageAsset, fit: BoxFit.contain),
                ),
              ),
              const SizedBox(height: 4),

              CustomText(text: "${joker.name}"),

              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                child: isSelected
                    ? Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: canBuy
                                    ? scoreToReachColor
                                    : Colors.grey,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: canBuy ? onBuy : null,
                              child: CustomText(
                                text: "Acheter (${joker.cost}\$)",
                              ),
                            ),
                            const SizedBox(width: 6),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: onInfo,
                              child: const Icon(Icons.info_outline, size: 16),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RarityBadge extends StatelessWidget {
  const RarityBadge({required this.rarity});
  final JokerRarity rarity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: rarity.color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: CustomText(text: rarity.label, fontSize: 10),
    );
  }
}
