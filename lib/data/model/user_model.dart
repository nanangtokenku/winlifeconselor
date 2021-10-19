import 'package:winlife_conselor_flutter/data/model/conselor_model.dart';

class UserData {
  final String id;
  final String uid;
  final String email;
  final String username;
  final String fullName;
  final String banned;
  String token;
  final String avatar;
  final String point;
  Conselor? conselorData;

  UserData(
      {required this.id,
      required this.banned,
      required this.email,
      required this.fullName,
      required this.uid,
      required this.username,
      required this.token,
      required this.avatar,
      this.point = "0"});
  UserData.initial()
      : id = '',
        banned = '',
        email = '',
        fullName = '',
        uid = '',
        username = '',
        token = '',
        point = '0',
        avatar = '';

  factory UserData.fromJson(Map<String, dynamic> json, String token) {
    return UserData(
        id: json['id'],
        uid: json['uuid'],
        banned: json['banned'],
        email: json['email'],
        fullName: json['full_name'],
        username: json['username'],
        avatar: "https://picsum.photos/id/1005/367/267",
        token: token);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uuid': uid,
        'banned': banned,
        'email': email,
        'full_name': fullName,
        'username': username,
        'token': token,
        'avatar': avatar,
      };
}
