// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromMap(jsonString);

import 'dart:convert';

GetCategoryModel getCategoryModelFromMap(String str) =>
    GetCategoryModel.fromMap(json.decode(str));

String getCategoryModelToMap(GetCategoryModel data) =>
    json.encode(data.toMap());

class GetCategoryModel {
  GetCategoryModel({
    required this.data,
  });

  final List<Category> data;

  factory GetCategoryModel.fromMap(Map<String, dynamic> json) =>
      GetCategoryModel(
        data: List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}


Category getCategoryFromMap(String str) =>
    Category.fromMap(json.decode(str));



class Category {
  Category({
    required this.dateCreated,
    this.dateUpdated,
    required this.id,
    required this.image,
    required this.name,
    this.sort,
    required this.status,
    required this.userCreated,
    this.userUpdated,
  });

  final DateTime dateCreated;
  final dynamic dateUpdated;
  final String id;
  final String? image;
  final String? name;
  final String? sort;
  final String? status;
  final String? userCreated;
  final dynamic userUpdated;

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        dateCreated: DateTime.parse(json["date_created"]),
        dateUpdated: json["date_updated"],
        id: json["id"],
        image: json["image"],
        name: json["name"],
        sort: json["sort"],
        status: json["status"],
        userCreated: json["user_created"],
        userUpdated: json["user_updated"],
      );

  Map<String, dynamic> toMap() => {
        "date_created": dateCreated.toIso8601String(),
        "date_updated": dateUpdated,
        "id": id,
        "image": image,
        "name": name,
        "sort": sort,
        "status": status,
        "user_created": userCreated,
        "user_updated": userUpdated,
      };
}
