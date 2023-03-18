// To parse this JSON data, do
//
//     final getBannerModel = getBannerModelFromMap(jsonString);

import 'dart:convert';

import 'category_model.dart';

GetBannerModel getBannerModelFromMap(String str) =>
    GetBannerModel.fromMap(json.decode(str));

String getBannerModelToMap(GetBannerModel data) => json.encode(data.toMap());

class GetBannerModel {
  GetBannerModel({
    required this.data,
  });

  final List<BannerM> data;

  factory GetBannerModel.fromMap(Map<String, dynamic> json) => GetBannerModel(
        data: List<BannerM>.from(json["data"].map((x) => BannerM.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class BannerM {
  BannerM({
    required this.id,
    required this.status,
    required this.dateCreated,
    this.dateUpdated,
    required this.title,
    required this.desc,
    this.url,
    required this.type,
    required this.userCreated,
    this.userUpdated,
    required this.image,
    this.category,
  });

  final int id;
  final String status;
  final DateTime dateCreated;
  final DateTime? dateUpdated;
  final String title;
  final String desc;
  final String? url;
  final String type;
  final UserAted userCreated;
  final UserAted? userUpdated;
  final Image image;
  final Category? category;

  factory BannerM.fromMap(Map<String, dynamic> json) => BannerM(
        id: json["id"],
        status: json["status"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateUpdated: json["date_updated"] == null
            ? null
            : DateTime.parse(json["date_updated"]),
        title: json["title"],
        desc: json["desc"],
        url: json["url"],
        type: json["type"],
        userCreated: UserAted.fromMap(json["user_created"]),
        userUpdated: json["user_updated"] == null
            ? null
            : UserAted.fromMap(json["user_updated"]),
        image: Image.fromMap(json["image"]),
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "date_created": dateCreated.toIso8601String(),
        "date_updated": dateUpdated?.toIso8601String(),
        "title": title,
        "desc": desc,
        "url": url,
        "type": type,
        "user_created": userCreated.toMap(),
        "user_updated": userUpdated?.toMap(),
        "image": image.toMap(),
        "category": category?.toMap(),
      };
}

class Image {
  Image({
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
    required this.width,
    required this.height,
    this.duration,
    this.embed,
    this.description,
    this.location,
    this.tags,
    required this.metadata,
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
  final String? modifiedBy;
  final DateTime modifiedOn;
  final dynamic charset;
  final String filesize;
  final int width;
  final int height;
  final dynamic duration;
  final dynamic embed;
  final dynamic description;
  final dynamic location;
  final dynamic tags;
  final Metadata metadata;

  factory Image.fromMap(Map<String, dynamic> json) => Image(
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
        metadata: Metadata.fromMap(json["metadata"]),
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
        "metadata": metadata.toMap(),
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromMap(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toMap() => {};
}

class UserAted {
  UserAted({
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

  factory UserAted.fromMap(Map<String, dynamic> json) => UserAted(
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
