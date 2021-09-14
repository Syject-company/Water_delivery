part of 'promo_codes_bloc.dart';

abstract class PromoCodesEvent extends Equatable {
  const PromoCodesEvent();

  @override
  List<Object> get props => [];
}

class ApplyPromoCode extends PromoCodesEvent {
  const ApplyPromoCode({required this.code});

  final String code;

  @override
  List<Object> get props => [code];
}

class ResetPromoCode extends PromoCodesEvent {
  const ResetPromoCode();
}
