import 'package:get/get.dart';
import 'package:todo_app/modules/todo-add/todo_add_controller.dart';

class TodoAddBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(TodoAddController());
  }
}
