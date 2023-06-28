import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_bar_indexx_cubit_state.dart';

class BottomNavigationBarIndexxCubitCubit
    extends Cubit<BottomNavigationBarIndexCubitState> {
  BottomNavigationBarIndexxCubitCubit()
      : super(BottomNavigationBarIndexCubitInitial());
  void changeIndex(index) => emit(IndexChanged(index: index));
}
