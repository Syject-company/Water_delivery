import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/promo_code/promo_code.dart';
import 'package:water/domain/services/promo_code_service.dart';
import 'package:water/locator.dart';
import 'package:water/utils/session.dart';

part 'promo_codes_event.dart';
part 'promo_codes_state.dart';

extension BlocGetter on BuildContext {
  PromoCodesBloc get promoCodes => this.read<PromoCodesBloc>();
}

class PromoCodesBloc extends Bloc<PromoCodesEvent, PromoCodesState> {
  PromoCodesBloc() : super(PromoCodesInitial());

  final PromoCodeService _promoCodeService = locator<PromoCodeService>();

  @override
  Stream<PromoCodesState> mapEventToState(
    PromoCodesEvent event,
  ) async* {
    if (event is ApplyPromoCode) {
      yield* _mapApplyPromoCodeToState(event);
    } else if (event is ResetPromoCode) {
      yield* _mapResetPromoCodeToState();
    }
  }

  Stream<PromoCodesState> _mapApplyPromoCodeToState(
    ApplyPromoCode event,
  ) async* {
    try {
      if (Session.isAuthenticated) {
        final promoCode = await _promoCodeService.getByCode(
          Session.token!,
          event.code,
        );

        if (promoCode.expireDate.isBefore(DateTime.now())) {
          yield PromoCodeExpired();
          return;
        }

        yield PromoCodeLoaded(promoCode: promoCode);
      }
    } catch (_) {
      yield PromoCodeNotExists();
    }
  }

  Stream<PromoCodesState> _mapResetPromoCodeToState() async* {
    yield PromoCodesInitial();
  }
}
