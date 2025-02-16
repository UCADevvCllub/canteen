import 'package:canteen/core/config/di.dart';
import 'package:canteen/data/products/products_service.dart';
import 'package:canteen/presentation/app.dart';
import 'package:canteen/presentation/pages/products/provider/products_notifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'data/schedule/schedule_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator(); // Инициализация locator

  runApp(
    MultiProvider(
      providers: [
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
