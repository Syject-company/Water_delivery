import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/services/banner_service.dart';
import 'package:water/domain/services/category_service.dart';
import 'package:water/domain/services/product_service.dart';
import 'package:water/locator.dart';
import 'package:water/utils/local_storage.dart';
import 'package:water/utils/preload_image.dart';

part 'splash_event.dart';
part 'splash_state.dart';

extension BlocGetter on BuildContext {
  SplashBloc get splash => this.read<SplashBloc>();
}

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  final BannerService _bannerService = locator<BannerService>();
  final CategoryService _categoryService = locator<CategoryService>();
  final ProductService _productService = locator<ProductService>();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is PreloadImages) {
      yield* _mapPreloadImagesToState();
    } else if (event is LoadVideo) {
      yield* _mapLoadVideoToState();
    }
  }

  Stream<SplashState> _mapPreloadImagesToState() async* {
    try {
      yield const SplashLoading();

      final enBanners = await _bannerService.getAll('en');
      final arBanners = await _bannerService.getAll('ar');
      final categories = await _categoryService.getAll();
      final products = await _productService.getAll();

      final imagesToPreload = [
        ...enBanners.map((banner) => banner.image),
        ...arBanners.map((banner) => banner.image),
        ...categories.map((category) => category.imageUri),
        ...products.map((product) => product.imageUri),
      ];

      await Future.wait(imagesToPreload.map((image) {
        return preloadImage(CachedNetworkImageProvider(image));
      }));

      yield const ImagesPreloaded();
    } catch (_) {
      yield const SplashError();
    }
  }

  Stream<SplashState> _mapLoadVideoToState() async* {
    final firstLaunch = LocalStorage.firstLaunch ?? true;
    yield SplashVideo(firstLaunch: firstLaunch);
  }
}
