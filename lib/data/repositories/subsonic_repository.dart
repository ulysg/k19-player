import 'package:k19_player/data/helpers/http_helper.dart';
import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';

class SubsonicRepository {
  static SubsonicRepository? _instance;
  final HttpHelper _httpHelper;
  SubsonicRepository._(this._httpHelper);

  factory SubsonicRepository({HttpHelper? httpHelper}) {
    if (_instance == null) {
      if (httpHelper == null) {
        _instance = SubsonicRepository._(HttpHelper());
      } else {
        _instance = SubsonicRepository._(httpHelper);
      }
    }
    return _instance!;
  }

  List<T> _parseResponse<T>(T Function(Map<String, dynamic> json) fromJson,
      Map<String, dynamic> r, List<String> parentKeys) {
    dynamic result = r;
    for (var key in parentKeys) {
      if (result.containsKey(key)) {
        result = result[key];
      } else {
        throw Exception("Error during parsing");
      }
    }
    if (result is List) {
      return result.map((v) => fromJson(v)).toList();
    } else {
      throw Exception("Error during parsing");
    }
  }

  Future<List<T>> fetchAll<T>(
      Future<List<T>> Function({int size, int offset}) fnc,
      int counter,
      int batchSize) async {
    List<T> buffer, result = [];
    int counter = 0;

    buffer = await fnc(size: batchSize, offset: counter);
    while (buffer.isNotEmpty) {
      counter += batchSize;
      result.addAll(buffer);
      buffer = await fnc(size: batchSize, offset: counter);
    }

    return result;
  }

  Future<List<Song>> getRandomSongs() async {
    final r = await _httpHelper.get("getRandomSongs");
    return _parseResponse<Song>(Song.fromJson, r, ["randomSongs", "song"]);
  }

  Future<List<Playlist>> getPlaylists({String? username}) async {
    final r = await _httpHelper.get("getPlaylists", {"username": username});
    return _parseResponse<Playlist>(
        Playlist.fromJson, r, ["playlists", "playlist"]);
  }

  Future<List<Playlist>> getPlaylistsFull({String? username}) async {
    final r = await _httpHelper.get("getPlaylists", {"username": username});
    List<Playlist> playlists = _parseResponse<Playlist>(
        Playlist.fromJson, r, ["playlists", "playlist"]);
    return await Future.wait(playlists.map((v) async {
      return await getPlaylist(v.id);
    }));
  }

  Future<Playlist> getPlaylist(String id) async {
    final r = await _httpHelper.get("getPlaylist", {"id": id});
    return Playlist.fromJson(r["playlist"]);
  }

  Future<List<Song>> songs({int size = 20, int offset = 0}) async {
    try {
      return _parseResponse(
          Song.fromJson,
          await _httpHelper.get("search3", {
            "artistCount": 0,
            "albumCount": 0,
            "songCount": size,
            "songOffset": offset
          }),
          ["searchResult3", "song"]);
    } catch (e) {
      return [];
    }
  }

  Future<List<Album>> albums({int size = 20, int offset = 0}) async {
    try {
      return _parseResponse(
          Album.fromJson,
          await _httpHelper.get("search3", {
            "artistCount": 0,
            "albumCount": size,
            "albumOffset": offset,
            "songCount": 0
          }),
          ["searchResult3", "album"]);
    } catch (e) {
      return [];
    }
  }

  Future<List<Artist>> artists({int size = 20, int offset = 0}) async {
    try {
      return _parseResponse(
          Artist.fromJson,
          await _httpHelper.get("search3", {
            "artistCount": size,
            "artistOffset": offset,
            "albumCount": 0,
            "songCount": 0
          }),
          ["searchResult3", "artist"]);
    } catch (e) {
      return [];
    }
  }

  Future<Artist> getArtist(String id) async {
    final r = await _httpHelper.get("getArtist", {"id": id});
    return Artist.fromJson(r["artist"]);
  }

  Future<Album> getAlbum(String id) async {
    final r = await _httpHelper.get("getAlbum", {"id": id});
    return Album.fromJson(r["album"]);
  }

  Future<Song> getSong(String id) async {
    final r = await _httpHelper.get("getSong", {"id": id});
    return Song.fromJson(r["song"]);
  }

  Future<bool> ping() async {
    try {
      await _httpHelper.get("ping");
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getStream(Song song) async {
    return Future(() => HttpHelper.getStream(song.id));
  }
}
