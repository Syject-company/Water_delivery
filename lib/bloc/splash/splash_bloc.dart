import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/service/banner_service.dart';
import 'package:water/domain/service/category_service.dart';
import 'package:water/domain/service/product_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/local_storage.dart';

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
    } else if (event is Loading) {
      yield* _mapLoadingToState();
    } else if (event is LoadVideo) {
      yield* _mapLoadVideoToState();
    }
  }

  Stream<SplashState> _mapPreloadImagesToState() async* {
    try {
      final enBanners = await _bannerService.getAll('en');
      final arBanners = await _bannerService.getAll('ar');
      final categories = await _categoryService.getAll();
      final products = await _productService.getAll();

      yield ImagesPreloaded(images: [
        ...enBanners.map((banner) => banner.image),
        ...arBanners.map((banner) => banner.image),
        ...categories.map((category) => category.imageUri),
        ...products.map((product) => product.imageUri),
      ]);
    } catch (_) {
      yield SplashError();
    }
  }

  Stream<SplashState> _mapLoadingToState() async* {
    yield SplashLoading();
  }

  Stream<SplashState> _mapLoadVideoToState() async* {
    final firstLaunch = LocalStorage.firstLaunch ?? true;
    yield SplashVideo(firstLaunch: firstLaunch);
  }
}
