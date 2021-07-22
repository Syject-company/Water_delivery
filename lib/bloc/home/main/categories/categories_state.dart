part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();

  @override
  List<Object> get props => [];
}

class CategorySelected extends CategoriesState {
  const CategorySelected();

  @override
  List<Object> get props => [];
}
