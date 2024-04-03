import 'package:flutter_test/flutter_test.dart';
import 'package:k19_player/data/helpers/http_helper.dart';
import 'package:k19_player/data/repositories/subsonic_repository.dart';
import 'package:k19_player/domain/entities/album.dart';
import 'package:k19_player/domain/entities/artist.dart';
import 'package:k19_player/domain/entities/playlist.dart';
import 'package:k19_player/domain/entities/song.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'response_api.dart';
import 'subsonic_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpHelper>()])
void main() {
  late SubsonicRepository subsonicRepository;
  late MockHttpHelper mockHttpHelper;

  setUpAll(() {
    mockHttpHelper = MockHttpHelper();
    subsonicRepository = SubsonicRepository(httpHelper: mockHttpHelper);

    when(mockHttpHelper.get("getRandomSongs")).thenAnswer((_) async {
      return responseGetRandomSongs;
    });
    when(mockHttpHelper.get("getPlaylists", {"username": null}))
        .thenAnswer((_) async {
      return responseGetPlaylists;
    });
    when(mockHttpHelper.get("getPlaylists", {"username": "test"}))
        .thenAnswer((_) async {
      return responseGetPlaylists;
    });
    when(mockHttpHelper.get("getAlbumList", {"type": "random"}))
        .thenAnswer((_) async {
      return responseGetAlbums;
    });
    when(mockHttpHelper.get("getArtists")).thenAnswer((_) async {
      return responseGetArtists;
    });
    when(mockHttpHelper.get("getPlaylist", {"id": "800000075"}))
        .thenAnswer((_) async {
      return responseGetPlaylist;
    });
    when(mockHttpHelper.get("getMusicDirectory", {"id": "music"}))
        .thenAnswer((_) async {
      return responseGetAllSongs;
    });
    when(mockHttpHelper.get("getArtist", {"id": "100000002"}))
        .thenAnswer((_) async {
      return responseGetArtist;
    });
    when(mockHttpHelper.get("getAlbum", {"id": "200000021"}))
        .thenAnswer((_) async {
      return responseGetAlbum;
    });
    when(mockHttpHelper
            .get("getSong", {"id": "191c92ba5a4d9aea628802033a9c0503"}))
        .thenAnswer((_) async {
      return responseGetSong;
    });
  });

  group("getRandomSongs", () {
    test("getRandomSongs", () async {
      final result = await subsonicRepository.getRandomSongs();
      List<Song> target = [
        Song(id: "300000060", albumId: "200000002", duration: 304),
        Song(id: "300000055", albumId: "200000002", duration: 400)
      ];

      verify(mockHttpHelper.get("getRandomSongs"));

      expect(result, isA<List<Song>>());
      expect(result.map((v) => v.toJson()).toList(),
          target.map((v) => v.toJson()).toList());
    });
  });
  group("getPlaylists", () {
    test("returns a list of playlist", () async {
      final result = await subsonicRepository.getPlaylists(username: null);

      verify(mockHttpHelper.get("getPlaylists", {"username": null}));

      expect(result, isA<List<Playlist>>());
    });

    test("returns a list of playlist with username", () async {
      final result = await subsonicRepository.getPlaylists(username: "test");

      verify(mockHttpHelper.get("getPlaylists", {"username": "test"}));

      expect(result, isA<List<Playlist>>());
    });
  });
  group("getAlbums", () {
    test("getAlbums", () async {
      final result = await subsonicRepository.getAlbums();

      verify(mockHttpHelper.get("getAlbumList", {"type": "random"}));

      expect(result, isA<List<Album>>());
    });
  });
  group("getArtists", () {
    test("getArtists", () async {
      final result = await subsonicRepository.getArtists();

      verify(mockHttpHelper.get("getArtists"));
      expect(result, isA<List<Artist>>());
      expect(result.length, 3);
    });
  });
  group("getPlaylist", () {
    test("getPlaylist", () async {
      final result = await subsonicRepository.getPlaylist("800000075");

      verify(mockHttpHelper.get("getPlaylist", {"id": "800000075"}));

      expect(result, isA<Playlist>());
    });
  });
  group("getAllSongs", () {
    test("getAllSongs", () async {
      final result = await subsonicRepository.getAllSongs();

      verify(mockHttpHelper.get("getMusicDirectory", {"id": "music"}));

      expect(result, isA<List<Song>>());
    });
  });
  group("getArtist", () {
    test("getArtist", () async {
      final result = await subsonicRepository.getArtist("100000002");

      verify(mockHttpHelper.get("getArtist", {"id": "100000002"}));

      expect(result, isA<Artist>());
    });
  });
  group("getAlbum", () {
    test("getAlbum", () async {
      final result = await subsonicRepository.getAlbum("200000021");

      verify(mockHttpHelper.get("getAlbum", {"id": "200000021"}));

      expect(result, isA<Album>());
    });
  });
  group("getSong", () {
    test("getSong", () async {
      final result =
          await subsonicRepository.getSong("191c92ba5a4d9aea628802033a9c0503");

      verify(mockHttpHelper
          .get("getSong", {"id": "191c92ba5a4d9aea628802033a9c0503"}));

      expect(result, isA<Song>());
    });
  });
}
