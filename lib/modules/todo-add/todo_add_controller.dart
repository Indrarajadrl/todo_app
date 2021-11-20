import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/modules/todo/todo_controller.dart';
import 'package:todo_app/utils/notification/notification_widget.dart';

class TodoAddController extends GetxController {
  final todoC = Get.find<TodoController>();
  final formKey = GlobalKey<FormState>();
  List arguments = Get.arguments;

  RxBool isEdit = false.obs;
  Todo todoObj = Todo();

  @override
  void onInit() {
    isEdit.value = arguments[0];
    if (isEdit.value == true) {
      todoObj = arguments[1];
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onValidate() {
    final FormState? form = formKey.currentState;

    if (form != null) {
      if (form.validate()) {
        onSave(form);
      } else {
        print('Form is invalid');
      }
    }
  }

  void onSave(form) async {
    form.save();
    addTask();
  }

  addTask() {
    if (isEdit.value == true) {
      if (todoC.indexTab.value == 1) {
        GetStorage().write('listtododraft', jsonEncode(todoC.listTodoDraft));
        DialogbarCustom.dialogSuccess('Success', 'Task Updated.');
      } else {
        DialogbarCustom.dialogSuccess('Success', 'Task Updated.');
      }
    } else {
      todoObj.id = todoC.index++;
      GetStorage().write('id', todoC.index);
      todoObj.complete = false;
      todoC.listTodo.add(todoObj);
      DialogbarCustom.dialogSuccess('Success', 'Task added into list.');
    }
  }
}
