part of 'get_customers_bloc.dart';

abstract class GetCustomersEvent extends Equatable {
  const GetCustomersEvent();

  @override
  List<Object> get props => [];
}

class GetCustomersListEvent extends GetCustomersEvent {
  GetCustomersListEvent();
  @override
  List<Object> get props => [];
}
