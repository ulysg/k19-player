import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";

class PlayerModel extends ChangeNotifier {
  static final player = AudioPlayer();
  bool playing = false;
  int position = 0;
  int duration = 0;
  MediaItem? mediaItem;

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

    player.durationStream.listen((event) {
      duration = event?.inSeconds ?? 100;
      notifyListeners();
    });

    player.sequenceStateStream.listen((event) {
      if (event?.currentSource != null)
      {
        mediaItem = event!.currentSource!.tag;
        notifyListeners();
      }
    });
  }

  seek(int seconds) {
    player.seek(Duration(seconds: seconds));
  }
}