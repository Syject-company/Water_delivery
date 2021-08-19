import 'package:get_it/get_it.dart';

import 'domain/service/auth_service.dart';
import 'domain/service/category_service.dart';
import 'domain/service/product_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<CategoryService>(CategoryService());
  locator.registerSingleton<ProductService>(ProductService());
}
