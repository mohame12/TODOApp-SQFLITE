import 'package:abdallatodoapp/cubits/blocObserver.dart';
import 'package:abdallatodoapp/screens/homescreen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
void main()
{
  Bloc.observer=MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  );
  }
}
