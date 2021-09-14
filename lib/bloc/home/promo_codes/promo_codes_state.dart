part of 'promo_codes_bloc.dart';

abstract class PromoCodesState extends Equatable {
  const PromoCodesState();

  @override
  List<Object> get props => [];
}

class PromoCodesInitial extends PromoCodesState {
  const PromoCodesInitial();
}

class PromoCodeLoaded extends PromoCodesState {
  const PromoCodeLoaded({required this.promoCode});

  final PromoCode promoCode;

  @override
  List<Object> get props => [promoCode];
}

class PromoCodeExpired extends PromoCodesState {
  const PromoCodeExpired();
}

class PromoCodeNotExists extends PromoCodesState {
  const PromoCodeNotExists();
}

class PromoCodeIsOver extends PromoCodesState {
  const PromoCodeIsOver();
}
