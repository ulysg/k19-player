import "dart:math";

import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/playlist.dart";
import "package:k19_player/domain/entities/song.dart";

enum SortOrder {
  random(label: "Random"),
  nameAsc(label: "Name ↑"),
  nameDes(label: "Name ↓"),
  yearAsc(label: "Year ↑"),
  yearDes(label: "Year ↓");

  const SortOrder({
    required this.label
  });

  final String label;
}

class ContentModel extends ChangeNotifier {
  List<Album> albums = List.empty();
  List<Song> songs = List.empty();
  List<Playlist> playlists = List.empty();
  SortOrder songsOrder = SortOrder.nameAsc;
  SortOrder albumsOrder = SortOrder.nameAsc;

  static ContentModel? _instance;
  static ContentModel get instance => _instance ??= ContentModel._();

  ContentModel._();

  getContent() async {
    await Music.instance.refreshCache();
    songs = await Music.instance.getRandomSongs();
    albums =  await Music.instance.getAlbums();
    playlists = await Music.instance.getPlaylists();

    notifyListeners();
  }

  changeSongsOrder(SortOrder order) {
    songsOrder = order;
    notifyListeners();    
  }

  changeAlbumsOrder(SortOrder order) {
    albumsOrder = order;
    sortAlbums();
    notifyListeners();    
  }

  sortAlbums() {
    var compare = (Album a, Album b) => a.name!.compareTo(b.name!);

    switch(albumsOrder) {
      case SortOrder.nameAsc:
        compare = (Album a, Album b) => a.name!.compareTo(b.name!);

      case SortOrder.nameDes:
        compare = (Album a, Album b) => b.name!.compareTo(a.name!);

      case SortOrder.yearAsc:
        compare = (Album a, Album b) => a.year!.compareTo(b.year!);

      case SortOrder.yearDes:
        compare = (Album a, Album b) => b.year!.compareTo(a.year!);

      default:
    }

    if (albumsOrder == SortOrder.random) {
      albums.shuffle();
      return;
    }

    albums.sort(compare); 
  }
}
