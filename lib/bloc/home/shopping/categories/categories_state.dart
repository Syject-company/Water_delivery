part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading({required this.navigate});

  final bool navigate;

  @override
  List<Object> get props => [navigate];
}

class CategoriesLoaded extends CategoriesState {
  const CategoriesLoaded({required this.categories});

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}
