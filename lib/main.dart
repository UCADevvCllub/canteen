import 'package:canteen/core/config/di.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';
import 'package:canteen/features/products/data/products_service.dart';
import 'package:canteen/features/home/presentation/app.dart';
import 'package:canteen/features/products/presentation/provider/product_provider.dart';
import 'package:canteen/features/schedule/presentation/provider/schedule_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

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
          create: (_) => ProductProvider(
            locator<ProductsService>(), // Получаем ProductsService
          ),
        ),
        ChangeNotifierProvider(create: (_) => locator<ScheduleProvider>()),
      ],
      child: const App(),
    ),
  );
}
