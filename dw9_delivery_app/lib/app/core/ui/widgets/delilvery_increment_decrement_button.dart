import 'package:flutter/material.dart';

import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/styles/text_styles_app.dart';

class DelilveryIncrementDecrementButton extends StatelessWidget {
  final int ammount;
  final VoidCallback incrementTap;
  final VoidCallback decrementTap;
  final bool _compact;

  const DelilveryIncrementDecrementButton({
    super.key,
    required this.ammount,
    required this.incrementTap,
    required this.decrementTap,
  }) : _compact = false;

  const DelilveryIncrementDecrementButton.compact({
    super.key,
    required this.ammount,
    required this.incrementTap,
    required this.decrementTap,
  }) : _compact = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compact ? const EdgeInsets.all(5) : null,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: decrementTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '-',
                style: context.textStyle.textMedium.copyWith(
                  fontSize: _compact ? 10 : 22,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Text(
            ammount.toString(),
            style: context.textStyle.textRegular.copyWith(
              fontSize: _compact ? 13 : 17,
              color: context.colors.secondary,
            ),
          ),
          InkWell(
            onTap: incrementTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                '+',
                style: context.textStyle.textMedium.copyWith(
                  fontSize: _compact ? 10 : 22,
                  color: context.colors.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
