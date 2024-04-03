import 'package:flutter_test/flutter_test.dart';
import 'package:k19_player/data/helpers/http_helper.dart';

void main() {
  group("HttpHelper.buildUrl", () {
    test("return a correct url for getRandomSongs", () {
      final result = HttpHelper.buildUrl("getRandomSongs");
      const target =
          "https://demo.navidrome.org/rest/getRandomSongs?u=demo&t=2e589a12a5e1ed3029ee09a0612d2f5b&s=salt&v=1.15.1&c=k19-player&f=json";

      expect(result, target);
    });
    test("return a correct url for getPlaylists", () {
      final result_1 = HttpHelper.buildUrl("getPlaylists");
      final result_2 =
          HttpHelper.buildUrl("getPlaylists", {"username": "test"});
      const target_1 =
          "https://demo.navidrome.org/rest/getPlaylists?u=demo&t=2e589a12a5e1ed3029ee09a0612d2f5b&s=salt&v=1.15.1&c=k19-player&f=json";
      const target_2 = "$target_1&username=test";

      expect(result_1, target_1);
      expect(result_2, target_2);
    });

    test("return a correct url for getAlbums", () {
      final result_1 = HttpHelper.buildUrl("getAlbumList", {"type": "random"});
      final result_2 =
          HttpHelper.buildUrl("getAlbumList", {"type": "random", "size": 42});
      const target_1 =
          "https://demo.navidrome.org/rest/getAlbumList?u=demo&t=2e589a12a5e1ed3029ee09a0612d2f5b&s=salt&v=1.15.1&c=k19-player&f=json&type=random";
      const target_2 = "$target_1&size=42";

      expect(result_1, target_1);
      expect(result_2, target_2);
    });
  });
}
