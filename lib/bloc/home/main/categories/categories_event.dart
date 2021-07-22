part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();
}

class LoadProducts extends CategoriesEvent {
  const LoadProducts({required this.category});

  final String category;

  @override
  List<Object> get props => [category];
}
