// To parse this JSON data, do
//
//     final getAboutUsModel = getAboutUsModelFromMap(jsonString);

import 'dart:convert';

GetAboutUsModel getAboutUsModelFromMap(String str) =>
    GetAboutUsModel.fromMap(json.decode(str));

String getAboutUsModelToMap(GetAboutUsModel data) =>
    json.encode(data.toMap());

class GetAboutUsModel {
  GetAboutUsModel({
    required this.data,
  });

  final Data data;

  factory GetAboutUsModel.fromMap(Map<String, dynamic> json) =>
      GetAboutUsModel(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.id,
    required this.status,
    required this.userCreated,
    required this.dateCreated,
    required this.userUpdated,
    required this.dateUpdated,
    required this.aboutBookApp,
    required this.totalTemple,
    required this.totalSaints,
    required this.whoWeAre,
    required this.ourMission,
    required this.banners,
  });

  final String id;
  final String status;
  final String userCreated;
  final DateTime dateCreated;
  final String userUpdated;
  final DateTime dateUpdated;
  final String aboutBookApp;
  final String totalTemple;
  final String totalSaints;
  final String whoWeAre;
  final String ourMission;
  final List<Banner> banners;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        status: json["status"],
        userCreated: json["user_created"],
        dateCreated: DateTime.parse(json["date_created"]),
        userUpdated: json["user_updated"],
        dateUpdated: DateTime.parse(json["date_updated"]),
        aboutBookApp: json["about_book_app"],
        totalTemple: json["total_temple"],
        totalSaints: json["total_saints"],
        whoWeAre: json["who_we_are"],
        ourMission: json["our_mission"],
        banners:
            List<Banner>.from(json["banners"].map((x) => Banner.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "user_created": userCreated,
        "date_created": dateCreated.toIso8601String(),
        "user_updated": userUpdated,
        "date_updated": dateUpdated.toIso8601String(),
        "about_book_app": aboutBookApp,
        "total_temple": totalTemple,
        "total_saints": totalSaints,
        "who_we_are": whoWeAre,
        "our_mission": ourMission,
        "banners": List<dynamic>.from(banners.map((x) => x.toMap())),
      };
}

class Banner {
  Banner({
    required this.directusFilesId,
  });

  final String directusFilesId;

  factory Banner.fromMap(Map<String, dynamic> json) => Banner(
        directusFilesId: json["directus_files_id"],
      );

  Map<String, dynamic> toMap() => {
        "directus_files_id": directusFilesId,
      };
}
