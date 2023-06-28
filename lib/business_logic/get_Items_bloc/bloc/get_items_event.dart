part of 'get_items_bloc.dart';

abstract class GetItemsEvent extends Equatable {
  const GetItemsEvent();

  @override
  List<Object> get props => [];
}

class GetItemsList extends GetItemsEvent {
  GetItemsList();
  @override
  List<Object> get props => [];
}
