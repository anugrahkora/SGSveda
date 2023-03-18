// To parse this JSON data, do
//
//     final uploadFileResponse = uploadFileResponseFromMap(jsonString);

import 'dart:convert';

UploadFileResponse uploadFileResponseFromMap(String str) =>
    UploadFileResponse.fromMap(json.decode(str));

String uploadFileResponseToMap(UploadFileResponse data) =>
    json.encode(data.toMap());

class UploadFileResponse {
  UploadFileResponse({
    required this.data,
  });

  final Data data;

  factory UploadFileResponse.fromMap(Map<String, dynamic> json) =>
      UploadFileResponse(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.id,
    required this.storage,
    required this.filenameDisk,
    required this.filenameDownload,
    required this.title,
    required this.type,
    this.folder,
    required this.uploadedBy,
    required this.uploadedOn,
    this.modifiedBy,
    required this.modifiedOn,
    this.charset,
    required this.filesize,
    this.width,
    this.height,
    this.duration,
    this.embed,
    this.description,
    this.location,
    this.tags,
    this.metadata,
  });

  final String id;
  final String storage;
  final String filenameDisk;
  final String filenameDownload;
  final String title;
  final String type;
  final dynamic folder;
  final String uploadedBy;
  final DateTime uploadedOn;
  final dynamic modifiedBy;
  final DateTime modifiedOn;
  final dynamic charset;
  final String filesize;
  final dynamic width;
  final dynamic height;
  final dynamic duration;
  final dynamic embed;
  final dynamic description;
  final dynamic location;
  final dynamic tags;
  final dynamic metadata;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        storage: json["storage"],
        filenameDisk: json["filename_disk"],
        filenameDownload: json["filename_download"],
        title: json["title"],
        type: json["type"],
        folder: json["folder"],
        uploadedBy: json["uploaded_by"],
        uploadedOn: DateTime.parse(json["uploaded_on"]),
        modifiedBy: json["modified_by"],
        modifiedOn: DateTime.parse(json["modified_on"]),
        charset: json["charset"],
        filesize: json["filesize"],
        width: json["width"],
        height: json["height"],
        duration: json["duration"],
        embed: json["embed"],
        description: json["description"],
        location: json["location"],
        tags: json["tags"],
        metadata: json["metadata"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "storage": storage,
        "filename_disk": filenameDisk,
        "filename_download": filenameDownload,
        "title": title,
        "type": type,
        "folder": folder,
        "uploaded_by": uploadedBy,
        "uploaded_on": uploadedOn.toIso8601String(),
        "modified_by": modifiedBy,
        "modified_on": modifiedOn.toIso8601String(),
        "charset": charset,
        "filesize": filesize,
        "width": width,
        "height": height,
        "duration": duration,
        "embed": embed,
        "description": description,
        "location": location,
        "tags": tags,
        "metadata": metadata,
      };
}
