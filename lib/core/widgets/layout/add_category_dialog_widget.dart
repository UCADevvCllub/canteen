import 'package:auto_route/annotations.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/core/widgets/buttons/app_button.dart';
import 'package:canteen/core/widgets/cards/image_holder.dart';
import 'package:canteen/core/widgets/cards/titled_field_wrapper.dart';
import 'package:canteen/core/widgets/fields/app_text_form_field.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddCategoryDialogWidget extends StatefulWidget {
  const AddCategoryDialogWidget({super.key});

  @override
  State<AddCategoryDialogWidget> createState() => _AddCategoryDialogWidgetState();
}

class _AddCategoryDialogWidgetState extends State<AddCategoryDialogWidget> {
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16.0), // Match previous styling
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Match previous styling
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title with Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Category',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF84C264), // Green color
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Color(0xFF84C264), // Green color
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Category Name Input
            TitledFieldWrapper(
              title: 'Category Name',
              child: AppTextFormField(
                hintText: 'Enter name here',
                borderColor: AppColors.primary,
                controller: _nameController,
              ),
            ),
            const SizedBox(height: 20),

            // Category Image Upload Section
            TitledFieldWrapper(
              title: 'Category Image',
              child: Column(
                children: [
                  // Placeholder for the image (using ImageHolder)
                  ImageHolder(
                    controller: _imageController,
                  ),
                  const SizedBox(height: 10),

                  // Upload and Open Camera Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Implement image upload logic
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF84C264), // Green border
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Upload',
                            style: TextStyle(
                              color: Color(0xFF84C264), // Green text
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // TODO: Implement camera logic
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF84C264), // Green border
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Open Camera',
                            style: TextStyle(
                              color: Color(0xFF84C264), // Green text
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Cancel & Add Category Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppButton(
                  title: 'Cancel',
                  color: Colors.white,
                  borderColor: const Color(0xFF84C264), // Green outline
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                AppButton(
                  title: 'Add Category',
                  color: const Color(0xFF84C264), // Green color
                  onPressed: () {
                    // TODO: Implement category addition logic
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}