import 'package:abdallatodoapp/cubits/navigation_bar_cubit.dart';
import 'package:abdallatodoapp/cubits/navigation_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../consts.dart';
import '../widgets/cutsomtff.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});




  Database? db;
  bool isShowen = false;
  Icon icon = Icon(Icons.edit, color: Colors.white,);
  GlobalKey<FormState>formkey = GlobalKey();
  TextEditingController title = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController date = TextEditingController();


  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

  @override
  void initState() {
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBarCubit(),
      child: BlocConsumer<NavigationBarCubit, NavigationBarState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            key: scaffoldkey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Center(
                  child: Text(
                    'T O D O  A P P',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                onPressed(context);
              },
              child: icon,
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu), label: 'M E N U'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'A R C H I V E'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.done_outline), label: 'D O N E'),
              ],
              elevation: 0,
              // useLegacyColorScheme: true,
              selectedFontSize: 10.0,
              currentIndex: NavigationBarCubit.get(context).index,
              backgroundColor: Colors.white,
              onTap: (int c) {
                NavigationBarCubit.get(context).ontap(c);
              },
            ),
             body:
              // tasks.length == 0
            //     ? Center(child: CircularProgressIndicator())
            //     :
              NavigationBarCubit.get(context).screensList[NavigationBarCubit.get(context).index],
          );
        },
      ),
    );
  }


  void onPressed(BuildContext context) {
    if (isShowen == false) {
      scaffoldkey.currentState?.showBottomSheet((context) =>
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(20), topStart: Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      CustomTFF(
                        textInputType: TextInputType.text,
                        textEditingController: title,
                        lable: 'Task Title',
                        isScure: false,
                        prefix: Icons.title
                        ,),
                      SizedBox(height: 20,),
                      CustomTFF(
                        ontap: () {
                          showTimePicker(
                            context: context, initialTime: TimeOfDay.now(),)
                              .then((onValue) {
                            time.text = onValue!.format(context);
                          }
                          );
                        },
                        textInputType: TextInputType.text,
                        textEditingController: time,
                        lable: 'Task Time',
                        isScure: false,
                        prefix: Icons.access_time_outlined
                        ,),
                      SizedBox(height: 20,),
                      CustomTFF(
                        ontap: () {
                          showDatePicker(context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.parse('2026-06-03')).then((
                              onValue) {
                            date.text = DateFormat.yMMMd().format(onValue!);
                          }
                          );
                        },
                        textInputType: TextInputType.text,
                        textEditingController: date,
                        lable: 'Task Date',
                        isScure: false,
                        prefix: Icons.date_range_outlined
                        ,)
                    ],
                  ),
                ),
              ),
            ),
          ),).closed.then((val) {
        insertdatabase(title: title.text, date: date.text, time: time.text);

        isShowen = false;
        // setState(() {
        //   icon = Icon(Icons.edit, color: Colors.white,);
        // });

      });
      isShowen = true;
      // setState(() {
      //   icon=Icon(Icons.add,color: Colors.white,);
      //
      // });
    }
    else {
      if (formkey.currentState!.validate()) {
        insertdatabase(title: title.text, date: date.text, time: time.text);
        Navigator.pop(context);
        isShowen = false;
        // setState(() {
        //   icon = Icon(Icons.edit, color: Colors.white,);
        // });
      }
    }
  }


  void createDatabase() async {
    db = await openDatabase('todo.db', version: 1,
        onCreate: (db, version) async {
          try {
            await db.execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT)');
            print('TableCreated');
          } catch (e) {
            print('Error when creating table${e.toString()}');
          }
        }, onOpen: (db) {
          getDataFromDatabase(db).then((val) {
            tasks = val;
            print(tasks);
          });
          print('database Opened');
        });
  }

  Future insertdatabase(
      {required String title, required String date, required String time}) async {
    await db!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO tasks(title, date, time,status) VALUES("$title", "$date", "$time","True")');
      print('inserted num1: $id1');
    });
  }


  Future<List<Map>> getDataFromDatabase(db) async {
    return await db.rawQuery('SELECT * FROM tasks');
  }

}

