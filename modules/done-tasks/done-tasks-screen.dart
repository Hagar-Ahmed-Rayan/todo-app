
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/modules/cubit/cubit.dart';
import 'package:todolist/modules/cubit/states.dart';
import 'package:todolist/shared/componets/componentscreen.dart';

class DoneTasks extends StatefulWidget {

  //_NewTsksState createState() => _NewTsksState();
  @override
  DoneTasksState createState() => DoneTasksState();
}

class DoneTasksState extends State<DoneTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: ( context,  state) {},
      builder: ( context,state)
      {
        var tasks=AppCubit.get(context).donetasks;
        return ListView.separated(
          itemBuilder: (context,index) => bulidTaskItem(tasks[index],context),
          separatorBuilder: (context,index) => Padding(
            padding:const EdgeInsetsDirectional.only(
              start:20.0,
            ),
            child:Container(
              width: double.infinity,
              height:1.0,
              color: Colors.grey,

            ),



          ),
          itemCount: tasks.length,);
      },

    );
  }
}
