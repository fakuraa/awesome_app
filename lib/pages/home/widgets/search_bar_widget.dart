import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SearchBarWidget extends StatefulWidget {
  TextEditingController? controller;
  void Function(String?)? onSubmitted;
  void Function(String?)? onChanged;
  String? Function(String?)? validator;
  String? hint;
  Color? fillColor;

  SearchBarWidget({
    super.key,
    this.controller,
    this.onSubmitted,
    this.hint,
    this.onChanged,
    this.validator,
    this.fillColor,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  Timer? _debounce;

  void _onSearchChanged(String? query) {
    if (widget.validator != null && (query ?? "").isNotEmpty) {
      final validationResult = widget.validator!(query);
      if (validationResult != null) {
        return;
      }
    }

    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 900), () {
      if (widget.onChanged != null) {
        widget.onChanged!(query);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.hint = widget.hint ?? "Cari ...";
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: TextField(
        controller: widget.controller,
        onSubmitted: widget.onSubmitted,
        style: Get.textTheme.labelSmall,
        onChanged: _onSearchChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          hintText: widget.hint,
          hintStyle: Get.textTheme.headlineSmall
              ?.copyWith(fontSize: 14, color: Theme.of(context).hintColor),
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          prefixIcon: Icon(Icons.search_rounded),
        ),
      ),
    );
  }
}
