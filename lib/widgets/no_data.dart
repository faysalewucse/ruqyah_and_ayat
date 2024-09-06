import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';

class NoData extends StatelessWidget {
  final String text;
  const NoData({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: deviceHeight * 0.3,
        decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/images/no_data.svg",
              width: deviceWidth * 0.3,
            ),
            12.kH,
            Text(
             text,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}
