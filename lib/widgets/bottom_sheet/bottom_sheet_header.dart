import 'package:flutter/material.dart';

import 'package:rukiyah_and_ayat/helper/constant.dart';

import '../../utils/constants/app_colors.dart';

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6,
      width: deviceWidth * 0.3,
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
