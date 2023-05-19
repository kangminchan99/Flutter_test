import 'package:flutter/material.dart';
import 'package:flutter_test1/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// 사용자는 새로운 할 일을 추가할 수 있어야 합니다. 할 일은 제목과 완료 여부로 구성됩니다.
// 사용자는 할 일 목록을 볼 수 있어야 합니다. 목록은 제목과 해당 할 일의 완료 여부를 표시해야 합니다.
// 사용자는 할 일을 완료 또는 미완료 상태로 변경할 수 있어야 합니다.
// 사용자는 할 일을 삭제할 수 있어야 합니다.
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    homeController = HomeController();
  }

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  void update() => setState(() {});

  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 관리'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('추가하기'),
                    content: Column(
                      children: [
                        TextField(
                          controller: homeController.textEditingController,
                          decoration: const InputDecoration(hintText: '제목'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                update();
                                homeController.addTodo(); // 리스트에 추가
                                homeController.textEditingController
                                    .clear(); // 입력 필드 초기화
                                Navigator.pop(context);
                              },
                              child: const Text('확인'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('취소'),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // ReorderableListView.builder - 항목의 순서를 변경할 수 있게 해주는 위젯
      // onReorder 콜백을 사용하여 항목의 순서가 변경되었을 때 reorderList 함수를 호출하여
      // 항목의 위치를 업데이트하고 setState를 호출하여 UI를 다시 그린다.
      body: ReorderableListView.builder(
          itemCount: homeController.todoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              key: Key(homeController.todoList[index]),
              title: Text(homeController.todoList[index]),
              leading: Checkbox(
                value: homeController.todoCompletedList[index],
                onChanged: (value) {
                  update();
                  homeController.compleList(index);
                },
              ),
              trailing: IconButton(
                onPressed: () {
                  update();
                  homeController.delTodo(index);
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
          onReorder: (oldIndex, newIndex) {
            update();
            homeController.reorderList(oldIndex, newIndex);
          }),
    );
  }
}
