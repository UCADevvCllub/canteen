import 'package:canteen/data/remote/auth_service.dart';
import 'package:canteen/data/remote/products_service.dart';
import 'package:canteen/presentation/navigation/app_router.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppRouter());

  registerServices();
}

void registerServices() {
  locator.registerLazySingleton(() => AuthService());

  locator.registerLazySingleton(() => ProductsService());
}
