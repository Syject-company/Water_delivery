part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoriesEvent {
  const LoadCategories({
    required this.language,
    this.navigate = true,
  });

  final String language;
  final bool navigate;

  @override
  List<Object> get props => [language];
}
