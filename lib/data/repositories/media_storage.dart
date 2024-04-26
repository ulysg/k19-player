import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MediaStorage {
  static Future saveImage(Uri url, String name) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File img = File("${documentsDirectory.path}/$name");

    if (await img.exists()) {
      return;
    }
    http.Response response = await http.get(url);
    await img.writeAsBytes(response.bodyBytes);
  }

  static Future<Uri> getImage(String name) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File img = File("${documentsDirectory.path}/$name");

    if (await img.exists()) {
      return img.uri;
    }
    throw Exception("Error during file retrieval");
  }
}
