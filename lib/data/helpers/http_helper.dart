import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:k19_player/data/constants.dart';
import 'package:crypto/crypto.dart';

class HttpHelper {
  Future<Map<String, dynamic>> get(String endpoint,
      [Map<String, dynamic>? pbody]) async {
    String url = buildUrl(endpoint, pbody);
    Response r = await http.get(Uri.parse(url));
    if (r.statusCode == 200) {
      return jsonDecode(r.body)["subsonic-response"];
    } else {
      throw Exception("Request failed");
    }
  }

  static String getStream(String id) {
    return buildUrl("stream", {'id': id});
  }

  static String buildUrl(String endpoint, [Map<String, dynamic>? pbody]) {
    String url = "$urlServer/rest/$endpoint";
    Map<String, dynamic> body = {
      'u': userSubsonic,
      't': md5.convert(utf8.encode(passwordSubsonic + saltSubsonic)).toString(),
      's': saltSubsonic,
      "v": versionSubsonic,
      "c": appnameSubsonic,
      "f": "json"
    };
    body = pbody != null ? {...body, ...pbody} : body;
    return "$url?${body.entries.map((v) => "${v.key}=${v.value}").join("&")}";
  }
}
