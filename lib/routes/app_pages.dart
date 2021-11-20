import 'package:get/get.dart';
import 'route_index.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: RouteName.todo,
      page: () => TodoView(),
    ),
    GetPage(
      name: RouteName.todoadd,
      page: () => TodoAddView(),
      binding: TodoAddBindings(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 500),
    ),
  ];
}
