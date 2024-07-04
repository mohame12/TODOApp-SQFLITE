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
  Icon icon = const Icon(Icons.edit, color: Colors.white,);

  List<Map> newtasks=[];
  List<Map> donetasks=[];
  List<Map> archivetasks=[];


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
          } catch (e) {
            debugPrint('Error when creating table${e.toString()}');
          }
        }, onOpen: (db) {
      emit(NavigationBarOPenDataBaseState());
          getDataFromDatabase(db);
          print('database Opened');
        }).then((VAL){db=VAL;emit(NavigationBarCreateDataBaseState());});
  }

  Future insertdatabase(
      {required String title, required String date, required String time}) async {
    await db?.transaction((txn)  => txn.rawInsert(
          'INSERT INTO tasks(title, date, time,status) VALUES("$title", "$date", "$time","True")').then((val){
            print('$val insertedSucessfully');
            emit(NavigationBarInsertDataBaseState());
            getDataFromDatabase(db);
            //     .then((val)
            // {
            //   tasks=val;
            //   print(tasks);
            //   emit(NavigationBarGetDataBaseState());
            // });
          
          }).catchError(
            (error)
        {
          print('there are an error $error');
        }));
  }


  void getDataFromDatabase(db)  {
    newtasks=[];
    donetasks=[];
    archivetasks=[];
     db.rawQuery('SELECT * FROM tasks').then((val) {
       tasks=val;
       tasks.forEach((element){
         if(element['status']=='True')
           {
             newtasks.add(element);
           }
         else if(element['status']=='done')
             {
               donetasks.add(element);
             }
         else if(element['status']=='Archive')
               {
                 archivetasks.add(element);
               }

       });
       emit(NavigationBarGetDataBaseState());
     });
  }


  void updateStatus({
    required String status,
    required int id
})

  {
     db!.rawUpdate(
        'UPDATE tasks SET status=? WHERE id = ?',
        [status, '$id']
    ).then((val)
     {
       getDataFromDatabase(db);
       emit(NavigationBarUpdateStatusDataBaseState());
     });
  }



  void deleteData({
    required int id
  })

  {
    db!.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id])
        .then((val)
    {
      getDataFromDatabase(db);
      emit(NavigationBarDeleteDataBaseState());
    });
  }

}
