import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MediaStorage {
  static Future saveImage(Uri url, String name) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    http.Response response = await http.get(url);

    File img = File("${documentsDirectory.path}/$name");
    await img.writeAsBytes(response.bodyBytes);
  }

  static Future<Uri> getImage(String name) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File img = File("${documentsDirectory.path}/$name");
    return img.uri;
  }
}
