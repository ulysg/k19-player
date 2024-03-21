import "package:flutter/material.dart";
import "package:just_audio/just_audio.dart";
import "package:just_audio_background/just_audio_background.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/song.dart";

enum PlayingState {
  paused,
  loading,
  playing,
}

class PlayerModel extends ChangeNotifier {
  static final player = AudioPlayer();
  
  PlayingState playingState = PlayingState.paused;
  int position = 0;
  int duration = 0;
  MediaItem? mediaItem;
  int playingIndex = -1;
  int maxIndex = 0;

  List<Song>? _newPlaylist;
  
  static PlayerModel? _instance;

  static PlayerModel get instance => _instance ??= PlayerModel._();

  PlayerModel._() {
    player.playerStateStream.listen((state) {
      playingState = PlayingState.paused;

      if (state.playing) {
        playingState = state.processingState == ProcessingState.ready ? PlayingState.playing : PlayingState.loading;
      }

      // playing = state.playing && state.processingState == ProcessingState.ready;
      notifyListeners();
    });

    player.positionStream.listen((event) {
      duration = player.duration?.inSeconds ?? 0;
      position = event.inSeconds;
      notifyListeners();
    });

    player.durationStream.listen((event) {
      duration = event?.inSeconds ?? 0;
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

  seek(int seconds) async {
    await player.seek(Duration(seconds: seconds));
  }

  setPlaylist(List<Song> playlist) async {
    if (player.playerState.processingState == ProcessingState.loading) {
      _newPlaylist = playlist;
      return;
    }

    _newPlaylist = null;

    ConcatenatingAudioSource source = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: playlist.map(songToAudioSource).toList()
    );

    await player.setAudioSource(source);

    if (_newPlaylist != null) {
      setPlaylist(_newPlaylist!);
    }
  }

  AudioSource songToAudioSource(Song song) {
    return AudioSource.uri(
      Music.getSongUri(song),

      tag: MediaItem(
        id: song.id,
        title: song.title ?? "notitle",
        artist: song.artist ?? "noartist",
        album: song.album ?? "noalbum",
        artUri: Music.getCoverUri(song),
      )
    );
  }

  static secondsToString(int seconds) {
    Duration duration = Duration(seconds: seconds);
    String m = duration.inMinutes.remainder(60).toString();
    String s = duration.inSeconds.remainder(60).toString().padLeft(2, "0");

    return "$m:$s";
  }
}