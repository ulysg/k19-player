import 'package:http/http.dart';
import 'package:k19_player/data/helpers/http_helper.dart';
import 'package:k19_player/data/helpers/tools.dart';
import 'package:k19_player/data/repositories/db_repository.dart';
import 'package:k19_player/data/repositories/media_storage.dart';
import 'package:k19_player/data/repositories/subsonic_repository.dart';
import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/connection.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';

class Music {
  static Music? _instance;
  DbRepository dbRepository = DbRepository.instance;
  SubsonicRepository subsonicRepository = SubsonicRepository();
  Connection? connection;

  Music._();

  static Music get instance => _instance ??= Music._();

  Future checkCacheAvailable(String value) async {
    if (connection == null) {
      await getActualConnection();
    }
    final lastUpdate = await dbRepository.getLastUpdate();
    if (lastUpdate.difference(DateTime.now()).inDays.abs() > 1 ||
        !await dbRepository.checkIfValueExist(value)) {
      await refreshCache();
    }
  }

  Future<Connection?> getActualConnection() async {
    return dbRepository.getActualConnection();
  }

  Future setActualConnection(String url, String username, String password) async {
    await dbRepository.setActualConnection(Connection("https://music.ulys.ch",
        "test", "password123", "yes", "1.15.1", "k19-player"));
  }

  Future<List<Song>> getRandomSongs() async {
    await checkCacheAvailable("songs");
    return dbRepository.getSongs();
  }

  Future<List<Song>> getSongs() async {
    await checkCacheAvailable("songs");
    return dbRepository.getSongs();
  }

  Future<List<Playlist>> getPlaylists() async {
    await checkCacheAvailable("playlists");
    return dbRepository.getPlaylists();
  }

  Future<List<Album>> getAlbums() async {
    await checkCacheAvailable("albums");
    return dbRepository.getAlbums();
  }

  Future<List<Artist>> getArtists() async {
    await checkCacheAvailable("artists");
    return dbRepository.getArtists();
  }

  Future<bool> ping() async {
    return subsonicRepository.ping();
  }

  Future clear() async {
    await dbRepository.clear();
  }

  Future refreshCache() async {
    if (connection == null) {
      await getActualConnection();
    }
    List<Album> albums =
        await subsonicRepository.fetchAll(subsonicRepository.albums, 0, 5000);
    List<Song> songs =
        await subsonicRepository.fetchAll(subsonicRepository.songs, 0, 5000);
    List<Artist> artists =
        await subsonicRepository.fetchAll(subsonicRepository.artists, 0, 5000);
    List<Playlist> playlists = await subsonicRepository.getPlaylistsFull();

    await dbRepository.setAlbums(Tools.mergeSongsIntoAlbum(songs, albums));
    await dbRepository.setArtists(Tools.mergeAlbumsIntoArtist(albums, artists));
    await dbRepository.setSongs(songs);
    await dbRepository.setPlaylist(playlists);
    await dbRepository.setLastUpdate(DateTime.now());
  }

  Uri getSongUri(Song song) {
    return Uri.parse(HttpHelper.getStream(song.id));
  }

  Uri getSongCoverHTTP(Song song) {
    return Uri.parse(HttpHelper.buildUrl("getCoverArt", {"id": song.coverArt}));
  }

  Future<Uri> getSongCover(Song song) async {
    try {
      return await MediaStorage.getImage(song.coverArt!);
    } catch (_) {
      await MediaStorage.saveImage(
          Uri.parse(HttpHelper.buildUrl("getCoverArt", {"id": song.coverArt})),
          song.coverArt!);
      return await MediaStorage.getImage(song.coverArt!);
    }
  }

  Future<Uri> getAlbumCover(Album album) async {
    try {
      return await MediaStorage.getImage(album.coverArt!);
    } catch (_) {
      await MediaStorage.saveImage(
          Uri.parse(HttpHelper.buildUrl("getCoverArt", {"id": album.coverArt})),
          album.coverArt!);
      return await MediaStorage.getImage(album.coverArt!);
    }
  }

  Future<Uri> getPlaylistCover(Playlist playlist) async {
    try {
      return await MediaStorage.getImage(playlist.coverArt!);
    } catch (_) {
      await MediaStorage.saveImage(
          Uri.parse(
              HttpHelper.buildUrl("getCoverArt", {"id": playlist.coverArt})),
          playlist.coverArt!);
      return await MediaStorage.getImage(playlist.coverArt!);
    }
  }
}
