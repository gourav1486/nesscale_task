import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'expand_tile_state.dart';

class ExpandTileCubit extends Cubit<bool> {
  ExpandTileCubit() : super(false);
  void expand() => emit(!state);
}
