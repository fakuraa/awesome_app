import 'package:awesome_app/pages/home/home_controller.dart';
import 'package:awesome_app/pages/home/widgets/custom_appbar.dart';
import 'package:awesome_app/pages/home/widgets/responsive_grid.dart';

import 'package:awesome_app/utils/no_implicit_scroll_physics.dart';
import 'package:awesome_app/utils/widgets/image_load.dart';
import 'package:awesome_app/utils/widgets/state_handle_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  static const String route = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
        body: EasyRefresh(
          onRefresh: () async {
            await controller.refreshPage();
          },
          onLoad: () async {
            controller.loadMore();
          },
          footer: ClassicFooter(
            showMessage: false,
            showText: false,
            progressIndicatorStrokeWidth: 1,
            pullIconBuilder: (context, state, animation) =>
                CupertinoActivityIndicator(),
          ),
          header: MaterialHeader(),
          canLoadAfterNoMore: controller.hasNext.value,
          controller: controller.refreshController,
          child: CustomScrollView(
            physics: const NoImplicitScrollPhysics(),
            slivers: [
              SliverPersistentHeader(
                delegate: CustomAppBar(
                    expandedHeight: MediaQuery.of(context).size.height * 0.4),
                pinned: true,
              ),
              SliverToBoxAdapter(
                child: StateHandleWidget(
                  loadingEnabled: controller.isShimmering,
                  emptyEnabled: controller.isEmptyData,
                  errorEnabled: controller.isError,
                  errorTitle: "Ops Something went wrong...",
                  onRetryPressed: controller.refreshPage,
                  body: controller.viewMenu == 0
                      ? ResponsiveGrid(controller)
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.dataList.length,
                          itemBuilder: (context, index) {
                            var item = controller.dataList[index];
                            return ImageLoad(
                              src: item.src?.landscape,
                              height: MediaQuery.of(context).size.width / 2,
                            ).marginOnly(bottom: 12);
                          },
                        ).paddingSymmetric(horizontal: 16),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
