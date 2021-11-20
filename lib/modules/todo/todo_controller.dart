import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/utils/helper/image_helper.dart';

class TodoController extends GetxController {
  RxList<Todo> listTodo = <Todo>[].obs;
  RxList<Todo> listTodoDraft = <Todo>[].obs;
  int index = 0;

  
  Rx<int> indexTab = 0.obs;
  //indextab = 0/list
  //indextab = 1/arsip


  @override
  Future<void> onInit() async {
    await ImageHelper.loadImage(AssetImage('lib/assets/images/taskempty.jpg'));
    readDraft();

    if (GetStorage().read('id') != null) {
      index = GetStorage().read('id');
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

  readDraft() {
    var listDraftStr = GetStorage().read(
      'listtododraft',
    );

    var listDraftOnj = todoFromJson(listDraftStr);
    listTodoDraft.assignAll(listDraftOnj);
  }

  void checkAll() {
    if (indexTab.value == 1) {
      listTodoDraft.forEach((element) {
        element.complete = true;
      });
      listTodoDraft.refresh();
      GetStorage().write('listtododraft', jsonEncode(listTodoDraft));
    } else {
      listTodo.forEach((element) {
        element.complete = true;
      });
      listTodo.refresh();
    }
  }

  void uncheckAll() {
    if (indexTab.value == 1) {
      listTodoDraft.forEach((element) {
        element.complete = false;
      });
      listTodoDraft.refresh();
      GetStorage().write('listtododraft', jsonEncode(listTodoDraft));
    } else {
      listTodo.forEach((element) {
        element.complete = false;
      });
      listTodo.refresh();
    }
  }

  void removeAll() {
    if (indexTab.value == 1) {
      listTodoDraft.clear();
      GetStorage().write('listtododraft', jsonEncode(listTodoDraft));
      listTodoDraft.refresh();
    } else {
      listTodo.clear();
      listTodo.refresh();
    }
  }

  void addArchive(i) {
    listTodoDraft.add(i);
    GetStorage().write('listtododraft', jsonEncode(listTodoDraft));
    listTodo.removeWhere((element) => element == i);
  }

  void removeTask(index) {
    if (indexTab.value == 1) {
      listTodoDraft.removeWhere((element) => element.id == index);
      GetStorage().write('listtododraft', jsonEncode(listTodoDraft));
      listTodoDraft.refresh();
    } else {
      listTodo.removeWhere((element) => element.id == index);

      listTodo.refresh();
    }
  }

  void reorderList(oldIndex, newIndex, RxList<Todo> data) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    var item = data.removeAt(oldIndex);
    data.insert(newIndex, item);

    data.refresh();

    if (indexTab.value == 1) {
      GetStorage().write('listtododraft', jsonEncode(listTodoDraft));
    }
  }

  void isCheck(index, value) {
    if (indexTab.value == 1) {
      listTodoDraft[index].complete = value;
      listTodoDraft.refresh();
      GetStorage().write('listtododraft', jsonEncode(listTodoDraft));
    } else {
      listTodo[index].complete = value;
      listTodo.refresh();
    }
  }

  void removeArchive() {
    listTodoDraft.clear();
    listTodoDraft.refresh();

    if (listTodo.length == 0) {
      index = 0;
    }

    GetStorage().write('id', index);

    GetStorage().write('listtododraft', jsonEncode(listTodoDraft));
  }
}
