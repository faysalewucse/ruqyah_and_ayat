import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';

//=============text style======================//
TextStyle errorTextStyle =
const TextStyle(color: RED, fontWeight: FontWeight.w500, fontSize: 10);

TextStyle levelStyle12 =
const TextStyle(color: GRAY, fontWeight: FontWeight.w800, fontSize: 12);

//==============box decoration==================//
BorderRadius rounded2 = BorderRadius.circular(2);
BorderRadius rounded4 = BorderRadius.circular(4);
BorderRadius rounded6 = BorderRadius.circular(6);
BorderRadius rounded8 = BorderRadius.circular(8);
BorderRadius roundedFull = BorderRadius.circular(50);

//===============gaps========================//
SizedBox verticalGap2 = const SizedBox(height: 2);
SizedBox verticalGap5 = const SizedBox(height: 5);
SizedBox verticalGap8 = const SizedBox(height: 8);
SizedBox verticalGap10 = const SizedBox(height: 10);
SizedBox verticalGap12 = const SizedBox(height: 12);
SizedBox verticalGap16 = const SizedBox(height: 16);
SizedBox verticalGap20 = const SizedBox(height: 20);
SizedBox verticalGap24 = const SizedBox(height: 24);
SizedBox verticalGap32 = const SizedBox(height: 32);

Widget expanded = const Expanded(child: SizedBox());

SizedBox horizontalGap2 = const SizedBox(width: 2);
SizedBox horizontalGap4 = const SizedBox(width: 4);
SizedBox horizontalGap5 = const SizedBox(width: 5);
SizedBox horizontalGap8 = const SizedBox(width: 8);
SizedBox horizontalGap10 = const SizedBox(width: 10);
SizedBox horizontalGap12 = const SizedBox(width: 12);
SizedBox horizontalGap16 = const SizedBox(width: 16);
SizedBox horizontalGap20 = const SizedBox(width: 20);
SizedBox horizontalGap24 = const SizedBox(width: 24);
SizedBox horizontalGap32 = const SizedBox(width: 32);

//=====================textStyle================
TextStyle n30014Normal = const TextStyle(
    color: NEUTRAL_N300, fontSize: 14, fontWeight: FontWeight.normal); //done
TextStyle n30014W500 = const TextStyle(
    color: NEUTRAL_N300, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle n30012W500 = const TextStyle(
    color: NEUTRAL_N300, fontSize: 12, fontWeight: FontWeight.normal);
TextStyle n50014W400 = const TextStyle(
    color: NEUTRAL_N500, fontSize: 14, fontWeight: FontWeight.normal);
TextStyle n70018Normal = const TextStyle(
    color: NEUTRAL_N700, fontSize: 18, fontWeight: FontWeight.normal);
TextStyle white18Normal = const TextStyle(
    color: WHITE, fontSize: 18, fontWeight: FontWeight.normal);
TextStyle n30016W500 = const TextStyle(
    color: NEUTRAL_N300, fontSize: 16, fontWeight: FontWeight.w500); //done
TextStyle n30022Normal = const TextStyle(
    color: NEUTRAL_N300, fontSize: 22, fontWeight: FontWeight.normal); //done
TextStyle n70012Normal = const TextStyle(
    color: NEUTRAL_N700, fontSize: 12, fontWeight: FontWeight.normal); //done
TextStyle n70012W500 = const TextStyle(
    color: NEUTRAL_N700, fontSize: 12, fontWeight: FontWeight.w500); //done
TextStyle n70014Normal = const TextStyle(
    color: NEUTRAL_N700, fontSize: 14, fontWeight: FontWeight.normal); //done
TextStyle n70014W500 = const TextStyle(
    color: NEUTRAL_N700, fontSize: 14, fontWeight: FontWeight.w500); //done
TextStyle n70016W500 = const TextStyle(
    color: NEUTRAL_N700, fontSize: 16, fontWeight: FontWeight.w500); //done
TextStyle n70016W500LineThrough = const TextStyle(
    color: NEUTRAL_N700,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough); //done
TextStyle n30016W500LineThrough = const TextStyle(
    color: NEUTRAL_N300,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough); //done
TextStyle e50016W500 = const TextStyle(
    color: ERROR_500, fontSize: 16, fontWeight: FontWeight.w500); //done
TextStyle n70020W500 = const TextStyle(
    color: NEUTRAL_N700, fontSize: 20, fontWeight: FontWeight.w500);
TextStyle n70024W500 = const TextStyle(
    color: NEUTRAL_N700, fontSize: 24, fontWeight: FontWeight.w500);
TextStyle primary14W500 = const TextStyle(
    color: PRIMARY_COLOR, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle primary20W500 = const TextStyle(
    color: PRIMARY_COLOR, fontSize: 20, fontWeight: FontWeight.w500);
TextStyle n10014W500 = const TextStyle(
    color: NEUTRAL_N100, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle n20014W500 = const TextStyle(
    color: NEUTRAL_N200, fontSize: 14, fontWeight: FontWeight.w500);

TextStyle white14W500 = const TextStyle(
    color: WHITE, fontSize: 14, fontWeight: FontWeight.w500);
TextStyle megebtaSeed20W500 = const TextStyle(
    color: PRIMARY_COLOR, fontSize: 20, fontWeight: FontWeight.w500);
TextStyle megebtaSeed14W500 = const TextStyle(
    color: PRIMARY_COLOR, fontSize: 14, fontWeight: FontWeight.w500);

//========================borders==================//
OutlineInputBorder outlineBorder2N30 = OutlineInputBorder(
    borderSide: const BorderSide(
        color: NEUTRAL_N30, width: 1, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(2.0));

BoxBorder boxBorderN50 = Border.all(color: NEUTRAL_N50);
BoxDecoration roundedWhite = BoxDecoration(color: WHITE, borderRadius: rounded2);
