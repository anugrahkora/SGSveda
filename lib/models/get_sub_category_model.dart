// To parse this JSON data, do
//
//     final getSubCategoryModel = getSubCategoryModelFromMap(jsonString);

import 'dart:convert';

GetSubCategoryModel getSubCategoryModelFromMap(String str) =>
    GetSubCategoryModel.fromMap(json.decode(str));

String getSubCategoryModelToMap(GetSubCategoryModel data) =>
    json.encode(data.toMap());

class GetSubCategoryModel {
  GetSubCategoryModel({
    required this.data,
  });

  final List<SubCategory> data;

  factory GetSubCategoryModel.fromMap(Map<String, dynamic> json) =>
      GetSubCategoryModel(
        data: List<SubCategory>.from(json["data"].map((x) => SubCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class SubCategory {
  SubCategory({
    required this.categories,
    required this.dateCreated,
    this.dateUpdated,
    required this.id,
    required this.image,
    required this.name,
    this.sort,
    required this.status,
    required this.userCreated,
    this.userUpdated,
    required this.rank,
  });

  final String? categories;
  final DateTime dateCreated;
  final dynamic dateUpdated;
  final String id;
  final String? image;
  final String? name;
  final dynamic sort;
  final String? status;
  final String? userCreated;
  final String? userUpdated;
  final int? rank;

  factory SubCategory.fromMap(Map<String, dynamic> json) => SubCategory(
        categories: json["categories"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateUpdated: json["date_updated"],
        id: json["id"],
        image: json["image"],
        name: json["name"],
        sort: json["sort"],
        status: json["status"],
        userCreated: json["user_created"],
        userUpdated: json["user_updated"],
        rank: json["rank"],
      );

  Map<String, dynamic> toMap() => {
        "categories": categories,
        "date_created": dateCreated.toIso8601String(),
        "date_updated": dateUpdated,
        "id": id,
        "image": image,
        "name": name,
        "sort": sort,
        "status": status,
        "user_created": userCreated,
        "user_updated": userUpdated,
        "rank": rank,
      };
}
