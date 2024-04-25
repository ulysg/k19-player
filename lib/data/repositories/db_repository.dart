import 'package:k19_player/data/helpers/tools.dart';
import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/connection.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DbRepository {
  static DbRepository? _instance;
  List<Album>? albums = [];
  List<Playlist>? playlists = [];
  List<Song>? songs = [];
  List<Artist>? artists = [];

  DbRepository._();

  static DbRepository get instance => _instance ??= DbRepository._();

  Future setLastUpdate(DateTime dt) async {
    // TODO: I do not like to write this line every time. It should be refactored.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastUpdate", dt.toIso8601String());
  }

  Future clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<DateTime> getLastUpdate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? timestamp = prefs.getString("lastUpdate");
    if (timestamp == null || timestamp.isEmpty) {
      return DateTime(1970);
    }
    return DateTime.parse(timestamp);
  }

  Future<bool> checkIfValueExist(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(value);
  }

  Future addConnection(Connection connection) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final connections = await getConnections();
    connections.add(connection);
    await prefs.setStringList(
        "connections", connections.map((v) => jsonEncode(v.toJson())).toList());
  }

  Future<List<Connection>> getConnections() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final connections = prefs.getStringList("connections");
    if (connections == null) {
      return [];
    }
    return connections.map((v) => Connection.fromJson(json.decode(v))).toList();
  }

  Future setArtists(List<Artist> artists) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'artists', artists.map((v) => jsonEncode(v.toJson())).toList());
    this.artists = artists;
  }

  Future setSongs(List<Song> songs) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'songs', songs.map((v) => jsonEncode(v.toJson())).toList());
    this.songs = songs;
  }

  Future setPlaylist(List<Playlist> playlists) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        "playlists", playlists.map((v) => jsonEncode(v.toJson())).toList());
    this.playlists = playlists;
  }

  Future setAlbums(List<Album> albums) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        "albums", albums.map((v) => jsonEncode(v.toJson())).toList());
    this.albums = albums;
  }

  Future<List<Song>> getSongs({int size = -1}) async {
    if (songs == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? randomSongs = prefs.getStringList("songs");
      songs = randomSongs!.map((v) => Song.fromJson(json.decode(v))).toList();
      return Tools.getFirstXItems(songs!, size);
    }
    return Tools.getFirstXItems(songs!, size);
  }

  Future<List<Album>> getAlbums({int size = -1}) async {
    if (albums == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? albumsString = prefs.getStringList("albums");
      albums =
          albumsString!.map((v) => Album.fromJson(json.decode(v))).toList();
      return Tools.getFirstXItems(albums!, size);
    }
    return Tools.getFirstXItems(albums!, size);
  }

  Future<List<Playlist>> getPlaylists({int size = -1}) async {
    if (playlists == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? playlistsString = prefs.getStringList("playlists");
      playlists = playlistsString!
          .map((v) => Playlist.fromJson(json.decode(v)))
          .toList();
      return Tools.getFirstXItems(playlists!, size);
    }
    return Tools.getFirstXItems(playlists!, size);
  }

  Future<List<Artist>> getArtists({int size = -1}) async {
    if (artists == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? artistsString = prefs.getStringList("artists");
      artists =
          artistsString!.map((v) => Artist.fromJson(json.decode(v))).toList();
      return Tools.getFirstXItems(artists!, size);
    }
    return Tools.getFirstXItems(artists!, size);
  }

  Future<Album> getAlbum(String id) async {
    if (albums == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? albumsString = prefs.getStringList("albums");
      albums =
          albumsString!.map((v) => Album.fromJson(json.decode(v))).toList();
    }
    for (final album in albums!) {
      if (album.id == id) {
        return album;
      }
    }
    throw Exception("album not found");
  }

  Future<Artist> getArtist(String id) async {
    if (artists == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? artistsString = prefs.getStringList("artists");
      artists =
          artistsString!.map((v) => Artist.fromJson(json.decode(v))).toList();
    }
    for (final artist in artists!) {
      if (artist.id == id) {
        return artist;
      }
    }
    throw Exception("artist not found");
  }

  Future<Playlist> getPlaylist(String id) async {
    if (playlists == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? playlistsString = prefs.getStringList("playlists");
      playlists = playlistsString!
          .map((v) => Playlist.fromJson(json.decode(v)))
          .toList();
    }
    for (final playlist in playlists!) {
      if (playlist.id == id) {
        return playlist;
      }
    }
    throw Exception("playlist not found");
  }

  Future<Song> getSong(String id) async {
    if (songs == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? randomSongs = prefs.getStringList("songs");
      songs = randomSongs!.map((v) => Song.fromJson(json.decode(v))).toList();
    }
    for (final song in songs!) {
      if (song.id == id) {
        return song;
      }
    }
    throw Exception("song not found");
  }
}
