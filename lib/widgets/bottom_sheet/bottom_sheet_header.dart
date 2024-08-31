import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: deviceWidth * 0.3,
      decoration: BoxDecoration(
        color: GRAY,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
