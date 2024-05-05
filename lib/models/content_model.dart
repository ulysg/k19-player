import "package:flutter/material.dart";
import "package:k19_player/data/music.dart";
import "package:k19_player/domain/entities/album.dart";
import "package:k19_player/domain/entities/connection.dart";
import "package:k19_player/domain/entities/media.dart";
import "package:k19_player/domain/entities/playlist.dart";
import "package:k19_player/domain/entities/song.dart";

enum SortOrder {
  random,
  nameAsc,
  nameDesc,
  artistAsc,
  artistDesc,
  yearAsc,
  yearDesc;
}

enum PlaylistSortOrder {
  random,
  nameAsc,
  nameDesc,
  countAsc,
  countDesc,
  yearAsc,
  yearDesc;
}

class ContentModel extends ChangeNotifier {
  List<Album> albums = List.empty();
  List<Song> songs = List.empty();
  List<Playlist> playlists = List.empty();
  List<Media> searchResult = List.empty();
  List<Song> songResult = List.empty();

  SortOrder songsOrder = SortOrder.random;
  SortOrder albumsOrder = SortOrder.random;
  PlaylistSortOrder playlistsOrder = PlaylistSortOrder.nameAsc;

  Connection? connection;
  bool connectionSet = true;
  bool isLoading = false;

  static ContentModel? _instance;
  static ContentModel get instance => _instance ??= ContentModel._();

  ContentModel._();

  getContent() async {
    isLoading = true;
    notifyListeners();

    connection = await Music.instance.getActualConnection();
    connectionSet = connection != null;

    if (!connectionSet) {
      isLoading = false;
      notifyListeners();
      return;
    }   

    songs = await Music.instance.getSongs();
    songs.shuffle();
    albums =  await Music.instance.getAlbums();
    albums.shuffle();
    playlists = await Music.instance.getPlaylists();
    isLoading = false;

    notifyListeners();
  }

  refreshCache() async {
    isLoading = true;
    notifyListeners();

    await Music.instance.refreshCache();
    getContent();
  }

  setConnection(String username, String password, String url) async {
    await Music.instance.setActualConnection(url, username, password);
    connection = await Music.instance.getActualConnection();
  }

  Song getSong(String id) {
    return songs.where((s) => s.id == id).first;
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

  search(String term) {
    if (term.length < 2) {
      searchResult = List.empty();
      return;
    }

    term = term.toLowerCase();
    songResult = songs.where((s) => s.title!.toLowerCase().contains(term) || s.artist!.toLowerCase().contains(term)).toList();
    List<Media> songMediaResult = songResult.map((s) => s as Media).toList();
    List<Media> albumResult = albums.where((a) => a.name!.toLowerCase().contains(term) || a.artist!.toLowerCase().contains(term)).map((a) => a as Media).toList();
    List<Media> playlistResult = playlists.where((p) => p.name!.toLowerCase().contains(term)).map((p) => p as Media).toList();

    searchResult = songMediaResult + albumResult + playlistResult;
    notifyListeners();
  }
}
