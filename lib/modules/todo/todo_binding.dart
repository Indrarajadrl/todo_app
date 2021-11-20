import 'package:get/get.dart';
import 'package:todo_app/modules/todo/todo_controller.dart';

class TodoBondings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodoController>(() => TodoController(), fenix: true);
  }
}
