import 'package:get_it/get_it.dart';

import 'domain/services/account_service.dart';
import 'domain/services/auth_service.dart';
import 'domain/services/banner_service.dart';
import 'domain/services/category_service.dart';
import 'domain/services/notification_service.dart';
import 'domain/services/order_service.dart';
import 'domain/services/period_service.dart';
import 'domain/services/product_service.dart';
import 'domain/services/profile_service.dart';
import 'domain/services/promo_code_service.dart';
import 'domain/services/subscription_service.dart';
import 'domain/services/support_service.dart';

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
  locator.registerSingleton<SubscriptionService>(SubscriptionService());
  locator.registerSingleton<SupportService>(SupportService());
  locator.registerSingleton<AccountService>(AccountService());
  locator.registerSingleton<PromoCodeService>(PromoCodeService());
}
