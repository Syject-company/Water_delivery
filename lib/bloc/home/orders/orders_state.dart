part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoaded extends OrdersState {
  const OrdersLoaded({required this.orders});

  final List<Order> orders;

  @override
  List<Object> get props => [orders];
}
