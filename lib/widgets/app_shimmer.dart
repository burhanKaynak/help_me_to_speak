import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../core/const/app_sizer.dart';

Widget get buildCircleShimmer => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Wrap(spacing: 5, children: [
        ClipOval(
          child: Container(
            color: Colors.black,
            width: AppSizer.iconMedium,
            height: AppSizer.iconMedium,
          ),
        ),
        ClipOval(
          child: Container(
            color: Colors.black,
            width: AppSizer.iconMedium,
            height: AppSizer.iconMedium,
          ),
        )
      ]),
    );
