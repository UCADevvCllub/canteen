import 'package:canteen/core/config/di.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:canteen/features/products/data/products_service.dart';
import 'package:canteen/features/home/presentation/app.dart';
import 'package:canteen/features/schedule/presentation/provider/products_notifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'features/schedule/data/schedule_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator(); // Инициализация locator

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => locator<AuthProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsNotifier(
            locator<ProductsService>(), // Получаем ProductsService
            locator<FirestoreService>(), // Получаем FirestoreService
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
