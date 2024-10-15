import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/features/audio/controllers/audio_controller.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';

class AudioHelper{
  final audioController = Get.find<AudioController>();

  Audio? getPreviousAudio({required Audio currentAudio}){
    int currentIndex = getCurrentIndex(currentAudio: currentAudio);
    print("Current index $currentIndex");

    if(currentIndex == 0) return null;
    return audioController.allAudios[currentIndex-1];
  }

  Audio? getNextAudio({required Audio currentAudio}){
    int currentIndex = getCurrentIndex(currentAudio: currentAudio);
    if(currentIndex == audioController.allAudios.length - 1) return null;
    return audioController.allAudios[currentIndex+1];
  }

  int getCurrentIndex({required Audio currentAudio}){
    return audioController.allAudios.indexWhere((Audio audio) => audio.id == currentAudio.id);
  }
}