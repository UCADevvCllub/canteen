import 'package:canteen/features/schedule/presentation/admin/add_category.dart';
import 'package:flutter/material.dart';

mixin DialogHelper {
  void showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: AddCategory(),
        );
      },
    );
  }
}
