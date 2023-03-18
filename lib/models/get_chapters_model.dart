// To parse this JSON data, do
//
//     final getChaptersModel = getChaptersModelFromMap(jsonString);

import 'dart:convert';

GetChaptersModel getChaptersModelFromMap(String str) =>
    GetChaptersModel.fromMap(json.decode(str));

String getChaptersModelToMap(GetChaptersModel data) =>
    json.encode(data.toMap());

class GetChaptersModel {
  GetChaptersModel({
    required this.data,
  });

  final List<Chapter> data;

  factory GetChaptersModel.fromMap(Map<String, dynamic> json) =>
      GetChaptersModel(
        data: List<Chapter>.from(json["data"].map((x) => Chapter.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Chapter {
  Chapter( {
    required this.dateCreated,
    this.dateUpdated,
    required this.description,
    required this.id,
    this.sort,
    required this.status,
    required this.playableUrl,
    required this.name,
    required this.rank,
    required this.devanagariFile,
    required this.kannadaFile,
    required this.subCategories,
    required this.telugu,
    required this.userCreated,
    this.userUpdated,
    required this.image,
  });

  final DateTime dateCreated;
  final DateTime? dateUpdated;
  final String? description;
  final String id;
  final String? sort;
  final String? status;
  final String? playableUrl;
  final String? name;
  final int? rank;
  final PdfFile? devanagariFile;
  final PdfFile? kannadaFile;
  final SubCategories? subCategories;
  final PdfFile? telugu;
  final UserData userCreated;
  final UserData? userUpdated;
  final PdfFile? image;

  factory Chapter.fromMap(Map<String, dynamic> json) => Chapter(
        dateCreated: DateTime.parse(json["date_created"]),
        dateUpdated: json["date_updated"] == null
            ? null
            : DateTime.parse(json["date_updated"]),
        description: json["description"],
        id: json["id"],
        sort: json["sort"],
        status: json["status"],
        playableUrl: json["playable_url"],
        name: json["name"],
        rank: json["rank"],
        devanagariFile:json["devanagari_file"]==null?null: PdfFile.fromMap(json["devanagari_file"]),
        kannadaFile:json["kannada_file"]==null?null: PdfFile.fromMap(json["kannada_file"]),
        subCategories:json["sub_categories"]==null?null: SubCategories.fromMap(json["sub_categories"]),
        telugu:json["telugu"]==null?null: PdfFile.fromMap(json["telugu"]),
        userCreated: UserData.fromMap(json["user_created"]),
        userUpdated: json["user_updated"] == null
            ? null
            : UserData.fromMap(json["user_updated"]),
        image:json["image"]==null?null: PdfFile.fromMap(json["image"]),
      );

  Map<String, dynamic> toMap() => {
        "date_created": dateCreated.toIso8601String(),
        "date_updated": dateUpdated?.toIso8601String(),
        "description": description,
        "id": id,
        "sort": sort,
        "status": status,
        "playable_url": playableUrl,
        "name": name,
        "devanagari_file": devanagariFile?.toMap(),
        "kannada_file": kannadaFile?.toMap(),
        "sub_categories": subCategories?.toMap(),
        "telugu": telugu?.toMap(),
        "user_created": userCreated.toMap(),
        "user_updated": userUpdated?.toMap(),
        "image": image?.toMap(),
      };
}

class PdfFile {
  PdfFile({
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
  final int? width;
  final int? height;
  final dynamic duration;
  final dynamic embed;
  final dynamic description;
  final dynamic location;
  final dynamic tags;
  final Metadata? metadata;

  factory PdfFile.fromMap(Map<String, dynamic> json) => PdfFile(
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
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromMap(json["metadata"]),
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
        "metadata": metadata?.toMap(),
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromMap(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toMap() => {};
}

class SubCategories {
  SubCategories({
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
  });

  final String categories;
  final DateTime dateCreated;
  final dynamic dateUpdated;
  final String id;
  final String image;
  final String name;
  final dynamic sort;
  final String status;
  final String userCreated;
  final dynamic userUpdated;

  factory SubCategories.fromMap(Map<String, dynamic> json) => SubCategories(
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
      };
}

class UserData {
  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.location,
    this.title,
    this.description,
    this.tags,
    this.avatar,
    this.language,
    required this.theme,
    this.tfaSecret,
    required this.status,
    required this.role,
    this.token,
    required this.lastAccess,
    required this.lastPage,
    required this.provider,
    this.externalIdentifier,
    this.authData,
    required this.emailNotifications,
    required this.appLanguage,
    required this.gothra,
    required this.guru,
    required this.instituteName,
    this.deviceToken,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final dynamic location;
  final dynamic title;
  final dynamic description;
  final dynamic tags;
  final dynamic avatar;
  final dynamic language;
  final String theme;
  final dynamic tfaSecret;
  final String status;
  final String role;
  final dynamic token;
  final DateTime lastAccess;
  final String lastPage;
  final String provider;
  final dynamic externalIdentifier;
  final dynamic authData;
  final bool emailNotifications;
  final String appLanguage;
  final String gothra;
  final String guru;
  final String instituteName;
  final String? deviceToken;

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        location: json["location"],
        title: json["title"],
        description: json["description"],
        tags: json["tags"],
        avatar: json["avatar"],
        language: json["language"],
        theme: json["theme"],
        tfaSecret: json["tfa_secret"],
        status: json["status"],
        role: json["role"],
        token: json["token"],
        lastAccess: DateTime.parse(json["last_access"]),
        lastPage: json["last_page"],
        provider: json["provider"],
        externalIdentifier: json["external_identifier"],
        authData: json["auth_data"],
        emailNotifications: json["email_notifications"],
        appLanguage: json["app_language"],
        gothra: json["gothra"],
        guru: json["guru"],
        instituteName: json["institute_name"],
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "location": location,
        "title": title,
        "description": description,
        "tags": tags,
        "avatar": avatar,
        "language": language,
        "theme": theme,
        "tfa_secret": tfaSecret,
        "status": status,
        "role": role,
        "token": token,
        "last_access": lastAccess.toIso8601String(),
        "last_page": lastPage,
        "provider": provider,
        "external_identifier": externalIdentifier,
        "auth_data": authData,
        "email_notifications": emailNotifications,
        "app_language": appLanguage,
        "gothra": gothra,
        "guru": guru,
        "institute_name": instituteName,
        "device_token": deviceToken,
      };
}
