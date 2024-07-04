

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/achivescreen.dart';
import '../screens/donescreen.dart';
import '../screens/menuscreen.dart';
import 'navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarInitial());


  int index = 0;

  List<Widget> screensList = [
    Menuscreen(),
    Achivescreen(),
    Donescreen(),
  ];


  void ontap(ind)
  {
    index=ind;
    emit(NavigationBarCahngeState());
  }



  static NavigationBarCubit get(context)=>BlocProvider.of(context);



}
