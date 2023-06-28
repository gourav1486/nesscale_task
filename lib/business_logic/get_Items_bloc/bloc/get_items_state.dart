part of 'get_items_bloc.dart';

abstract class GetItemsState extends Equatable {
  const GetItemsState();

  @override
  List<Object> get props => [];
}

class GetItemsInitial extends GetItemsState {}

class ItemsLoadedState extends GetItemsState {
  List<Map<String, dynamic>> itemsList = [];
  ItemsLoadedState({required this.itemsList});
  @override
  List<Object> get props => [itemsList];
}

class ItemLoadingError extends GetItemsState {
  late String error;
  ItemLoadingError({required this.error});
  @override
  List<Object> get props => [error];
}
