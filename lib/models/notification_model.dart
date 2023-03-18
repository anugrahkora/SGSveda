// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromMap(jsonString);

import 'dart:convert';

import 'category_model.dart';

NotificationModel notificationModelFromMap(String str) =>
    NotificationModel.fromMap(json.decode(str));

String notificationModelToMap(NotificationModel data) =>
    json.encode(data.toMap());

class NotificationModel {
  NotificationModel({
    required this.data,
  });

  final List<Datum> data;

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.dateCreated,
    this.dateUpdated,
    required this.id,
    required this.title,
    this.url,
    required this.type,
    required this.body,
    this.image,
    required this.userCreated,
    this.userUpdated,
    this.category,
  });

  final DateTime dateCreated;
  final DateTime? dateUpdated;
  final String id;
  final String? title;
  final String? url;
  final String? type;
  final String? body;
  final Image? image;
  final UserAted userCreated;
  final UserAted? userUpdated;
  final Category? category;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        dateCreated: DateTime.parse(json["date_created"]),
        dateUpdated: json["date_updated"] == null
            ? null
            : DateTime.parse(json["date_updated"]),
        id: json["id"],
        title: json["title"],
        url: json["url"],
        type: json["type"],
        body: json["body"],
        image: json["image"] == null ? null : Image.fromMap(json["image"]),
        userCreated: UserAted.fromMap(json["user_created"]),
        userUpdated: json["user_updated"] == null
            ? null
            : UserAted.fromMap(json["user_updated"]),
        category: json["category"] == null
            ? null
            : Category.fromMap(json["category"]),
      );

  Map<String, dynamic> toMap() => {
        "date_created": dateCreated.toIso8601String(),
        "date_updated": dateUpdated?.toIso8601String(),
        "id": id,
        "title": title,
        "url": url,
        "type": type,
        "body": body,
        "image": image?.toMap(),
        "user_created": userCreated.toMap(),
        "user_updated": userUpdated?.toMap(),
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
  final dynamic modifiedBy;
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
  final dynamic deviceToken;

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
