import 'package:k19_player/data/helpers/http_helper.dart';
import 'package:k19_player/data/repositories/subsonic_repository.dart';
import 'package:k19_player/domain/entities/song.dart';

class Music {
  static Music? _instance;
  Music._();

  static Music get instance => _instance ??= Music._();

  SubsonicRepository subsonicRepository = SubsonicRepository.instance;

  Future<List<Song>> getRandomSongs() async {
    return await subsonicRepository.getRandomSongs();
  }

  static Uri getSongUri(Song song) {
    return Uri.parse(HttpHelper.getStream(song.id));
  }

  static Uri getCoverUri(Song song) {
    return Uri.parse(HttpHelper.buildUrl("getCoverArt", {"id": song.coverArt}));
  }
}
