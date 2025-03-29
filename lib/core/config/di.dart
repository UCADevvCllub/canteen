import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/auth/auth_injection.dart';
import 'package:canteen/features/auth/data/remote/auth_remote_service.dart';
import 'package:canteen/features/products/data/products_service.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/features/schedule/data/schedule_service.dart'; // Добавлен импорт FirestoreService
import 'package:get_it/get_it.dart';

final GetIt locator =
    GetIt.instance; // Убедитесь, что используете GetIt.instance

void setupLocator() {
  locator.registerLazySingleton(() => AppRouter());

  coreSetup();

  authInjection();

  registerServices();
}

void coreSetup() {
  locator.registerLazySingleton(() => UserService());
}

void registerServices() {
  // Регистрация ProductsService
  locator.registerLazySingleton<ProductsService>(() => ProductsService());

  // Регистрация FirestoreService
  locator.registerLazySingleton<FirestoreService>(
      () => FirestoreService()); // Добавлена регистрация FirestoreService
}
