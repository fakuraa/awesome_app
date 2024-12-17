import 'dart:math';

import 'package:awesome_app/pages/home/widgets/search_bar_widget.dart';
import 'package:awesome_app/pages/home/widgets/view_menu_widget.dart';
import 'package:awesome_app/resources/resources.dart';
import 'package:awesome_app/utils/widgets/image_load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  const CustomAppBar({
    required this.expandedHeight,
  });

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        // Background Image
        Opacity(
          opacity: (1 - shrinkOffset / expandedHeight).clamp(0.0, 1.0),
          child: ImageLoad(
            src:
                'https://images.pexels.com/photos/13129483/pexels-photo-13129483.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200',
            fit: BoxFit.cover,
            height: expandedHeight,
          ),
        ),
        // Gradient Overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight).clamp(0.0, 1.0),
            child: Container(
              height: expandedHeight / 2,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.white,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: (shrinkOffset / expandedHeight).clamp(0.0, 0.7),
            child: Container(
              height: expandedHeight / 2.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.white.withValues(alpha: 0.01),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
        ),
        // Floating Card
        _buildFloatingCard(shrinkOffset),
      ],
    );
  }

  Widget _buildFloatingCard(double shrinkOffset) {
    final double size = 95;
    final double topPosition =
        expandedHeight - min(shrinkOffset, expandedHeight - size) - size / 2;

    return Positioned(
      top: topPosition,
      left: 20,
      right: 20,
      child: Card(
        elevation: 3,
        child: Row(
          children: [
            AppImages.logo29.image(width: 29, height: 29).marginOnly(left: 12),
            Expanded(
              child: SearchBarWidget(
                fillColor: Colors.blueGrey.shade50,
              ).paddingSymmetric(vertical: 6, horizontal: 12),
            ),
            ViewMenuWidget().marginOnly(right: 12),
          ],
        ),
      ),
    );
  }
}
