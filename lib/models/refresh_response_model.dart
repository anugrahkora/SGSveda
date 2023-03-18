// To parse this JSON data, do
//
//     final refreshTokenResponse = refreshTokenResponseFromMap(jsonString);

import 'dart:convert';

RefreshTokenResponse refreshTokenResponseFromMap(String str) =>
    RefreshTokenResponse.fromMap(json.decode(str));

String refreshTokenResponseToMap(RefreshTokenResponse data) =>
    json.encode(data.toMap());

class RefreshTokenResponse {
  RefreshTokenResponse({
    required this.data,
  });

  final Data data;

  factory RefreshTokenResponse.fromMap(Map<String, dynamic> json) =>
      RefreshTokenResponse(
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };
}

class Data {
  Data({
    required this.accessToken,
    required this.expires,
    required this.refreshToken,
  });

  final String accessToken;
  final int expires;
  final String refreshToken;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        expires: json["expires"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toMap() => {
        "access_token": accessToken,
        "expires": expires,
        "refresh_token": refreshToken,
      };
}
