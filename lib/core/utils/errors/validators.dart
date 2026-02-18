class FormValidators {
  // Email Validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    // Check if email ends with @ucentralasia.org
    if (!value.toLowerCase().endsWith('@ucentralasia.org')) {
      return 'Email must end with @ucentralasia.org';
    }

    return null; // Validation passed
  }

  // Password Validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    // Check if password contains at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check if password contains at least one letter
    if (!value.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Password must contain at least one letter';
    }

    return null; // Validation passed
  }

  // Name Validator
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name cannot be empty';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    // Optional: Ensure only letters and spaces
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters';
    }

    return null; // Validation passed
  }

  // Phone Number Validator
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }

    // Validate phone number format (customize as needed)
    final phoneRegExp = RegExp(r'^\+?[0-9]{10,14}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter a valid phone number';
    }

    return null; // Validation passed
  }

  // Custom Validator with Dynamic Rules
  static String? customValidator(
      String? value, {
        int? minLength,
        int? maxLength,
        Pattern? allowedCharacters,
        bool required = true,
      }) {
    if (required && (value == null || value.isEmpty)) {
      return 'Field cannot be empty';
    }

    if (minLength != null && value!.length < minLength) {
      return 'Minimum length is $minLength characters';
    }

    if (maxLength != null && value!.length > maxLength) {
      return 'Maximum length is $maxLength characters';
    }

    if (allowedCharacters != null) {
      final regExp = RegExp(allowedCharacters.toString());
      if (!regExp.hasMatch(value!)) {
        return 'Invalid characters used';
      }
    }

    return null; // Validation passed
  }
}