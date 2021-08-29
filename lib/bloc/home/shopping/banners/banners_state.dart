part of 'banners_bloc.dart';

abstract class BannersState extends Equatable {
  const BannersState();

  @override
  List<Object> get props => [];
}

class BannersInitial extends BannersState {
  const BannersInitial();
}

class BannersLoading extends BannersState {
  const BannersLoading();
}

class BannersLoaded extends BannersState {
  const BannersLoaded({required this.banners});

  final List<water.Banner> banners;

  @override
  List<Object> get props => [banners];
}
