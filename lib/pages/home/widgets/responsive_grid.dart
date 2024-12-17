import 'package:awesome_app/pages/home/detail/detail_page.dart';
import 'package:awesome_app/pages/home/home_controller.dart';
import 'package:awesome_app/utils/widgets/image_load.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid(this.controller, {super.key});
  final HomeController controller;

  int _getColumnCount(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 650) {
      // Mobile: 2 columns
      return 2;
    } else if (screenWidth < 1100) {
      // Tablet: 3 columns
      return 3;
    } else {
      // Desktop: 5 columns
      return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = _getColumnCount(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / crossAxisCount;

    return MasonryGridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemCount: controller.dataList.length,
      itemBuilder: (context, index) {
        final image = controller.dataList[index];

        double aspectRatio = (image.width ?? 1) / (image.height ?? 1);
        double itemHeight = itemWidth / aspectRatio;
        bool isPotrait = (image.width ?? 1) < (image.height ?? 1);

        bool isSquare = (image.width ?? 1) == (image.height ?? 1);
        return InkWell(
          onTap: () async {
            await Get.toNamed(DetailPage.route,
                arguments: image.toJsonDetail(index));
          },
          child: SizedBox(
            width: itemWidth,
            height: itemHeight,
            child: ImageLoad(
                heroTag: 'image_${(image.id ?? 0) + index}',
                src: isPotrait
                    ? image.src?.portrait
                    : isSquare
                        ? image.src?.medium
                        : image.src?.landscape),
          ),
        );
      },
    ).marginOnly(left: 12, right: 12, bottom: 35);
  }
}
