import 'package:get_it/get_it.dart';

import 'domain/service/auth_service.dart';
import 'domain/service/banner_service.dart';
import 'domain/service/category_service.dart';
import 'domain/service/notification_service.dart';
import 'domain/service/order_service.dart';
import 'domain/service/period_service.dart';
import 'domain/service/product_service.dart';
import 'domain/service/profile_service.dart';
import 'domain/service/support_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerSingleton<ProfileService>(ProfileService());
  locator.registerSingleton<BannerService>(BannerService());
  locator.registerSingleton<CategoryService>(CategoryService());
  locator.registerSingleton<ProductService>(ProductService());
  locator.registerSingleton<NotificationService>(NotificationService());
  locator.registerSingleton<PeriodService>(PeriodService());
  locator.registerSingleton<OrderService>(OrderService());
  locator.registerSingleton<SupportService>(SupportService());
}
