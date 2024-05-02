import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:k19_player/data/music.dart';
import 'package:k19_player/domain/entities/connection.dart';

class HttpHelper {
  Future<Map<String, dynamic>> get(String endpoint,
      [Map<String, dynamic>? pbody]) async {
    String url = buildUrl(endpoint, pbody);
    Response r = await http.get(Uri.parse(url));
    if (r.statusCode == 200) {
      return jsonDecode(utf8.decode(r.bodyBytes))["subsonic-response"];
    } else {
      throw Exception("Request failed");
    }
  }

  static String getStream(String id) {
    return buildUrl("stream", {'id': id});
  }

  static String buildUrl(String endpoint, [Map<String, dynamic>? pbody]) {
    if (Music.instance.connection == null) {
      throw Exception("Connection not established");
    }
    Connection connection = Music.instance.connection!;
    String urlServer = connection.url;
    String url = "$urlServer/rest/$endpoint";
    Map<String, dynamic> body = {
      'u': connection.username,
      't': connection.passwordHash,
      's': connection.salt,
      "v": connection.version,
      "c": connection.appname,
      "f": "json"
    };
    body = pbody != null ? {...body, ...pbody} : body;
    return "$url?${body.entries.map((v) => "${v.key}=${v.value}").join("&")}";
  }
}
