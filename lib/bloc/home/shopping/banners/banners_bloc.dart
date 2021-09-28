import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/banner.dart' as water;
import 'package:water/domain/service/banner_service.dart';
import 'package:water/locator.dart';

part 'banners_event.dart';
part 'banners_state.dart';

extension BlocGetter on BuildContext {
  BannersBloc get banners => this.read<BannersBloc>();
}

class BannersBloc extends Bloc<BannersEvent, BannersState> {
  BannersBloc() : super(BannersInitial());

  final BannerService _bannerService = locator<BannerService>();

  final List<water.Banner> _cachedBanners = [];

  @override
  Stream<BannersState> mapEventToState(
    BannersEvent event,
  ) async* {
    if (event is LoadBanners) {
      yield* _mapLoadBannersToState(event);
    }
  }

  Stream<BannersState> _mapLoadBannersToState(
    LoadBanners event,
  ) async* {
    print('load banners');
    yield BannersLoading();

    if (_cachedBanners.isNotEmpty) {
      yield BannersLoaded(banners: _cachedBanners);
    }

    final banners = await _bannerService.getAll(event.language);
    yield BannersLoaded(banners: banners);
    _cachedBanners.addAll([...banners]);
  }
}
