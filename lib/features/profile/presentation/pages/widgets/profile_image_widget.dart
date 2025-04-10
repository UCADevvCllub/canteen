import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileImageWidget extends StatelessWidget {
  final bool isLoading;
  final bool isSaving;
  final String? profileImageUrl;
  final File? localProfileImage;
  final Function() onGetImage;

  const ProfileImageWidget({
    Key? key,
    required this.isLoading,
    required this.isSaving,
    this.profileImageUrl,
    this.localProfileImage,
    required this.onGetImage,
  }) : super(key: key);

  ImageProvider? _getProfileImage() {
    if (localProfileImage != null) {
      return FileImage(localProfileImage!);
    } else if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      return CachedNetworkImageProvider(profileImageUrl!);
    } else {
      return const AssetImage('assets/images/profile_picture.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.grey.shade200,
          backgroundImage: _getProfileImage(),
          child: isLoading
              ? const CircularProgressIndicator()
              : null,
        ),
        if (!isLoading)
          Positioned(
            bottom: 0,
            right: 2,
            child: GestureDetector(
              onTap: onGetImage,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/icons/camera_for_profile.png',
                  width: 27,
                  height: 27,
                ),
              ),
            ),
          ),
        if (isSaving)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
}