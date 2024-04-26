import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/playlist.dart";
import "package:k19_player/domain/entities/song.dart";

enum SortOrder {
  random(label: "Random"),
  nameAsc(label: "Name ↑"),
  nameDesc(label: "Name ↓"),
  artistAsc(label: "Artist ↑"),
  artistDesc(label: "Artist ↓"),
  yearAsc(label: "Year ↑"),
  yearDesc(label: "Year ↓");

  const SortOrder({
    required this.label
  });

  final String label;
}

enum PlaylistSortOrder {
  random(label: "Random"),
  nameAsc(label: "Name ↑"),
  nameDesc(label: "Name ↓"),
  countAsc(label: "Song count ↑"),
  countDesc(label: "Song count ↓"),
  yearAsc(label: "Created ↑"),
  yearDesc(label: "Created ↓");

  const PlaylistSortOrder({
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
  PlaylistSortOrder playlistsOrder = PlaylistSortOrder.nameAsc;

  static ContentModel? _instance;
  static ContentModel get instance => _instance ??= ContentModel._();

  ContentModel._();

  getContent() async {
    // await Music.instance.refreshCache();
    songs = await Music.instance.getRandomSongs();
    print("SONGS");
    albums =  await Music.instance.getAlbums();
    playlists = await Music.instance.getPlaylists();

    notifyListeners();
  }

  changeSongsOrder(SortOrder order) {
    songsOrder = order;
    sortSongs();
    notifyListeners();    
  }

  changeAlbumsOrder(SortOrder order) {
    albumsOrder = order;
    sortAlbums();
    notifyListeners();    
  }

  changePlaylistsOrder(PlaylistSortOrder order) {
    playlistsOrder = order;
    sortPlaylists();
    notifyListeners();    
  }

  sortAlbums() {
    var compare = (Album a, Album b) => a.name!.compareTo(b.name!);

    switch(albumsOrder) {
      case SortOrder.nameAsc:
        compare = (Album a, Album b) => a.name!.compareTo(b.name!);

      case SortOrder.nameDesc:
        compare = (Album a, Album b) => b.name!.compareTo(a.name!);

      case SortOrder.artistAsc:
        compare = (Album a, Album b) => a.artist!.compareTo(b.artist!);

      case SortOrder.artistDesc:
        compare = (Album a, Album b) => b.artist!.compareTo(a.artist!);

      case SortOrder.yearAsc:
        compare = (Album a, Album b) => a.year!.compareTo(b.year!);

      case SortOrder.yearDesc:
        compare = (Album a, Album b) => b.year!.compareTo(a.year!);

      default:
    }

    if (albumsOrder == SortOrder.random) {
      albums.shuffle();
      return;
    }

    albums.sort(compare); 
  }

  sortSongs() {
    var compare = (Song a, Song b) => a.title!.compareTo(b.title!);

    switch(songsOrder) {
      case SortOrder.nameAsc:
        compare = (Song a, Song b) => a.title!.compareTo(b.title!);

      case SortOrder.nameDesc:
        compare = (Song a, Song b) => b.title!.compareTo(a.title!);

      case SortOrder.artistAsc:
        compare = (Song a, Song b) => a.artist!.compareTo(b.artist!);

      case SortOrder.artistDesc:
        compare = (Song a, Song b) => b.artist!.compareTo(a.artist!);

      case SortOrder.yearAsc:
        compare = (Song a, Song b) => a.year!.compareTo(b.year!);

      case SortOrder.yearDesc:
        compare = (Song a, Song b) => b.year!.compareTo(a.year!);

      default:
    }

    if (songsOrder == SortOrder.random) {
      songs.shuffle();
      return;
    }

    songs.sort(compare); 
  }

  sortPlaylists() {
    var compare = (Playlist a, Playlist b) => a.name!.compareTo(b.name!);

    switch(playlistsOrder) {
      case PlaylistSortOrder.nameAsc:
        compare = (Playlist a, Playlist b) => a.name!.compareTo(b.name!);

      case PlaylistSortOrder.nameDesc:
        compare = (Playlist a, Playlist b) => b.name!.compareTo(a.name!);

      case PlaylistSortOrder.countAsc:
        compare = (Playlist a, Playlist b) => a.songCount!.compareTo(b.songCount!);

      case PlaylistSortOrder.countDesc:
        compare = (Playlist a, Playlist b) => b.songCount!.compareTo(a.songCount!);

      case PlaylistSortOrder.yearAsc:
        compare = (Playlist a, Playlist b) => a.created!.compareTo(b.created!);

      case PlaylistSortOrder.yearDesc:
        compare = (Playlist a, Playlist b) => b.created!.compareTo(a.created!);

      default:
    }

    if (playlistsOrder == PlaylistSortOrder.random) {
      playlists.shuffle();
      return;
    }

    playlists.sort(compare); 
  }
}
