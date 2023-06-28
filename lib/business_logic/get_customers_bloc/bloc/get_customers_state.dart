part of 'get_customers_bloc.dart';

abstract class GetCustomersState extends Equatable {
  const GetCustomersState();

  @override
  List<Object> get props => [];
}

class GetCustomersInitial extends GetCustomersState {}

class GetCustomersList extends GetCustomersState {
  List<Map<String, dynamic>> customer = [];
  GetCustomersList({required this.customer});
  @override
  List<Object> get props => [customer];
}

class CustomerListError extends GetCustomersState {
  late String error;
  CustomerListError({required this.error});
  @override
  List<Object> get props => [error];
}
