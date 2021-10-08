import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:todolist/modules/cubit/cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
// Function onSubmit,
  //Function onChange,
  VoidCallback?  onTap,
   //GestureTapCallback? onTap,
  bool isPassword = false,
    required FormFieldValidator<String> validate,
  required String label,
  required IconData prefix,
  //IconData suffix,
  //Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
  //  onFieldSubmitted: onSubmit,
    // onChanged: onChange,
      onTap: onTap,
     validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
      // suffixIcon: suffix != null
        //    ? IconButton(
         // onPressed: suffixPressed,
        //icon: Icon(
         // suffix,
          //),
        //)
          //  : null,
        border: OutlineInputBorder(),
      ),
    );


Widget bulidTaskItem(Map model,context) =>
    Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text(
                '${model[
                  'time'
               ]}',
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
              '${model['title']}',

                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${model[
                      'date'
                          '']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            IconButton(
              onPressed: ()
              {
            AppCubit.get(context).updateDate(status: 'done', id:model['id']);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context).updateDate(status: 'archived', id:model['id']);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction){

        AppCubit.get(context).deleteDate(id:model['id'] ,);
      },
    );





//Conditional.single(

//context: context,

//conditionBuilder: (BuildContext context) => true,

//widgetBuilder: (BuildContext context) =>
//cubit.screens[cubit.currindex],

//fallbackBuilder: (BuildContext context) =>







Widget tasksBuilder({
  required List<Map> tasks,
     context
}) => Conditional.single(
  context: context,
  conditionBuilder: (BuildContext context) =>tasks.length > 0,
    widgetBuilder: (BuildContext context) => ListView.separated(
    itemBuilder: (context, index)
    {
      return bulidTaskItem(tasks[index], context);
    },
    separatorBuilder: (context, index) => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: tasks.length,
  ),
  fallbackBuilder: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);








