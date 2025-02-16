import 'package:canteen/data/auth/auth_service.dart';
import 'package:canteen/data/products/products_service.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/data/schedule/schedule_service.dart'; // Добавлен импорт FirestoreService
import 'package:get_it/get_it.dart';

final GetIt locator =
    GetIt.instance; // Убедитесь, что используете GetIt.instance

void setupLocator() {
  // Регистрация AppRouter
  locator.registerLazySingleton(() => AppRouter());

  // Регистрация сервисов
  registerServices();
}

void registerServices() {
  // Регистрация AuthService
  locator.registerLazySingleton(() => AuthService());

  // Регистрация ProductsService
  locator.registerLazySingleton(() => ProductsService());

  // Регистрация FirestoreService
  locator.registerLazySingleton(
      () => FirestoreService()); // Добавлена регистрация FirestoreService
}
