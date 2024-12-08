import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/presentation/widgets/buttons/app_button.dart';
import 'package:canteen/presentation/widgets/cards/image_holder.dart';
import 'package:canteen/presentation/widgets/cards/titled_field_wrapper.dart';
import 'package:canteen/presentation/widgets/fields/app_text_form_field.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Add Category',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          TitledFieldWrapper(
            title: 'Category Name',
            child: AppTextFormField(
              hintText: 'Enter name here',
              borderColor: AppColors.primary,
              controller: _nameController,
            ),
          ),
          TitledFieldWrapper(
            title: 'Category Image',
            child: ImageHolder(
              controller: _imageController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                title: 'Cancel',
                onPressed: () {},
              ),
              AppButton(
                title: 'Add category',
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
