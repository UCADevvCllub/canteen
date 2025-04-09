import 'package:canteen/core/config/di.dart';
import 'package:canteen/core/data/service/user_service.dart';
import 'package:canteen/features/schedule/data/schedule_service.dart';
import 'package:canteen/features/schedule/presentation/provider/schedule_provider.dart';

void scheduleInjection() {
  locator.registerLazySingleton<ScheduleService>(
    () => ScheduleService(),
  );

  locator.registerFactory<ScheduleProvider>(
    () => ScheduleProvider(
      locator<ScheduleService>(),
      locator<UserService>(),
    ),
  );
}
