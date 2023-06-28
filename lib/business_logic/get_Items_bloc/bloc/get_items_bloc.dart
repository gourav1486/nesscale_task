import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nesscale_task/helper/database_helper.dart';

part 'get_items_event.dart';
part 'get_items_state.dart';

class GetItemsBloc extends Bloc<GetItemsEvent, GetItemsState> {
  GetItemsBloc() : super(GetItemsInitial()) {
    on<GetItemsList>((event, emit) async {
      emit(GetItemsInitial());
      try {
        var data = await DataBaseHelper.getItems();
        emit(ItemsLoadedState(itemsList: data));
      } catch (e) {
        emit(ItemLoadingError(error: e.toString()));    
      }
      // TODO: implement event handler
    });
  }
}
