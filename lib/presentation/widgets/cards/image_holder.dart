import 'dart:io';

import 'package:canteen/core/config/app_permission.dart';
import 'package:canteen/core/config/app_permission.dart';
import 'package:canteen/core/theme/app_colors.dart';
import 'package:canteen/presentation/widgets/buttons/app_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageHolder extends StatefulWidget {
  final TextEditingController controller;

  const ImageHolder({
    super.key,
    required this.controller,
  });

  @override
  State<ImageHolder> createState() => _ImageHolderState();
}

class _ImageHolderState extends State<ImageHolder> {
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    // Choose the appropriate permission check based on source
    bool isPermissionGranted = source == ImageSource.camera
        ? await AppPermission.requestCameraPermission(context)
        : await AppPermission.requestGalleryPermission(context);

    if (isPermissionGranted) {
      try {
        final pickedFile = await _picker.pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            _selectedImage = File(pickedFile.path);
          });
          widget.controller.text = pickedFile.path;
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e')),
        );
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DottedBorder(
      color: AppColors.primary,
      borderType: BorderType.RRect,
      radius: const Radius.circular(16),
      strokeWidth: 1,
      dashPattern: const [1, 1],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _selectedImage != null
                ? Image.file(
              _selectedImage!,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/images/image.png',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            AppButton(
              title: 'Upload',
              color: Colors.white,
              borderColor: AppColors.primary,
              onPressed: _showImageSourceDialog,
              text: Text(
                'Upload ',
                style: theme.textTheme.labelMedium!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}