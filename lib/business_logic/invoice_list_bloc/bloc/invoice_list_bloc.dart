import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nesscale_task/helper/database_helper.dart';
import 'package:nesscale_task/models/invoice_model.dart';

part 'invoice_list_event.dart';
part 'invoice_list_state.dart';

class InvoiceListBloc extends Bloc<InvoiceListEvent, InvoiceListState> {
  InvoiceListBloc() : super(InvoiceListInitial()) {
    on<GetInvoice>((event, emit) async {
      // TODO: implement event handler

      try {
        var data = await DataBaseHelper.getInvoices();
      
        emit(InvoiceListLoaded(invoices: data));
      } catch (e) {
     
        emit(InvoiceLoadingError(error: e.toString()));
      }
    });
  }
}
