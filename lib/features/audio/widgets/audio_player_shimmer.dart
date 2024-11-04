import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

class AudioPlayerShimmer extends StatelessWidget {
  const AudioPlayerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            height: deviceHeight * 0.4,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
          32.kH,
          Expanded(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Shimmer effect on the title
                Container(
                  height: 40,
                  width: 200,
                  color: Colors.grey.shade300,
                ),
                20.kH,
                // Shimmer effect on the slider
                Container(
                  height: 20,
                  width: deviceWidth * 0.8,
                  color: Colors.grey.shade300,
                ),
                20.kH,
                // Shimmer effect on the Play/Pause buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: Colors.grey.shade300,
                    ),
                    20.kW,
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey.shade300,
                    ),
                    20.kW,
                    Container(
                      height: 40,
                      width: 40,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
