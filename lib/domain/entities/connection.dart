import 'package:crypto/crypto.dart';
import 'dart:convert';

class Connection {
  final String url;
  final String username;
  final String passwordHash;
  final String salt;
  final String version;
  final String appname;

  Connection(this.url, this.username, String password, this.salt, this.version,
      this.appname)
      : passwordHash = _hashPassword(password, salt);

  Connection.withPasswordHash(this.url, this.username, this.passwordHash,
      this.salt, this.version, this.appname);

  static String _hashPassword(String password, String salt) {
    return md5.convert(utf8.encode(password + salt)).toString();
  }

  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection.withPasswordHash(json["url"], json["username"],
        json["passwordHash"], json["salt"], json["version"], json["appname"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "username": username,
      "passwordHash": passwordHash,
      "salt": salt,
      "version": version,
      "appname": appname,
    };
  }
}
