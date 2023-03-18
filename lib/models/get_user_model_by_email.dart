// To parse this JSON data, do
//
//     final getUserModelByEmail = getUserModelByEmailFromMap(jsonString);

import 'dart:convert';

import 'package:veda_nidhi_v2/models/user_model.dart';

GetUserModelByEmail getUserModelByEmailFromMap(String str) =>
    GetUserModelByEmail.fromMap(json.decode(str));

String getUserModelByEmailToMap(GetUserModelByEmail data) =>
    json.encode(data.toMap());

class GetUserModelByEmail {
  GetUserModelByEmail({
    required this.data,
  });

  final List<UserModel> data;

  factory GetUserModelByEmail.fromMap(Map<String, dynamic> json) =>
      GetUserModelByEmail(
        data:
            List<UserModel>.from(json["data"].map((x) => UserModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}
