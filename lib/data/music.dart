import 'package:k19_player/data/helpers/http_helper.dart';
import 'package:k19_player/data/repositories/db_repository.dart';
import 'package:k19_player/data/repositories/subsonic_repository.dart';
import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';

class Music {
  static Music? _instance;
  DbRepository dbRepository = DbRepository.instance;
  SubsonicRepository subsonicRepository = SubsonicRepository();

  Music._();

  static Music get instance => _instance ??= Music._();

  Future<bool> checkCacheAvailable(String value) async {
    final lastUpdate = await dbRepository.getLastUpdate();
    if (lastUpdate.difference(DateTime.now()).inDays.abs() > 1 ||
        !await dbRepository.checkIfValueExist(value)) {
      refreshCache();
      return false;
    }
    return true;
  }

  Future<List<Song>> getRandomSongs() async {
    if (await checkCacheAvailable("songs")) {
      return dbRepository.getSongs();
    }
    return await subsonicRepository.getRandomSongs();
  }

  Future<List<Playlist>> getPlaylists() async {
    if (await checkCacheAvailable("playlists")) {
      return dbRepository.getPlaylists();
    }
    return subsonicRepository.getPlaylists();
  }

  Future<List<Album>> getAlbums() async {
    if (await checkCacheAvailable("albums")) {
      return dbRepository.getAlbums();
    }
    return subsonicRepository.getAlbums();
  }

  Future<List<Artist>> getArtists() async {
    if (await checkCacheAvailable("artists")) {
      return dbRepository.getArtists();
    }
    return subsonicRepository.getArtists();
  }

  Future<Playlist> getPlaylist(String id) async {
    if (await checkCacheAvailable("playlists")) {
      return dbRepository.getPlaylist(id);
    }
    return subsonicRepository.getPlaylist(id);
  }

  Future<Artist> getArtist(String id) async {
    if (await checkCacheAvailable("artists")) {
      return dbRepository.getArtist(id);
    }
    return subsonicRepository.getArtist(id);
  }

  Future<Album> getAlbum(String id) async {
    if (await checkCacheAvailable("albums")) {
      return dbRepository.getAlbum(id);
    }
    return subsonicRepository.getAlbum(id);
  }

  Future refreshCache() async {
    List<Artist> artists = await subsonicRepository.getArtists();
    List<Album> albums = await subsonicRepository.getAlbums();
    List<Playlist> playlists = await subsonicRepository.getPlaylists();
    // List<Song> songs = await subsonicRepository.getAllSongs();

    await dbRepository.setArtists(artists);
    await dbRepository.setAlbums(albums);
    await dbRepository.setPlaylist(playlists);
    // await dbRepository.setSongs(songs);
    await dbRepository.setLastUpdate(DateTime.now());
  }

  savePref(String username, String password, String hostname) {
    print("Saved pref $username, $password, $hostname");
  }

  static Uri getSongUri(Song song) {
    return Uri.parse(HttpHelper.getStream(song.id));
  }

  static Uri getSongCover(Song song) {
    return Uri.parse(HttpHelper.buildUrl("getCoverArt", {"id": song.coverArt}));
  }

  static Uri getAlbumCover(Album album) {
    return Uri.parse(HttpHelper.buildUrl("getCoverArt", {"id": album.coverArt}));
  }

  static Uri getPlaylistCover(Playlist playlist) {
    return Uri.parse(HttpHelper.buildUrl("getCoverArt", {"id": playlist.coverArt}));
  }
}
