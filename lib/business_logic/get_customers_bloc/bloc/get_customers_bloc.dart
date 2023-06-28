import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nesscale_task/helper/database_helper.dart';

part 'get_customers_event.dart';
part 'get_customers_state.dart';

class GetCustomersBloc extends Bloc<GetCustomersEvent, GetCustomersState> {
  GetCustomersBloc() : super(GetCustomersInitial()) {
    on<GetCustomersListEvent>((event, emit) async {
      emit(GetCustomersInitial());
      try {
        var data = await DataBaseHelper.getCustomers();
        emit(GetCustomersList(customer: data));
      } catch (e) {
        emit(CustomerListError(error: e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
