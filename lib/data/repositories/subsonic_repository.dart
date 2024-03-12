import 'package:k19_player/data/helpers/http_helper.dart';
import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';

class SubsonicRepository {
  static SubsonicRepository? _instance;
  SubsonicRepository._();

  static SubsonicRepository get instance =>
      _instance ??= SubsonicRepository._();

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
    final r = await HttpHelper.get("getRandomSongs");
    return _parseResponse<Song>(Song.fromJson, r, ["randomSongs", "song"]);
  }

  Future<List<Playlist>> getPlaylists() async {
    final r = await HttpHelper.get("getPlaylists");
    return _parseResponse<Playlist>(Playlist.fromJson, r, ["playlists"]);
  }

  Future<List<Album>> getAlbums() async {
    final r = await HttpHelper.get("getAlbums");
    return _parseResponse<Album>(Album.fromJson, r, ["albumList"]);
  }

  Future<Playlist> getPlaylist(String id) async {
    final r = await HttpHelper.get("getPlaylist", {"id": id});
    return Playlist.fromJson(r);
  }

  Future<String> getStream(Song song) async {
    return Future(() => HttpHelper.getStream(song.id));
  }
}
