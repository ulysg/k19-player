import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/playlist.dart";
import "package:k19_player/domain/entities/song.dart";

class ContentModel extends ChangeNotifier {
  List<Album> albums = List.empty();
  List<Song> songs = List.empty();
  List<Playlist> playlists = List.empty();

  static ContentModel? _instance;
  static ContentModel get instance => _instance ??= ContentModel._();

  ContentModel._();

  getSongs() async {
    songs = await Music.instance.getRandomSongs();
    notifyListeners();
  }
}