

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/modules/archived-tasks/archived-tasks-screen.dart';
import 'package:todolist/modules/cubit/cubit.dart';
import 'package:todolist/modules/cubit/states.dart';
import 'package:todolist/modules/done-tasks/done-tasks-screen.dart';
import 'package:todolist/modules/new-tasks/screen-new-tasks.dart';
import 'package:todolist/shared/componets/componentscreen.dart';
import 'package:todolist/shared/componets/constants.dart';

class HomeLayout extends StatelessWidget {



  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  var scaffkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(

        create: (BuildContext context) => AppCubit()..createdatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
            if(state is Appinsertdatabasestate){
              Navigator.pop(context);
            }
          },
          builder: (BuildContext context, AppStates state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(

              key: scaffkey,

              appBar: AppBar(

                title: Text(

                  //(tasks.length).toString(),

                  cubit.titles[cubit.currindex],


                ),

              ),

              body: //ConditionalBuilder(

              //condition:tasks.length >0,

              //bulider:(context)=>  screens[currindex],

              //fallback:(context) => Center(child:CircularProgressIndicator())

              //),


              Conditional.single(

                  context: context,

                  conditionBuilder: (BuildContext context) => true,

                  widgetBuilder: (BuildContext context) =>
                  cubit.screens[cubit.currindex],

                  fallbackBuilder: (BuildContext context) =>
                      Center(child: CircularProgressIndicator())),


              floatingActionButton: FloatingActionButton(

                onPressed: () {
                 /// print(tasks.length);

                  print("jjjjjjjjjjjjjjjjkkkkkkkkkkkkkkkkkjjjjjjjjjjjjj");


                  if (cubit.isbottomsheetshown) {       //how mfto7 dlw2ty w  ana dost 3la elzorar
                    if (formkey.currentState!.validate()) {
                      //inserttodatabase(
                      print('yes');
                      cubit.inserttodatabase(titleController.text, timeController.text,dateController.text);
                      //titleController.text,

                      //timeController.text,

                      // dateController.text,


//  ).then((value){


                      // getDataFormDatabase(database).then((value){

                      // Navigator.pop(context);

                      //setState(() {


                      //isbottomsheetshown = false;


                      //fabIcon = Icons.edit;


                      //tasks = value;


                      //});

                      // });


                      //});


                    }
                  }



















                  else {  //kda ana ftto mn elzorar
                    scaffkey.currentState!.showBottomSheet(

                          (context) =>
                          Container(

                            color: Colors.grey,

                            padding: EdgeInsets.all(20.0),

                            child: Padding(

                              padding: const EdgeInsets.all(10.0),

                              child: Form(

                                key: formkey,

                                child: Column(

                                  mainAxisSize: MainAxisSize.min,

                                  children: [


                                    SizedBox(

                                      height: 15.0,

                                    ),

                                    defaultFormField(

                                      controller: titleController,

                                      type: TextInputType.text,

                                      validate: (value) {
                                        if (value
                                            .toString()
                                            .isEmpty) {
                                          return 'title must not be empty';
                                        }


                                        return null;
                                      },


                                      label: 'task title',

                                      prefix: Icons.title,

                                    ),

                                    SizedBox(

                                      height: 15.0,

                                    ),


                                    defaultFormField(


                                      controller: timeController,

                                      type: TextInputType.datetime,

                                      onTap: () {
                                        showTimePicker(


                                          context: context,

                                          initialTime: TimeOfDay.now(),


                                        ).then((value) {
                                          timeController.text =
                                              value!.format(context).toString();

                                          print(value.format(context));
                                        });
                                      },


                                      validate: (value) {
                                        if (value
                                            .toString()
                                            .isEmpty) {
                                          return 'time must not be empty';
                                        }


                                        return null;
                                      },


                                      label: 'time title',

                                      prefix: Icons.watch_later_outlined,

                                    ),


                                    SizedBox(

                                      height: 15.0,

                                    ),


                                    defaultFormField(


                                      controller: dateController,

                                      type: TextInputType.datetime,

                                      onTap: () {
                                        print(
                                            "jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");


                                        showDatePicker

                                          (


                                          context: context,

                                          initialDate:

                                          DateTime.now(),


                                          firstDate: DateTime.now(),

                                          lastDate: DateTime.parse(
                                              '2021-10-03'),


                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMd().format(value!);

                                          print(DateFormat.yMMMd().format(
                                              value) +
                                              "[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[");
                                        });
                                      },


                                      validate: (value) {
                                        if (value
                                            .toString()
                                            .isEmpty) {
                                          return 'date must not be empty';
                                        }


                                        return null;
                                      },


                                      label: 'task date',

                                      prefix: Icons.calendar_today,

                                    ),


                                  ],

                                ),

                              ),

                            ),

                          ),

                    ).closed.then((value) {  //aflto b2edy
                      // Navigator.pop(context);

                      cubit.changebottomsheetstate(isShow: false, icon: Icons.edit,);


                    });

                    cubit.changebottomsheetstate(isShow: true, icon: Icons.add,);



                  }
                },

                child: Icon(

                  cubit.fabIcon,

                ),

              ),


              bottomNavigationBar: BottomNavigationBar(

                type: BottomNavigationBarType.fixed,


                currentIndex: cubit.currindex,

                onTap: (index) {
                  cubit.changeindex(index);
                  //setState((){

                  //currindex=index;


                  //});

                  print(index);
                },

                items: [


                  BottomNavigationBarItem(

                      icon: Icon(

                        Icons.menu,

                      ),

                      label: 'new tasks'


                  ),

                  BottomNavigationBarItem(

                      icon: Icon(

                        Icons.check_circle_outline,

                      ),

                      label: 'done'


                  ),

                  BottomNavigationBarItem(

                      icon: Icon(

                        Icons.archive_outlined,

                      ),

                      label: 'archived'


                  ),


                ],


              ),


            );
          },
        )
    );
  }
}