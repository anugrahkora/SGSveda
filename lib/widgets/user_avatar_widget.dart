import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

Widget userAvatar({required double height,required double width,String? imageUrl}) {
 return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(20),
    child: CircleAvatar(
      radius: 22,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: CachedNetworkImage(
          width: width,
          height: height,
          fit: BoxFit.cover,
          imageUrl:imageUrl?? dummyImageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => Image.asset('assets/MEME.gif'),
        ),
      ),
    ),
  );
}
