part of 'bottom_navigation_bar_indexx_cubit_cubit.dart';

@immutable
abstract class BottomNavigationBarIndexCubitState {}

class BottomNavigationBarIndexCubitInitial
    extends BottomNavigationBarIndexCubitState {}

class IndexChanged extends BottomNavigationBarIndexCubitState {
  late int index;
  IndexChanged({required this.index});
   @override
  List<Object> get props => [index];
}
