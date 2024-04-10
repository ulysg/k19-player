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

  getContent() async {
    songs = await Music.instance.getRandomSongs();
    albums =  await Music.instance.getAlbums();
    playlists = await Music.instance.getPlaylists();

    notifyListeners();
  }
}
