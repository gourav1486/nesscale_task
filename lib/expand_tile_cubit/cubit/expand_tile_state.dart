part of 'expand_tile_cubit.dart';

abstract class ExpandTileState extends Equatable {
  const ExpandTileState();

  @override
  List<Object> get props => [];
}

class ExpandTileInitial extends ExpandTileState {}

class IsExpanded extends ExpandTileState {
  bool expanded = false;
  IsExpanded({required this.expanded});
 
}
