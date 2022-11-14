import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../core/const/app_sizer.dart';

class AppCircleImage extends StatelessWidget {
  final String image;
  const AppCircleImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: image,
        width: AppSizer.iconMedium,
        height: AppSizer.iconMedium,
        fit: BoxFit.cover,
      ),
    );
  }
}
