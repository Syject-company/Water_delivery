import 'package:get_it/get_it.dart';
import 'package:water/domain/service/auth_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(AuthService());
}
