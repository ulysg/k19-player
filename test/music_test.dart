import 'package:flutter_test/flutter_test.dart';
import 'package:k19_player/data/music.dart';
import 'package:k19_player/data/repositories/db_repository.dart';
import 'package:k19_player/data/repositories/subsonic_repository.dart';
import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'music_test.mocks.dart';
import 'response_api.dart';

@GenerateNiceMocks([MockSpec<SubsonicRepository>(), MockSpec<DbRepository>()])
void main() {
  late Music music;
  late MockSubsonicRepository mockSubsonicRepository;
  late MockDbRepository mockDbRepository;

  setUpAll(() {
    mockSubsonicRepository = MockSubsonicRepository();
    mockDbRepository = MockDbRepository();
    music = Music.instance;
    music.subsonicRepository = mockSubsonicRepository;
    music.dbRepository = mockDbRepository;
  });

  group("_checkCacheAvailabe", () {
    test("should return true if cache is available", () async {
      when(mockDbRepository.getLastUpdate())
          .thenAnswer((_) => Future.value(DateTime.now()));
      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(true));

      final result = await music.checkCacheAvailable("songs");

      expect(result, true);
    });

    test("should return false if cache is outdated", () async {
      when(mockDbRepository.getLastUpdate())
          .thenAnswer((_) => Future.value(DateTime(1990)));
      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(true));

      final result = await music.checkCacheAvailable("songs");

      expect(result, false);
    });

    test("should return false if cache is empty", () async {
      when(mockDbRepository.getLastUpdate())
          .thenAnswer((_) => Future.value(DateTime.now()));
      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(false));

      final result = await music.checkCacheAvailable("songs");

      expect(result, false);
    });

    test("should return false if cache is empty and outdated", () async {
      when(mockDbRepository.getLastUpdate())
          .thenAnswer((_) => Future.value(DateTime(1990)));
      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(false));

      final result = await music.checkCacheAvailable("songs");

      expect(result, false);
    });
  });

  group("getRandomSongs", () {
    late List<Song> songs;
    setUpAll(() {
      songs = [
        Song(id: '1', albumId: "a", title: 'Song 1', duration: 2),
        Song(id: '2', albumId: "b", title: 'Song 2', duration: 2),
        Song(id: '3', albumId: "a", title: 'Song 3', duration: 1),
      ];
    });
    test("should return a list of songs with a cache", () async {
      when(mockDbRepository.getLastUpdate())
          .thenAnswer((_) => Future.value(DateTime.now()));
      when(mockDbRepository.getSongs())
          .thenAnswer((_) => Future.value([songs[0], songs[2]]));
      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(true));

      final result = await music.getRandomSongs();
      verifyNever(mockSubsonicRepository.getRandomSongs());

      expect(result, isA<List<Song>>());
      expect(result.length, 2);
      expect(result[0].title, songs[0].title);
      expect(result[1].title, songs[2].title);
    });
    test("should return a list of songs with a cache outdated", () async {
      when(mockSubsonicRepository.getRandomSongs())
          .thenAnswer((_) => Future.value(songs));
      when(mockDbRepository.getLastUpdate())
          .thenAnswer((_) => Future.value(DateTime(1990)));
      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(true));

      final result = await music.getRandomSongs();
      verify(mockSubsonicRepository.getRandomSongs()).called(1);

      expect(result, isA<List<Song>>());
      expect(result.length, songs.length);
      expect(result[0].title, songs[0].title);
      expect(result[1].title, songs[1].title);
      expect(result[2].title, songs[2].title);
    });
    test("should return a list of songs with an empty cache", () async {
      when(mockSubsonicRepository.getRandomSongs())
          .thenAnswer((_) => Future.value(songs));
      when(mockDbRepository.getLastUpdate())
          .thenAnswer((_) => Future.value(DateTime.now()));
      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(false));

      final result = await music.getRandomSongs();

      expect(result, isA<List<Song>>());
      expect(result.length, songs.length);
      expect(result[0].title, songs[0].title);
      expect(result[1].title, songs[1].title);
      expect(result[2].title, songs[2].title);
    });

    test(
        "should return a list of songs with an empty cache and recall to use cache",
        () async {
      when(mockSubsonicRepository.getRandomSongs())
          .thenAnswer((_) => Future.value(songs));
      when(mockDbRepository.getLastUpdate())
          .thenAnswer((_) => Future.value(DateTime.now()));
      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(false));
      when(mockDbRepository.getSongs())
          .thenAnswer((_) => Future.value([songs[0], songs[2]]));

      // Cache isn't available
      final result = await music.getRandomSongs();

      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(true));
      // Cache is available
      final resultCache = await music.getRandomSongs();

      when(mockDbRepository.checkIfValueExist("songs"))
          .thenAnswer((_) => Future.value(false));

      // Cache isn't available
      final result2 = await music.getRandomSongs();

      expect(result, isA<List<Song>>());
      expect(resultCache, isA<List<Song>>());
      expect(result.length, songs.length);
      expect(resultCache.length, 2);
      expect(result2.length, 3);
      expect(result[0].title, songs[0].title);
      expect(result[1].title, songs[1].title);
      expect(result[2].title, songs[2].title);
    });
  });
  // group("other", () {
  //   test("getPlaylists method should return a list of playlists", () async {
  //     final List<Playlist> playlists = List<Playlist>.from(
  //         responseGetPlaylists["playlists"]["playlist"]
  //             .map((v) => Playlist.fromJson(v)));
  //     when(mockSubsonicRepository.getPlaylists())
  //         .thenAnswer((_) => Future.value(playlists));

  //     final result = await music.getPlaylists();
  //     verify(mockSubsonicRepository.getPlaylists()).called(1);
  //     expect(result, isA<List<Playlist>>());
  //     expect(result.length, playlists.length);
  //   });

  //   test("getAlbums method should return a list of albums", () async {
  //     final List<Album> target = List<Album>.from(responseGetAlbums["albumList"]
  //             ["album"]
  //         .map((v) => Album.fromJson(v)));
  //     when(mockSubsonicRepository.getAlbums())
  //         .thenAnswer((_) => Future.value(target));

  //     final result = await music.getAlbums();
  //     verify(mockSubsonicRepository.getAlbums()).called(1);
  //     expect(result, isA<List<Album>>());
  //     expect(result.length, target.length);
  //   });
  //   test("getArtists method should return a list of artists", () async {
  //     final indexList = responseGetArtists["artists"]["index"];
  //     final List<Artist> target = [];

  //     for (final indexEntry in indexList) {
  //       final List<dynamic> artists = indexEntry["artist"];
  //       for (final artistData in artists) {
  //         final Artist artist = Artist.fromJson(artistData);
  //         target.add(artist);
  //       }
  //     }
  //     when(mockSubsonicRepository.getArtists())
  //         .thenAnswer((_) => Future.value(target));

  //     final result = await music.getArtists();
  //     verify(mockSubsonicRepository.getArtists()).called(1);
  //     expect(result, isA<List<Artist>>());
  //   });
  //   test("getPlaylist method should return a playlist", () async {
  //     final Playlist target =
  //         Playlist.fromJson(responseGetPlaylist["playlist"]);
  //     when(mockSubsonicRepository.getPlaylist("id"))
  //         .thenAnswer((_) => Future.value(target));

  //     final result = await music.getPlaylist("id");
  //     verify(mockSubsonicRepository.getPlaylist("id")).called(1);
  //     expect(result, isA<Playlist>());
  //   });
  //   test("getArtist method should return a artist", () async {
  //     final Artist target = Artist.fromJson(responseGetArtist["artist"]);
  //     when(mockSubsonicRepository.getArtist("id"))
  //         .thenAnswer((_) => Future.value(target));

  //     final result = await music.getArtist("id");
  //     verify(mockSubsonicRepository.getArtist("id")).called(1);
  //     expect(result, isA<Artist>());
  //   });
  //   test("getAlbum method should return a album", () async {
  //     final Album target = Album.fromJson(responseGetAlbum["album"]);
  //     when(mockSubsonicRepository.getAlbum("id"))
  //         .thenAnswer((_) => Future.value(target));

  //     final result = await music.getAlbum("id");
  //     verify(mockSubsonicRepository.getAlbum("id")).called(1);
  //     expect(result, isA<Album>());
  //   });
  // });
}
