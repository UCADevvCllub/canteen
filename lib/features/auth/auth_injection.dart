import 'package:canteen/core/config/di.dart';
import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/auth/data/remote/auth_remote_service.dart';
import 'package:canteen/features/auth/presentation/provider/auth_provider.dart';

void authInjection() {
  // Register services
  locator.registerSingleton(AuthRemoteService());

  // Register providers
  locator.registerLazySingleton<AuthProvider>(
    () => AuthProvider(
      authRemoteService: locator<AuthRemoteService>(),
      userService: locator<UserService>(),
    ),
  );
}
