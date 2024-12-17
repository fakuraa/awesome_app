import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoad extends StatelessWidget {
  final String? src;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BorderRadius? borderRadius;
  final String? heroTag;
  final bool isCircular;

  const ImageLoad({
    super.key,
    this.src,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.borderRadius,
    this.heroTag,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    if (src == null || src!.isEmpty) {
      return _errorWidget();
    }

    final isRemote = src!.startsWith('http');
    final isAsset =
        src!.startsWith('assets/') || src!.startsWith('lib/resources/');

    final imageWidget = isCircular
        ? ClipOval(child: _buildImage(isRemote, isAsset))
        : ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            child: _buildImage(isRemote, isAsset),
          );

    return heroTag != null
        ? Hero(tag: heroTag!, child: imageWidget)
        : imageWidget;
  }

  Widget _buildImage(bool isRemote, bool isAsset) {
    if (isRemote) {
      return _loadNetworkImage();
    } else if (isAsset) {
      return _loadAssetImage();
    } else {
      return _loadFileImage();
    }
  }

  Widget _loadNetworkImage() {
    return CachedNetworkImage(
      imageUrl: src!,
      width: width,
      height: height,
      fit: fit,
      color: color,
      placeholder: (context, url) => _shimmerPlaceholder(),
      errorWidget: (context, url, error) => _errorWidget(),
    );
  }

  Widget _loadAssetImage() {
    return Image.asset(
      src!,
      width: width,
      height: height,
      fit: fit,
      color: color,
      errorBuilder: (context, error, stackTrace) => _errorWidget(),
    );
  }

  Widget _loadFileImage() {
    return Image.file(
      File(src!),
      width: width,
      height: height,
      fit: fit,
      color: color,
      errorBuilder: (context, error, stackTrace) => _errorWidget(),
    );
  }

  Widget _shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }

  Widget _errorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: const Icon(Icons.broken_image, color: Colors.redAccent),
    );
  }
}
