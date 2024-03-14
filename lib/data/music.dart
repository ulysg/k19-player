import 'package:k19_player/data/repositories/subsonic_repository.dart';
import 'package:k19_player/domain/entities/song.dart';
import 'package:tuple/tuple.dart';

class Music {
  static Music? _instance;
  Music._();

  static Music get instance => _instance ??= Music._();

  SubsonicRepository subsonicRepository = SubsonicRepository.instance;

  Future<Tuple2<String, Song>> getRandomSong() async {
    List<Song> song = await subsonicRepository.getRandomSongs();
    return Tuple2(await subsonicRepository.getStream(song[0]), song[0]);
  }
}
