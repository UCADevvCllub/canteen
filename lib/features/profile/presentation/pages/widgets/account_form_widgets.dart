import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart';

Widget buildEditableField({
  required String title,
  required TextEditingController controller,
  required bool isEditable,
  required Function() onEditPressed,
  TextInputType keyboardType = TextInputType.text,
  List<TextInputFormatter>? inputFormatters,
  bool isPassword = false,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: isEditable,
            keyboardType: keyboardType,
            obscureText: isPassword,
            inputFormatters: inputFormatters,
            style: TextStyle(
              color: controller.text.isNotEmpty ? Colors.black : Colors.grey,
            ),
            decoration: InputDecoration(
              labelText: title,
              labelStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            isEditable ? Icons.check : Icons.edit,
            color: Colors.grey,
          ),
          onPressed: onEditPressed,
        ),
      ],
    ),
  );
}

Widget buildPhoneNumberField({
  required BuildContext context,
  required bool isPhoneNumberEditable,
  required TextEditingController phoneController,
  required String countryCode,
  required Function(String) onCountryChanged,
  required Function() onEditPressed,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          child: CountryCodePicker(
            onChanged: (CountryCode code) {
              onCountryChanged(code.dialCode!);
            },
            initialSelection: 'KG',
            favorite: const ['KG', 'RU', 'US'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            padding: EdgeInsets.zero,
            textStyle: const TextStyle(fontSize: 14),
          ),
        ),
        Expanded(
          child: TextField(
            controller: phoneController,
            enabled: isPhoneNumberEditable,
            keyboardType: TextInputType.phone,
            style: TextStyle(
              color: phoneController.text.isNotEmpty ? Colors.black : Colors.grey,
            ),
            decoration: const InputDecoration(
              labelText: 'WhatsApp number',
              labelStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 4),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            isPhoneNumberEditable ? Icons.check : Icons.edit,
            color: Colors.grey,
          ),
          onPressed: onEditPressed,
        ),
      ],
    ),
  );
}

Widget buildLanguageDropdown({
  required String selectedLanguage,
  required List<String> availableLanguages,
  required Function(String?) onChanged,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedLanguage,
        isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 6,
        hint: const Text(
          'Language',
          style: TextStyle(color: Colors.grey),
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        items: availableLanguages.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ),
  );
}

Widget buildDeleteAccountButton({
  required String selectedLanguage,
  required Function() onPressed,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(35),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          blurRadius: 5,
          spreadRadius: 1,
        ),
      ],
    ),
    child: GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedLanguage == 'English' ? 'Delete Account' : 'Удалить аккаунт',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    ),
  );
}