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

  Future<Connection> getActualConnection() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Connection.fromJson(json.decode(prefs.getString("connection")!));
  }

  Future setActualConnection(Connection connection) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("connection", jsonEncode(connection.toJson()));
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

  Future<List<T>> getList<T>(List<T>? data,
      T Function(Map<String, dynamic>) func, String key, int size) async {
    if (data == null || data.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? listString = prefs.getStringList(key);
      if (listString == null) {
        return [];
      }
      data = listString.map((v) => func(json.decode(v))).toList();
    }
    return Tools.getFirstXItems(data, size);
  }

  Future<List<Song>> getSongs({int size = -1}) async {
    return getList(songs, Song.fromJson, "songs", size);
  }

  Future<List<Album>> getAlbums({int size = -1}) async {
    return getList(albums, Album.fromJson, "albums", size);
  }

  Future<List<Playlist>> getPlaylists({int size = -1}) async {
    return getList(playlists, Playlist.fromJson, "playlists", size);
  }

  Future<List<Artist>> getArtists({int size = -1}) async {
    return getList(artists, Artist.fromJson, "artists", size);
  }
}
