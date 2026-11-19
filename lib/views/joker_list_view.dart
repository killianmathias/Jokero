import 'package:flutter/material.dart';
import 'package:jokero/constants/jokero_constants.dart';
import 'package:jokero/models/jokero_joker.dart';
import 'package:jokero/viewmodels/game_view_model.dart';
import 'package:jokero/views/custom_text.dart';

class JokerListView extends StatefulWidget {
  const JokerListView({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  State<JokerListView> createState() => _JokerListViewState();
}

class _JokerListViewState extends State<JokerListView> {
  dynamic selectedJokerId;

  void toggleJokerSelection(dynamic jokerId) {
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
            Expanded(child: CustomText(text: joker.name)),
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
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: lightGrey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ReorderableListView(
        scrollDirection: Axis.horizontal,
        buildDefaultDragHandles: false,
        padding: const EdgeInsets.symmetric(vertical: 4),
        onReorderItem: (oldIndex, newIndex) {
          widget.viewModel.reorderJokers(oldIndex, newIndex);
        },
        children: [
          for (final (index, joker) in widget.viewModel.jokers.indexed)
            _buildJokerCard(index, joker),
        ],
      ),
    );
  }

  Widget _buildJokerCard(int index, JokeroJoker joker) {
    final bool isSelected = selectedJokerId == joker.id;

    return Padding(
      key: ValueKey(joker.id),
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: ReorderableDelayedDragStartListener(
        index: index,
        child: GestureDetector(
          onTap: () => toggleJokerSelection(joker.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutBack,
            transform: Matrix4.translationValues(0, isSelected ? -5 : 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withValues(alpha: 0.25)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: AnimatedScale(
                    scale: isSelected ? 1.08 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Image.asset(joker.imageAsset, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 4),
                CustomText(text: joker.name),

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
                                  backgroundColor: scoreToReachColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  setState(() => selectedJokerId = null);
                                  widget.viewModel.sellJoker(joker);
                                },
                                child: CustomText(
                                  text: "Vendre (${joker.sellPrice}\$)",
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () =>
                                    showJokerDescription(context, joker),
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
      ),
    );
  }
}
