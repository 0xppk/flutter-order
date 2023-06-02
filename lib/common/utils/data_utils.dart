import 'dart:convert';
import '../const/data.dart';

class DataUtils {
  static String pathToUrl(String path) {
    return "http://$ip$path";
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static Future<String> plainToBase64(String plain) async {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(plain);
    return encoded;
  }

  static DateTime stringToDateTime(String value) {
    return DateTime.parse(value);
  }
}
