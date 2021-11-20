import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/modules/todo/todo_controller.dart';
import 'package:todo_app/utils/widgets/2/slidable_widget.dart';

class TodoView extends StatelessWidget {
  TodoView({Key? key}) : super(key: key);

  final controller = Get.find<TodoController>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Todo App'),
            leading: Padding(
              padding: EdgeInsets.only(left: 20),
              child: PopupMenuButton(
                padding: EdgeInsets.only(left: 0),
                itemBuilder: (context) => [
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            controller.checkAll();
                            Navigator.pop(context);
                          },
                          child: Text('Check All Task'))),
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            controller.uncheckAll();
                            Navigator.pop(context);
                          },
                          child: Text('Uncheck All Task'))),
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            controller.removeAll();
                            Navigator.pop(context);
                          },
                          child: Text('Remove All Task'))),
                  PopupMenuItem(
                      child: TextButton(
                          onPressed: () {
                            controller.removeArchive();
                            Navigator.pop(context);
                          },
                          child: Text('Remove All Archive')))
                ],
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/todo-add', arguments: [false]);
                  },
                  child: Icon(
                    Icons.add,
                    size: 26.0,
                  ),
                ),
              ),
            ],
          ),
          body: ContainedTabBarView(
            tabs: [
              Icon(
                Icons.task,
                color: Colors.blue,
              ),
              Icon(
                Icons.archive,
                color: Colors.blue,
              ),
            ],
            views: [
              Container(
                child: Obx(() => listTask(controller.listTodo)),
              ),
              Container(
                child: Obx(
                  () => listTask(controller.listTodoDraft),
                ),
              ),
            ],
            onChange: (index) {
              controller.indexTab.update((val) {
                controller.indexTab.value = index;
              });
              controller.listTodoDraft.refresh();
              controller.listTodo.refresh();
            },
          ),
        ),
      ),
    );
  }

  listTask(data) {
    if (data.length != 0) {
      return ReorderableListView.builder(
        onReorder: (int oldIndex, int newIndex) {
          controller.reorderList(oldIndex, newIndex, data);
        },
        itemCount: data.length,
        itemBuilder: (context, int index) {
          return Container(
            key: Key('${data[index].id}'),
            padding: EdgeInsets.only(top: 10),
            child: SlideWidget(
              id: data[index].id,
              i: data[index],
              archive: controller.indexTab.value,
              widget: Container(
                child: Material(
                  child: InkWell(
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text('Title :${data[index].title}'),
                          subtitle:
                              Text('Description :${data[index].description}'),
                          activeColor: Colors.green[300],
                          value: data[index].complete,
                          onChanged: (val) {
                            controller.isCheck(index, val);
                          },
                          secondary: Text(' index :${data[index].id}'),
                        ),
                      ],
                    ),
                  ),
                ),
                color: Colors.blue[400],
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: controller.indexTab.value == 0
            ? Text('List is Empty , Try add some data ! ')
            : Text('Draft is Empty , Try add some data ! '),
      );
    }
  }
}
