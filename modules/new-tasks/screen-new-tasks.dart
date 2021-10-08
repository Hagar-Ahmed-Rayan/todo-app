

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/modules/cubit/cubit.dart';
import 'package:todolist/modules/cubit/states.dart';
import 'package:todolist/shared/componets/componentscreen.dart';
import 'package:todolist/shared/componets/constants.dart';

class NewTsks extends StatefulWidget {
  const NewTsks({Key? key}) : super(key: key);

  @override
  _NewTsksState createState() => _NewTsksState();
}

class _NewTsksState extends State<NewTsks> {
  @override
  Widget build(BuildContext context) {












    return BlocConsumer<AppCubit, AppStates>(
    listener: ( context,  state) {},
    builder: ( context,state)
    {
         var tasks=AppCubit.get(context).newtasks;
         return tasksBuilder(tasks:tasks,context:context);
           //ListView.separated(
       //    itemBuilder: (context,index) => bulidTaskItem(tasks[index],context),
         //  separatorBuilder: (context,index) => Padding(
           //  padding:const EdgeInsetsDirectional.only(
          //     start:20.0,
          //   ),
          //   child:Container(
           //    width: double.infinity,
           //    height:1.0,
            //   color: Colors.grey,

            // ),



         //  ),
         //  itemCount: tasks.length,);


























    },

    );

  }
}
