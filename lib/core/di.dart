import 'package:canteen/presentation/navigation/app_router.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AppRouter());
}
