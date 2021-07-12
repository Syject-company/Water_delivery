import 'package:get_it/get_it.dart';
import 'package:water/domain/repository/user_repository.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<UserRepository>(UserRepository());
}
