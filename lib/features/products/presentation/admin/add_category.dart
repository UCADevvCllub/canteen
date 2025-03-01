import 'package:auto_route/annotations.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/presentation/widgets/buttons/app_button.dart';
import 'package:canteen/presentation/widgets/cards/image_holder.dart';
import 'package:canteen/presentation/widgets/cards/titled_field_wrapper.dart';
import 'package:canteen/presentation/widgets/fields/app_text_form_field.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      // Stack(
      // children: [
        // 🔹 Background Image
        // Positioned.fill(
        //   child: Image.asset(
        //     'assets/images/login_page.png', // 🔹 Replace with your image path
        //     fit: BoxFit.cover,
        //   ),
        // ),

        // 🔹 Dialog with Rounded Corners
        Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Category',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF84C264), // Green color
                    ),
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

                  // Category Image Upload
                  TitledFieldWrapper(
                    title: 'Category Image',
                    child: ImageHolder(
                      controller: _imageController,
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
                        borderColor: Color(0xFF84C264), // Green outline
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      AppButton(
                        title: 'Add Category',
                        color: Color(0xFF84C264), // Green color
                        onPressed: () {
                          // TODO: Implement category addition logic
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
    //   ],
    // );
  }
}
