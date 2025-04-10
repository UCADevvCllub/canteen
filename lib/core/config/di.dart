import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/auth/auth_injection.dart';
import 'package:canteen/features/products/data/products_service.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/features/schedule/schedule_injection.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppRouter());

  coreSetup();

  authInjection();

  registerServices();

  scheduleInjection();
}

void coreSetup() {
  locator.registerLazySingleton(() => UserService());
}

void registerServices() {
  // Регистрация ProductsService
  locator.registerLazySingleton<ProductsService>(() => ProductsService());
}
