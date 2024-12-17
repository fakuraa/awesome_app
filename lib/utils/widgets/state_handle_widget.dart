import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateHandleWidget extends StatefulWidget {
  final bool loadingEnabled;
  final bool emptyEnabled;
  final bool errorEnabled;
  final Widget? loadingView;
  final ImageProvider? emptyImage;
  final String? emptyTitle;
  final String? emptySubtitle;
  final ImageProvider? errorImage;
  final String? errorTitle;
  final String? errorSubtitle;
  final void Function()? onRetryPressed;

  final Widget body;

  const StateHandleWidget({
    super.key,
    required this.body,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
    this.onRetryPressed,
    this.loadingView,
    this.emptyEnabled = false,
    this.loadingEnabled = false,
    this.errorEnabled = false,
    this.errorImage,
    this.errorSubtitle,
    this.errorTitle,
  });

  @override
  StateHandleWidgetState createState() => StateHandleWidgetState();
}

class StateHandleWidgetState extends State<StateHandleWidget> {
  @override
  Widget build(BuildContext context) {
    var loadingWidget = widget.loadingView ?? CupertinoActivityIndicator();

    return Stack(
      children: [
        getBodyWidget(),
        getErrorView(),
        getEmptyView(),
        getLoadingView(loadingWidget),
      ],
    );
  }

  Widget getBodyWidget() => AnimatedSwitcher(
        duration: const Duration(milliseconds: 900),
        child:
            widget.loadingEnabled || widget.emptyEnabled || widget.errorEnabled
                ? Container()
                : widget.body,
      );

  Widget getLoadingView(Widget loadingWidget) => widget.loadingEnabled
      ? Center(
          child: AnimatedOpacity(
            opacity: widget.loadingEnabled ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: loadingWidget,
          ),
        )
      : Container();

  Widget getEmptyView() =>
      widget.emptyEnabled && !widget.errorEnabled && !widget.loadingEnabled
          ? buildEmpty()
          : Container();

  Widget buildEmpty() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rocket_launch_rounded,
              size: 180, color: Colors.blueGrey,
              // image:
              //     widget.emptyImage ?? AppImages.imgEmptySearch.image().image,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 40, 24, 20),
              child: Text(
                widget.emptyTitle ?? "",
                style: Get.textTheme.labelMedium
                    ?.copyWith(fontSize: 14, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Text(
                widget.emptySubtitle ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );

  Widget getErrorView() => widget.errorEnabled ? buildError() : Container();

  Widget buildError() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outlined,
              size: 180, color: Colors.red.shade300,
              // image: widget.errorImage ?? AppImages.imgError.image().image,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 40, 24, 10),
              child: Text(
                widget.errorSubtitle ?? "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontStyle: FontStyle.normal),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              child: Text(
                widget.errorTitle ?? "",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: widget.onRetryPressed,
              child: Text(
                'txt_button_retry'.tr,
              ),
            )
          ],
        ),
      );
}
