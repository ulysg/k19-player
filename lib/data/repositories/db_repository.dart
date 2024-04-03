import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DbRepository {
  static DbRepository? _instance;
  List<Album> albums = [];
  List<Playlist> playlists = [];
  List<Song> songs = [];
  List<Artist> artists = [];

  DbRepository._();

  static DbRepository get instance => _instance ??= DbRepository._();

  Future setLastUpdate(DateTime dt) async {
    // TODO: I do not like to write this line every time. It should be refactored.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastUpdate", dt.toIso8601String());
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

  Future setArtists(List<Artist> artists) async {
    this.artists = artists;
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setStringList(
    //    'artists', artists.map((v) => jsonEncode(v.toJson())).toList());
  }

  Future setSongs(List<Song> songs) async {
    this.songs = songs;
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setStringList(
    //    'songs', songs.map((v) => jsonEncode(v.toJson())).toList());
  }

  Future setPlaylist(List<Playlist> playlists) async {
    this.playlists = playlists;
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setStringList(
    //    "playlists", playlists.map((v) => jsonEncode(v.toJson())).toList());
  }

  Future setAlbums(List<Album> albums) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setStringList(
    //    "albums", albums.map((v) => jsonEncode(v.toJson())).toList());
    this.albums = albums;
  }

  Future<List<Song>> getSongs({int size = 10}) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //final List<String>? randomSongs = prefs.getStringList("songs");
    //return randomSongs!.map((v) => Song.fromJson(json.decode(v))).toList();
    return songs;
  }

  Future<List<Album>> getAlbums() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //final List<String>? albums = prefs.getStringList("albums");
    //return albums!.map((v) => Album.fromJson(json.decode(v))).toList();
    return albums;
  }

  Future<List<Playlist>> getPlaylists() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //final List<String>? playlists = prefs.getStringList("playlists");
    //return playlists!.map((v) => Playlist.fromJson(json.decode(v))).toList();
    return playlists;
  }

  Future<List<Artist>> getArtists() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //final List<String>? artists = prefs.getStringList("artists");
    //return artists!.map((v) => Artist.fromJson(json.decode(v))).toList();
    return artists;
  }

  Future<Album> getAlbum(String id) async {
    //final List<Album> albums = await getAlbums();
    for (final album in albums) {
      if (album.id == id) {
        return album;
      }
    }
    throw Exception("album not found");
  }

  Future<Artist> getArtist(String id) async {
    //final List<Artist> artists = await getArtists();
    for (final artist in artists) {
      if (artist.id == id) {
        return artist;
      }
    }
    throw Exception("artist not found");
  }

  Future<Playlist> getPlaylist(String id) async {
    //final List<Playlist> playlists = await getPlaylists();
    for (final playlist in playlists) {
      if (playlist.id == id) {
        return playlist;
      }
    }
    throw Exception("playlist not found");
  }

  Future<Song> getSong(String id) async {
    //final List<Song> songs = await getSongs();
    for (final song in songs) {
      if (song.id == id) {
        return song;
      }
    }
    throw Exception("song not found");
  }
}
