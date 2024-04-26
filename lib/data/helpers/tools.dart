import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/song.dart';

class Tools {
  static List<T> getFirstXItems<T>(List<T> items, int x) {
    if (x == -1) {
      return items;
    } else {
      return items.sublist(0, x);
    }
  }

  static List<Album> mergeSongsIntoAlbum(List<Song> songs, List<Album> albums) {
    final List<Album> result = [...albums];
    for (var album in result) {
      album.song.addAll(songs.where((song) => song.albumId == album.id));
    }
    return result;
  }

  static List<Artist> mergeAlbumsIntoArtist(
      List<Album> albums, List<Artist> artists) {
    final List<Artist> result = [...artists];
    for (var artist in result) {
      artist.album.addAll(albums.where((album) => album.artistId == artist.id));
    }
    return result;
  }
}
