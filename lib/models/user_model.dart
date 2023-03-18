// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    required this.data,
  });

  final Data data;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
    required this.password,
    this.location,
    this.title,
    this.description,
    this.tags,
    this.avatar,
    required this.language,
    required this.theme,
    this.tfaSecret,
    required this.status,
    required this.role,
    this.token,
    required this.lastAccess,
    this.lastPage,
    required this.provider,
    this.externalIdentifier,
    this.authData,
    required this.emailNotifications,
    this.appLanguage,
    this.gothra,
    this.guru,
    this.instituteName,
    this.deviceToken,
  });

  final String id;
  final dynamic firstName;
  final dynamic lastName;
  final String email;
  final String password;
  final dynamic location;
  final dynamic title;
  final dynamic description;
  final dynamic tags;
  final dynamic avatar;
  final dynamic language;
  final dynamic theme;
  final dynamic tfaSecret;
  final dynamic status;
  final String role;
  final dynamic token;
  final DateTime lastAccess;
  final dynamic lastPage;
  final dynamic provider;
  final dynamic externalIdentifier;
  final dynamic authData;
  final dynamic emailNotifications;
  final dynamic appLanguage;
  final dynamic gothra;
  final dynamic guru;
  final dynamic instituteName;
  final dynamic deviceToken;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
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
