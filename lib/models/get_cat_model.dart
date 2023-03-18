// To parse this JSON data, do
//
//     final getCatModel = getCatModelFromMap(jsonString);

import 'dart:convert';

import 'package:veda_nidhi_v2/models/category_model.dart';

GetCatModel getCatModelFromMap(String str) =>
    GetCatModel.fromMap(json.decode(str));

String getCatModelToMap(GetCatModel data) => json.encode(data.toMap());

class GetCatModel {
  GetCatModel({
    required this.data,
  });

  final Category data;

  factory GetCatModel.fromMap(Map<String, dynamic> json) => GetCatModel(
        data: Category.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

