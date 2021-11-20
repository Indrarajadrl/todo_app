import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_app/modules/todo/todo_controller.dart';
import 'package:todo_app/utils/notification/notification_widget.dart';

class SlideWidget extends StatelessWidget {
  final todoC = Get.find<TodoController>();

  final Widget widget;
  final int id;
  final int archive;

  final i;

  SlideWidget({
    Key? key,
    required this.archive,
    required this.id,
    this.i,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    if (archive == 0) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          child: widget,
        ),
        actions: [
          IconSlideAction(
              caption: 'Archive',
              color: Colors.blue,
              icon: Icons.archive,
              onTap: () {
                todoC.addArchive(i);
                DialogbarCustom.snackBar(context, 'added to archive');
              }),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: 'Edit',
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {
                Get.toNamed('/todo-add', arguments: [true, i]);

                todoC.listTodo.refresh();
              }),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              todoC.removeTask(id);
              DialogbarCustom.snackBar(context, 'Deleted from list');
            },
          ),
        ],
      );
    } else {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          child: widget,
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: 'Edit',
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {
                Get.toNamed('/todo-add', arguments: [true, i]);

                todoC.listTodo.refresh();
              }),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              todoC.removeTask(id);
              DialogbarCustom.snackBar(context, 'Deleted from list');
            },
          ),
        ],
      );
    }
  }
}
