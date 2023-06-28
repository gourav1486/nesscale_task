part of 'invoice_list_bloc.dart';

abstract class InvoiceListState extends Equatable {
  const InvoiceListState();

  @override
  List<Object> get props => [];
}

class InvoiceListInitial extends InvoiceListState {}

class InvoiceListLoaded extends InvoiceListState {
  late List<Invoice> invoices;
  InvoiceListLoaded({required this.invoices});
  @override
  List<Object> get props => [invoices];
}

class InvoiceLoadingError extends InvoiceListState {
  late String error;
  InvoiceLoadingError({required this.error});
  @override
  List<Object> get props => [error];
}
