import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:canteen/features/profile/data/my_account_service.dart';
import 'package:canteen/features/profile/presentation/pages/widgets/editable_field_widgets.dart';
import 'package:canteen/features/profile/presentation/pages/widgets/profile_widgets.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  String _selectedLanguage = 'English';
  final List<String> _availableLanguages = ['English', 'Русский'];
  String _phoneNumber = '';
  String _countryCode = '+996';
  String _fullName = '';
  String _email = '';
  File? _localProfileImage;
  String? _profileImageUrl;
  bool _isPhoneNumberEditable = false;
  bool _isFullNameEditable = false;
  bool _isEmailEditable = false;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = true;
  bool _isSaving = false;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final userData = await _firebaseService.getUserData();

      if (userData != null) {
        setState(() {
          _fullName = userData['fullName'] ?? '';
          _email = userData['email'] ?? '';
          _phoneNumber = userData['phoneNumber'] ?? '';
          _profileImageUrl = userData['profileImageUrl'];
          _selectedLanguage = userData['language'] ?? 'English';

          _fullNameController.text = _fullName;
          _emailController.text = _email;
          _phoneController.text = _phoneNumber.replaceFirst(_countryCode, '');
        });
      }
    } catch (e) {
      print('Ошибка при загрузке данных: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при загрузке данных: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _localProfileImage = File(image.path);
        _isSaving = true;
      });

      final String? imageUrl = await _firebaseService.uploadProfileImage(_localProfileImage!);

      setState(() {
        if (imageUrl != null) {
          _profileImageUrl = imageUrl;
        }
        _isSaving = false;
      });

      if (imageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка при загрузке изображения')),
        );
      }
    }
  }

  Future<void> _saveChanges() async {
    if (_isFullNameEditable || _isEmailEditable || _isPhoneNumberEditable) {
      setState(() {
        if (_isFullNameEditable) {
          _fullName = _fullNameController.text;
          _isFullNameEditable = false;
        }
        if (_isEmailEditable) {
          _email = _emailController.text;
          _isEmailEditable = false;
        }
        if (_isPhoneNumberEditable) {
          _phoneNumber = _countryCode + _phoneController.text;
          _isPhoneNumberEditable = false;
        }
      });
    }

    setState(() {
      _isSaving = true;
    });

    try {
      bool success = await _firebaseService.updateUserData(
        fullName: _fullName,
        email: _email,
        phoneNumber: _phoneNumber,
        language: _selectedLanguage,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_selectedLanguage == 'English'
                ? 'Changes saved successfully!'
                : 'Изменения успешно сохранены!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_selectedLanguage == 'English'
                ? 'Failed to save changes'
                : 'Не удалось сохранить изменения'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Ошибка при сохранении изменений: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Future<void> _deleteAccount() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool success = await _firebaseService.deleteAccount();
      if (success) {
        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка при удалении аккаунта')),
        );
      }
    } catch (e) {
      print('Ошибка при удалении аккаунта: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при удалении аккаунта: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BD162),
      appBar: AppBar(
        backgroundColor: const Color(0xFF8BD162),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          _selectedLanguage == 'English' ? 'My account' : 'Мой аккаунт',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: AccountBodyContent(
              selectedLanguage: _selectedLanguage,
              fullName: _fullName,
              email: _email,
              fullNameController: _fullNameController,
              emailController: _emailController,
              phoneController: _phoneController,
              profileImageUrl: _profileImageUrl,
              localProfileImage: _localProfileImage,
              countryCode: _countryCode,
              isFullNameEditable: _isFullNameEditable,
              isEmailEditable: _isEmailEditable,
              isPhoneNumberEditable: _isPhoneNumberEditable,
              isSaving: _isSaving,
              onFullNameEdit: () {
                setState(() {
                  if (_isFullNameEditable) {
                    _fullName = _fullNameController.text;
                  }
                  _isFullNameEditable = !_isFullNameEditable;
                });
              },
              onEmailEdit: () {
                setState(() {
                  if (_isEmailEditable) {
                    _email = _emailController.text;
                  }
                  _isEmailEditable = !_isEmailEditable;
                });
              },
              onPhoneEdit: () {
                setState(() {
                  if (_isPhoneNumberEditable) {
                    _phoneNumber = _countryCode + _phoneController.text;
                  }
                  _isPhoneNumberEditable = !_isPhoneNumberEditable;
                });
              },
              onCountryCodeChanged: (code) {
                setState(() {
                  _countryCode = code;
                });
              },
              onLanguageChanged: (language) {
                setState(() {
                  _selectedLanguage = language;
                });
              },
              availableLanguages: _availableLanguages,
              onGetImage: _getImage,
              onDeleteAccount: () => _showDeleteAccountConfirmation(),
              onSaveChanges: _saveChanges,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_selectedLanguage == 'English' ? 'Delete Account' : 'Удалить аккаунт'),
          content: Text(
            _selectedLanguage == 'English'
                ? 'Are you sure you want to delete your account? This action cannot be undone.'
                : 'Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить.',
          ),
          actions: <Widget>[
            TextButton(
              child: Text(_selectedLanguage == 'English' ? 'Cancel' : 'Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                _selectedLanguage == 'English' ? 'Delete' : 'Удалить',
                style: const TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }
}



