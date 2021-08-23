import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/shopping/category.dart';
import 'package:water/domain/service/category_service.dart';
import 'package:water/locator.dart';

part 'categories_event.dart';
part 'categories_state.dart';

extension BlocGetter on BuildContext {
  CategoriesBloc get categories => this.read<CategoriesBloc>();
}

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial());

  final CategoryService _categoryService = locator<CategoryService>();

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriesToState(event);
    }
  }

  Stream<CategoriesState> _mapLoadCategoriesToState(
    LoadCategories event,
  ) async* {
    print('load categories');
    yield CategoriesLoading(navigate: event.navigate);
    final categories = await _categoryService.getAll(event.language);
    yield CategoriesLoaded(categories: categories);
  }
}
