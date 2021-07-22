import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_event.dart';
part 'categories_state.dart';

extension BlocGetter on BuildContext {
  CategoriesBloc get categories => this.read<CategoriesBloc>();
}

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is LoadProducts) {
      yield* _mapLoadProductsToState(event);
    }
  }

  Stream<CategoriesState> _mapLoadProductsToState(LoadProducts event) async* {
    yield const CategorySelected();
  }
}
