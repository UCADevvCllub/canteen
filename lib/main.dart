import 'package:canteen/core/di.dart';
import 'package:canteen/data/remote/products_service.dart';
import 'package:canteen/presentation/app.dart';
import 'package:canteen/presentation/providers/products_notifier.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsNotifier(
            locator<ProductsService>(),
          ),
        ),
      ],
      child: const App(),
    ),
  );
}
