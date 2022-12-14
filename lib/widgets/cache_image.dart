import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta/utiles/constants.dart';

CachedNetworkImage cachedNetworkImage(final String url,
    {final double? height,
    final double? width,
    final BoxFit boxFit = BoxFit.cover}) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: boxFit,
    height: height,
    width: width,
    placeholder: (context, url) => const Center(
        child: SizedBox(
            height: 30, width: 30, child: CircularProgressIndicator())),
    errorWidget: (context, url, error) => CachedNetworkImage(imageUrl: noImageAvailable,),
  );
}
