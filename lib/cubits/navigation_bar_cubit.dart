import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../screens/achivescreen.dart';
import '../screens/donescreen.dart';
import '../screens/menuscreen.dart';
import 'navigation_bar_state.dart';

class NavigationBarCubit extends Cubit<NavigationBarState> {
  NavigationBarCubit() : super(NavigationBarInitial());
  static NavigationBarCubit get(context)=>BlocProvider.of(context);

  Database? db;
  int index = 0;
  List<Map>tasks=[];
  bool isShowen = false;
  Icon icon = Icon(Icons.edit, color: Colors.white,);

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

  changeBootom({required bool isshow,required Icon con})
  {
    isShowen=isshow;
    icon=con;
    emit(FABChangeState());
  }


  void createDatabase() {
    openDatabase('todo.db', version: 1,
        onCreate: (db, version) async {
          try {
            await db.execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT)');
            print('TableCreated');
          } catch (e) {
            print('Error when creating table${e.toString()}');
          }
        }, onOpen: (db) {
      emit(NavigationBarOPenDataBaseState());
          getDataFromDatabase(db).then((val) {
            tasks = val;
            print(tasks);
            emit(NavigationBarGetDataBaseState());
          });
          print('database Opened');
        }).then((VAL){db=VAL;emit(NavigationBarCreateDataBaseState());});
  }

  Future insertdatabase(
      {required String title, required String date, required String time}) async {
    await db!.transaction((txn)  => txn.rawInsert(
          'INSERT INTO tasks(title, date, time,status) VALUES("$title", "$date", "$time","True")').then((val){emit(NavigationBarInsertDataBaseState());}));
  }


  Future<List<Map>> getDataFromDatabase(db) async {
    return await db.rawQuery('SELECT * FROM tasks');
  }



}
