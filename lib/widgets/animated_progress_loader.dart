import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';

class AnimatedLiquidLinearProgressIndicator extends StatefulWidget {
  final double progress;

  const AnimatedLiquidLinearProgressIndicator({super.key, required this.progress});

  @override
  State<StatefulWidget> createState() =>
      AnimatedLiquidLinearProgressIndicatorState();
}

class AnimatedLiquidLinearProgressIndicatorState
    extends State<AnimatedLiquidLinearProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    final percentage = widget.progress * 100;
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 24.0,
        child: LiquidLinearProgressIndicator(
          value: widget.progress,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(
              Theme.of(context).primaryColor.withOpacity(0.2)),
          borderRadius: 12.0,
          borderColor: AppColors.primaryColor.withOpacity(0.3),
          borderWidth: 1,
          center: Text(
            "${percentage.toStringAsFixed(0)}%", // Show the progress percentage
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
