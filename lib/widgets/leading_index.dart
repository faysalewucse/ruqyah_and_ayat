import 'package:bangla_converter/bangla_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LeadingIndex extends StatelessWidget {
  final int index;

  const LeadingIndex({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Get.isDarkMode
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).primaryColor.withValues(alpha: 0.06),
      ),
      child: Center(
        child: Text(
          BanglaConverter.engToBan(index),
          style: GoogleFonts.poppins(),
        ),
      ),
    );
  }
}
