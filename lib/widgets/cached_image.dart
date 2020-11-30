import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CachedImage extends StatefulWidget {

  final LinearGradient gradient;
  final String url;
  final Widget placeholder;
  final Widget error;
  final String errorImg;
  final BorderRadius borderRadius;
  final double width;
  final double height;

  CachedImage({this.url, this.placeholder, this.errorImg, this.error, this.width = 0, this.height = 0, this.borderRadius, this.gradient});

  @override
  _CachedImageState createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {

  @override
  Widget build(BuildContext context) {

    Widget onError = widget.error ?? ClipRRect(
      borderRadius: widget.borderRadius??BorderRadius.zero,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.errorImg),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );

    return widget.url == "none" || widget.url == null ? onError : CachedNetworkImage(
      imageUrl: this.widget.url,
      width: this.widget.width,
      height: this.widget.height,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: this.widget.borderRadius??BorderRadius.zero,
        child: Container(
          width: this.widget.width,
          height: this.widget.height,
          foregroundDecoration: BoxDecoration(
            gradient: widget.gradient ?? null,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => onError,
    );
  }
}