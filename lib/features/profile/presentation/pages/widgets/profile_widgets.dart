import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:canteen/features/profile/presentation/pages/widgets/editable_field_widgets.dart';

class AccountBodyContent extends StatelessWidget {
  final String selectedLanguage;
  final String fullName;
  final String email;
  final String? profileImageUrl;
  final File? localProfileImage;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String countryCode;
  final bool isFullNameEditable;
  final bool isEmailEditable;
  final bool isPhoneNumberEditable;
  final bool isSaving;
  final List<String> availableLanguages;
  final Function() onFullNameEdit;
  final Function() onEmailEdit;
  final Function() onPhoneEdit;
  final Function(String) onCountryCodeChanged;
  final Function(String) onLanguageChanged;
  final Function() onGetImage;
  final Function() onDeleteAccount;
  final Function() onSaveChanges;

  const AccountBodyContent({
    Key? key,
    required this.selectedLanguage,
    required this.fullName,
    required this.email,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.profileImageUrl,
    required this.localProfileImage,
    required this.countryCode,
    required this.isFullNameEditable,
    required this.isEmailEditable,
    required this.isPhoneNumberEditable,
    required this.isSaving,
    required this.onFullNameEdit,
    required this.onEmailEdit,
    required this.onPhoneEdit,
    required this.onCountryCodeChanged,
    required this.onLanguageChanged,
    required this.availableLanguages,
    required this.onGetImage,
    required this.onDeleteAccount,
    required this.onSaveChanges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileImage(
              profileImageUrl: profileImageUrl,
              localProfileImage: localProfileImage,
              isLoading: false,
              isSaving: isSaving,
              onGetImage: onGetImage,
            ),
            UserInfoDisplay(fullName: fullName, email: email),
            EditableField(
              title: selectedLanguage == 'English' ? 'Full Name' : 'Полное имя',
              controller: fullNameController,
              isEditable: isFullNameEditable,
              onEditPressed: onFullNameEdit,
            ),
            EditableField(
              title: 'Email',
              controller: emailController,
              isEditable: isEmailEditable,
              onEditPressed: onEmailEdit,
              keyboardType: TextInputType.emailAddress,
            ),
            PhoneNumberField(
              phoneController: phoneController,
              isEditable: isPhoneNumberEditable,
              countryCode: countryCode,
              onCountryCodeChanged: onCountryCodeChanged,
              onEditPressed: onPhoneEdit,
            ),
            LanguageDropdown(
              selectedLanguage: selectedLanguage,
              availableLanguages: availableLanguages,
              onChanged: onLanguageChanged,
            ),
            DeleteAccountButton(
              selectedLanguage: selectedLanguage,
              onPressed: onDeleteAccount,
            ),
            const SizedBox(height: 30),
            SaveChangesButton(
              isSaving: isSaving,
              selectedLanguage: selectedLanguage,
              onPressed: onSaveChanges,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  final String? profileImageUrl;
  final File? localProfileImage;
  final bool isLoading;
  final bool isSaving;
  final Function() onGetImage;

  const ProfileImage({
    Key? key,
    required this.profileImageUrl,
    required this.localProfileImage,
    required this.isLoading,
    required this.isSaving,
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
          child: isLoading ? const CircularProgressIndicator() : null,
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

class UserInfoDisplay extends StatelessWidget {
  final String fullName;
  final String email;

  const UserInfoDisplay({
    Key? key,
    required this.fullName,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          fullName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          email,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class SaveChangesButton extends StatelessWidget {
  final bool isSaving;
  final String selectedLanguage;
  final Function() onPressed;

  const SaveChangesButton({
    Key? key,
    required this.isSaving,
    required this.selectedLanguage,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8BD162),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        onPressed: isSaving ? null : onPressed,
        child: isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          selectedLanguage == 'English' ? 'Save Changes' : 'Сохранить изменения',
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}