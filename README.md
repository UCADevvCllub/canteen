# Firebase Setup Guide - UCA Campus Canteen App

## Prerequisites
- Flutter SDK
- Node.js
- Firebase CLI
- Google account

## Setup Steps

### 1. Install Firebase CLI
```bash
npm install -g firebase-tools
```

### 2. Login to Firebase
```bash
firebase login
```

### 3. Configure Firebase in Your Project
```bash
flutterfire configure
```
This command will:
- Create a new Firebase project or select existing one
- Add required Firebase configuration files
- Generate `firebase_options.dart` file

### 4. Initialize Firebase in main.dart

Update your `main.dart` to initialize Firebase:
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
```

That's it! Your Flutter app is now connected to Firebase and ready to use Firebase services.

## Note
Make sure `firebase_options.dart` is included in your `.gitignore` if you're working with a public repository, as it contains sensitive configuration data.