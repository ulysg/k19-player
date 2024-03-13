import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/song.dart";
import "package:just_audio_background/just_audio_background.dart";

class PlayerModel extends ChangeNotifier {
  static final player = AudioPlayer();
  final Music music = Music.instance;
  bool playing = false;
  int position = 0;
  int duration = 0;
  Song? song;
  String? streamUrl;

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

  bool songLoaded() {
    return song != null && streamUrl != null;
  }

  Future start([bool forceRefresh = false]) async {
    if (forceRefresh || !songLoaded()) {
      await getRandomSong();
    }

    final audioSource = AudioSource.uri(
      Uri.parse(streamUrl!),
      tag: MediaItem(
        id: song!.id,
        album: song!.album ?? "No album",
        title: song!.title ?? "No title",
        artUri: Uri.parse(
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
      ),
    );

    player.setAudioSource(audioSource);
  }

  Future next() async {
    await start(true);
  }

  seek(int seconds) {
    player.seek(Duration(seconds: seconds));
  }

  Future getRandomSong() async {
    final randomSong = await music.getRandomSong();
    song = randomSong.item2;
    streamUrl = randomSong.item1;
  }

  Future<Song> actualSong() async {
    if (song == null || streamUrl == null) {
      await getRandomSong();
    }
    return song!;
  }
}
