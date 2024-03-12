import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";

class PlayerModel extends ChangeNotifier {
  static final player = AudioPlayer();
  bool playing = false;
  int position = 0;
  int duration = 0;

  PlayerModel() {
    player.playerStateStream.listen((state) {
      if (playing != state.playing) {
        playing = state.playing;
        notifyListeners();
      }
    });
    
    player.positionStream.listen((event) {
      duration = player.duration?.inSeconds ?? 100;
      position = event.inSeconds;
      notifyListeners();
    });
  }

  seek(int seconds) {
    player.seek(Duration(seconds: seconds));
  }
}