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

  Future<List<Song>> getRandomSongs() async {
    final r = await _httpHelper.get("getRandomSongs");
    return _parseResponse<Song>(Song.fromJson, r, ["randomSongs", "song"]);
  }

  Future<List<Playlist>> getPlaylists({String? username}) async {
    final r = await _httpHelper.get("getPlaylists", {"username": username});
    return _parseResponse<Playlist>(
        Playlist.fromJson, r, ["playlists", "playlist"]);
  }

  Future<List<Album>> getAlbums() async {
    final r = await _httpHelper.get("getAlbumList", {"type": "random"});
    List<Album> albums =
        _parseResponse<Album>(Album.fromJson, r, ["albumList", "album"]);
    return await Future.wait(albums.map((v) async {
      return await getAlbum(v.id);
    }));
  }

  Future<List<Artist>> getArtists() async {
    final r = await _httpHelper.get("getArtists");
    if (r.containsKey("artists") && r["artists"].containsKey("index")) {
      final List<dynamic> indexList = r["artists"]["index"];
      return indexList
          .expand((v) => v["artist"])
          .map((v) => Artist.fromJson(v))
          .toList();
    }
    throw Exception("Error during parsing");
  }

  Future<Playlist> getPlaylist(String id) async {
    final r = await _httpHelper.get("getPlaylist", {"id": id});
    return Playlist.fromJson(r["playlist"]);
  }

  Future<List<Song>> getAllSongs() async {
    final r = await _httpHelper.get("getMusicDirectory", {"id": "music"});
    return _parseResponse<Song>(Song.fromJson, r, ["directory", "child"]);
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

  Future<String> getStream(Song song) async {
    return Future(() => HttpHelper.getStream(song.id));
  }
}
