part of 'main_bloc.dart';

abstract class MainEvent {}

class UpdateSelectedIndex extends MainEvent {
  final int selectedIndex;

  UpdateSelectedIndex({required this.selectedIndex});
}

class UpdatePageChangeEvent extends MainEvent {
  final int pageChange;

  UpdatePageChangeEvent({required this.pageChange});
}