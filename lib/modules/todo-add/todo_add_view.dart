import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/modules/todo-add/todo_add_controller.dart';
import 'package:todo_app/utils/widgets/1/textarea_widget.dart';
import 'package:todo_app/utils/widgets/1/textfield_widget.dart';

class TodoAddView extends StatelessWidget {
  final todoC = Get.find<TodoAddController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            todoC.isEdit.value != true ? Text('Add Task') : Text('Edit Task'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'lib/assets/images/taskempty.jpg',
                    width: 270,
                    filterQuality: FilterQuality.low,
                  ),
                ),
                Form(
                  key: todoC.formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        title: 'Title',
                        hinttext: 'Input',
                        value: todoC.todoObj.title,
                        onSaved: (val) {
                          todoC.todoObj.title = val;
                        },
                      ),
                      TextAreaWidget(
                        title: 'Description',
                        onSaved: (val) {
                          todoC.todoObj.description = val;
                        },
                        value: todoC.todoObj.description,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          todoC.onValidate();
        },
        child: todoC.isEdit.value != true ? Icon(Icons.add) : Icon(Icons.done),
      ),
    );
  }
}
