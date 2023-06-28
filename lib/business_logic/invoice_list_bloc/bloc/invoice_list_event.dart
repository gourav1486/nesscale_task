part of 'invoice_list_bloc.dart';

abstract class InvoiceListEvent extends Equatable {
  const InvoiceListEvent();

  @override
  List<Object> get props => [];
}

class GetInvoice extends InvoiceListEvent {
  GetInvoice();
}
