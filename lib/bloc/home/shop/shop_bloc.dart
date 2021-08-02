import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/shop/category.dart';
import 'package:water/domain/model/home/shop/product.dart';
import 'package:water/domain/model/home/shop/sale.dart';
import 'package:water/ui/constants/paths.dart';

part 'shop_event.dart';
part 'shop_state.dart';

extension BlocGetter on BuildContext {
  ShopBloc get shop => this.read<ShopBloc>();
}

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(CategoriesLoaded(categories: _categories));

  @override
  Stream<ShopState> mapEventToState(ShopEvent event) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriesToState();
    } else if (event is LoadProducts) {
      yield* _mapLoadProductsToState(event);
    }
  }

  Stream<ShopState> _mapLoadCategoriesToState() async* {
    yield CategoriesLoaded(categories: _categories);
  }

  Stream<ShopState> _mapLoadProductsToState(LoadProducts event) async* {
    yield ProductsLoaded(products: event.products);
  }
}

const List<Category> _categories = [
  Category(
    id: '1',
    imageUri: Paths.bottle_1500ml,
    title: '1.5 Liter Bottles',
    products: <Product>[
      Product(
        id: '1',
        imageUri: Paths.bottle_1500ml_p6,
        price: 15.0,
        volume: 1.5,
        categoryId: '',
        sale: Sale(
          id: '1',
          title: 'Title',
          percent: 0.35,
          description: 'Description',
        ),
        title: 'title.bottle_1500_12_c',
        description: 'description.bottle_1500_12_c',
      ),
      Product(
        id: '2',
        imageUri: Paths.bottle_1500ml_p6,
        price: 15.0,
        volume: 1.5,
        categoryId: '',
        sale: Sale(
          id: '1',
          title: 'Title',
          percent: 0.35,
          description: 'Description',
        ),
        title: 'title.bottle_1500_6_sp',
        description: 'description.bottle_1500_6_sp',
      ),
    ],
  ),
  Category(
    id: '2',
    imageUri: Paths.bottle_500ml,
    title: '500ml Bottles',
    products: <Product>[
      Product(
        id: '3',
        imageUri: Paths.bottle_500ml_p24,
        price: 20.0,
        volume: 0.5,
        categoryId: '',
        title: 'title.bottle_500_24_c',
        description: 'description.bottle_500_24_c',
      ),
      Product(
        id: '4',
        imageUri: Paths.bottle_500ml_p24,
        price: 20.0,
        volume: 0.5,
        categoryId: '',
        title: 'title.bottle_500_24_sp',
        description: 'description.bottle_500_24_sp',
      ),
      Product(
        id: '5',
        imageUri: Paths.bottle_500ml_p12,
        price: 15.0,
        volume: 0.5,
        categoryId: '',
        title: 'title.bottle_500_12_sp',
        description: 'description.bottle_500_12_sp',
      ),
      Product(
        id: '6',
        imageUri: Paths.bottle_500ml_p6,
        price: 12.0,
        volume: 0.5,
        categoryId: '',
        title: 'title.bottle_500_6_sp',
        description: 'description.bottle_500_6_sp',
      ),
    ],
  ),
  Category(
    id: '3',
    imageUri: Paths.bottle_330ml,
    title: '330ml Bottles',
    products: <Product>[
      Product(
        id: '7',
        imageUri: Paths.bottle_330ml_p24,
        price: 25.0,
        volume: 0.33,
        categoryId: '',
        title: 'title.bottle_330_24_c',
        description: 'description.bottle_330_24_c',
      ),
      Product(
        id: '8',
        imageUri: Paths.bottle_330ml_p24,
        price: 25.0,
        volume: 0.33,
        categoryId: '',
        title: 'title.bottle_330_24_sp',
        description: 'description.bottle_330_24_sp',
      ),
      Product(
        id: '9',
        imageUri: Paths.bottle_330ml_p12,
        price: 18.0,
        volume: 0.33,
        categoryId: '',
        title: 'title.bottle_330_12_sp',
        description: 'description.bottle_330_12_sp',
      ),
      Product(
        id: '10',
        imageUri: Paths.bottle_330ml_p6,
        price: 15.0,
        volume: 0.33,
        categoryId: '',
        title: 'title.bottle_330_6_sp',
        description: 'description.bottle_330_6_sp',
      ),
    ],
  ),
  Category(
    id: '4',
    imageUri: Paths.mini_cup,
    title: 'Miniature Cups',
    products: <Product>[
      Product(
        id: '11',
        imageUri: Paths.mini_cup_200ml,
        price: 15.0,
        volume: 0.2,
        categoryId: '',
        title: 'title.mini_cup_200_36_c',
        description: 'description.mini_cup_200_36_c',
      ),
      Product(
        id: '12',
        imageUri: Paths.mini_cup_125ml,
        price: 12.0,
        volume: 0.125,
        categoryId: '',
        title: 'title.mini_cup_125_48_c',
        description: 'description.mini_cup_125_48_c',
      ),
      Product(
        id: '13',
        imageUri: Paths.mini_cup_100ml,
        price: 10.0,
        volume: 0.1,
        categoryId: '',
        title: 'title.mini_cup_100_48_c',
        description: 'description.mini_cup_100_48_c',
      ),
    ],
  ),
];
