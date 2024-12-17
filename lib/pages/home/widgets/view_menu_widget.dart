import 'package:awesome_app/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewMenuWidget extends StatelessWidget {
  const ViewMenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      initialValue: 0,
      onSelected: (int item) {
        Get.find<HomeController>().changeViewMenu(item);
      },
      position: PopupMenuPosition.over,
      offset: Offset(20, 0),
      requestFocus: true,
      menuPadding: EdgeInsets.zero,
      constraints: BoxConstraints(minWidth: 0),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: Icon(
            Icons.grid_view_rounded,
            color: Colors.deepOrange.shade400,
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Icon(
            Icons.list_rounded,
            color: Colors.deepOrange.shade400,
          ),
        ),
      ],
      child: Icon(
        [
          Icons.grid_view_rounded,
          Icons.list_rounded
        ][Get.find<HomeController>().viewMenu],
        color: Colors.deepOrange.shade200,
        size: 28,
      ),
    );
  }
}
