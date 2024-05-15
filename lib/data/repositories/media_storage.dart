import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
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

  static Future<bool> isImage(File file) async {
    try {
      Uint8List bytes = await file.readAsBytes();
      img.Image? decodedImage = img.decodeImage(bytes);
      return decodedImage != null;
    } catch (e) {
      return false; // Error occurred during decoding
    }
  }

  static Future<Uri> getImage(String name) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File img = File("${documentsDirectory.path}/$name");

    if (await img.exists()) {
      bool isImageFile = await isImage(img);
      if (isImageFile) {
        return img.uri;
      } else {
        throw Exception("File is not a valid image");
      }
    }
    throw Exception("Error during file retrieval");
  }
}
