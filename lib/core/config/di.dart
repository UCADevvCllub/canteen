import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/auth/auth_injection.dart';
import 'package:canteen/features/debts/data/debts_service.dart';
import 'package:canteen/features/products/data/products_service.dart';
import 'package:canteen/core/navigation/app_router.dart';
import 'package:canteen/features/schedule/schedule_injection.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => AppRouter());

  await coreSetup();

  authInjection();

  registerServices();

  scheduleInjection();
}

Future<void> coreSetup() async {
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);

  locator.registerLazySingleton(() => UserService());
}

void registerServices() {
  // Регистрация ProductsService
  locator.registerLazySingleton<ProductsService>(() => ProductsService());
  locator.registerLazySingleton<DebtsService>(() => DebtsService());
}
