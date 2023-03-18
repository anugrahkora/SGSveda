import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:veda_nidhi_v2/utils/constants.dart';

Widget getImageFromUrl({required String? url, double? height, double? width}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    imageUrl:
        url == null || url.isEmpty ? dummyImageUrl : "$baseUrl/assets/$url",
    fit: BoxFit.cover,
  );
}
Widget getImageFromUrlLowRes(
    {required String? url, double? height, double? width}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: url == null || url.isEmpty
        ? dummyImageUrl
        : "$baseUrl/assets/$url?quality=10",
    fit: BoxFit.cover,
  );
}

Widget getImageFromUrlMediumRes(
    {required String? url, double? height, double? width}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: url == null || url.isEmpty
        ? dummyImageUrl
        : "$baseUrl/assets/$url?quality=50",
    fit: BoxFit.cover,
  );
}
