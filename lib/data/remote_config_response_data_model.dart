// To parse this JSON data, do
//
//     final remoteConfigResponseDataModel = remoteConfigResponseDataModelFromJson(jsonString);

import 'dart:convert';

RemoteConfigResponseDataModel remoteConfigResponseDataModelFromJson(String str) => RemoteConfigResponseDataModel.fromJson(json.decode(str));

String remoteConfigResponseDataModelToJson(RemoteConfigResponseDataModel data) => json.encode(data.toJson());

class RemoteConfigResponseDataModel {
  int adShowAdStatus;
  String bannerAdId;
  String appOpenAdId;
  String industrialAdId;
  bool isOnlyShowApp;

  RemoteConfigResponseDataModel({
    required this.adShowAdStatus,
    required this.bannerAdId,
    required this.appOpenAdId,
    required this.industrialAdId,
    required this.isOnlyShowApp,
  });

  factory RemoteConfigResponseDataModel.fromJson(Map<String, dynamic> json) => RemoteConfigResponseDataModel(
    adShowAdStatus: json["ad_showAdStatus"],
    bannerAdId: json["bannerAdId"],
    appOpenAdId: json["appOpenAdId"],
    industrialAdId: json["industrialAdId"],
    isOnlyShowApp: json["isOnlyShowApp"],
  );

  Map<String, dynamic> toJson() => {
    "ad_showAdStatus": adShowAdStatus,
    "bannerAdId": bannerAdId,
    "appOpenAdId": appOpenAdId,
    "industrialAdId": industrialAdId,
    "isOnlyShowApp": isOnlyShowApp,
  };
}
