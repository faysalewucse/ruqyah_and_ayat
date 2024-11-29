import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/features/audio/controllers/audio_controller.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/features/audio/widgets/audio_title.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

class AudioCard extends StatelessWidget {
  final Audio audio;
  final int index;

  AudioCard({super.key, required this.index, required this.audio});

  final networkController = Get.find<NetworkController>();
  final audioController = Get.find<AudioController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: rounded20, // Ensure rounded corners for the Material
      child: InkWell(
        borderRadius: rounded20,
        onTap: () async{
          final localPath = await audioController.getLocalFilePath(audio.title);

          if(networkController.hasConnection.isTrue || localPath != null){
            Get.toNamed(playAudio, arguments: audio);
          }
          else{
            showErrorToast(message: "এই অডিও টি অফলাইন এর জন্য ডাউনলোড করা নেই। দয়া করে ইন্টারনেট সংযোগ করুন।", alignment: Alignment.topCenter);
          }
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: AudioTitle(title: audio.title, index: index,),
        ),
      ),
    );
  }
}
