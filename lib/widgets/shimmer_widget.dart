import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Shimmer loadingWidget(BuildContext context, Widget child) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    enabled: true,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    ),
  );
}
