import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todolist/modules/archived-tasks/archived-tasks-screen.dart';
import 'package:todolist/modules/cubit/states.dart';
import 'package:todolist/modules/done-tasks/done-tasks-screen.dart';
import 'package:todolist/modules/new-tasks/screen-new-tasks.dart';
import 'package:todolist/shared/componets/constants.dart';


class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

 static AppCubit get(context) =>BlocProvider.of(context);

  late Database database;
  List <Map> newtasks =[];
  List <Map> donetasks =[];
  List <Map> archivedtasks =[];
  int currindex=0;

  List<Widget>screens=[
    NewTsks(),
    DoneTasks(),
    Archived(),
  ];
  List<String>titles=[
    'New tasks',
    'done tasks',
    'archived tasks',
  ];
  bool isbottomsheetshown = false;
  IconData fabIcon = Icons.edit;



void changeindex (int index){
  currindex=index;
  emit(Appchangebottomnavbarstate());


}




  void createdatabase(){

     openDatabase(

//id int  //title string //date string //time string //status string//text=string
      'todo.db',
      version:1,
      onCreate:(database,version){
        print ("database created");
        database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT) ').then((value)  {
          print ('table created');
        }).catchError((error){
          print('error when creating table ${error.toString()}');
        }); //bktb feha sql statements which written in string w bt return future void
      },
      onOpen: (database){

        getDataFormDatabase(database);

        print("database opened");
      },

    ).then((value) {

      database=value;
      emit(Appcreatedatabasestate() );
     }



     );
  }












   void inserttodatabase(
      @required String title,
      @required String time,
      @required  String date,



      ) async {
     await database.transaction((txn){
      txn.rawInsert('INSERT INTO tasks(title,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print ('$value inserted successfuly');
        emit(Appinsertdatabasestate ());


        getDataFormDatabase(database);








      })
          .catchError((error){
        print('error when inserting table ${error.toString()}');

      });
      return null;
    });
  }





  void getDataFormDatabase(database)
  {
   newtasks =[];
      donetasks =[];
    archivedtasks =[];


     database.rawQuery('SELECT * FROM tasks').then((value){
       value.forEach((element) {
         if(element['status']=='new')
           newtasks.add(element);
         else if(element['status']=='done')
           donetasks.add(element);
         else if(element['status']=='archived')
           archivedtasks.add(element);

       });

      // tasks=value;
      // print(tasks.length);
       emit(Appgetdatabasestate ());

     });

  }






  void changebottomsheetstate ({
  required bool isShow,
    required IconData icon,


})
{

  isbottomsheetshown = isShow;
  fabIcon=icon;
  emit(Changebootomsheetstate());

}



void updateDate({

  required String status,
  required int id,


})  async
{
  database.rawUpdate('UPDATE tasks SET status = ? WHERE id =?',
      ['$status' ,id],
  ).then((value) {
    getDataFormDatabase(database);
     emit(Appupdatedatabasestate());
  });

}





  void deleteDate({


    required int id,


  })  async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ? ',
      [ id],
    ).then((value) {
      getDataFormDatabase(database);
      emit(Appdeletedatabasestate());
    });

  }

















//const HomeLayout({Key? key}) : super(key: key);











}
