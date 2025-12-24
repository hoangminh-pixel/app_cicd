import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  late PageController pageController;
  MainBloc(super.initialState){
    pageController = PageController();
    on<UpdateSelectedIndex>(_mapUpdateSelectedIndex);
    on<UpdatePageChangeEvent>(_mapUpdatePageChangeEvent);
  }
  @override
  Future<void> close() async {
    pageController.dispose();
    return super.close();
  }

   void _mapUpdateSelectedIndex(
    UpdateSelectedIndex event,
    Emitter<MainState> emit,
  ) {
    final index = event.selectedIndex;
    emit(state.copyWith(
      selectedIndex: index,
    ));
    pageController.jumpToPage(index);
  }

  void _mapUpdatePageChangeEvent(
    UpdatePageChangeEvent event,
    Emitter<MainState> emit,
  ) {
    final pageChange = event.pageChange;
    int selectedIndex = pageChange;

    emit(state.copyWith(
      selectedIndex: selectedIndex,
    ));
  }
}
