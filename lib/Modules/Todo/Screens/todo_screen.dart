import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/Modules/screens/home_page.dart';
import 'package:weather_app/repository/repo.dart';

import '../Controllers/todo_controller.dart';
import '../models/todo_model.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // final controller = Get.put(TodoController());
  final repo = Repo();
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              key: const Key('input_name'),
              validator: (value) => value!.isEmpty ? 'input' : null,
              controller: repo.txtName,
              decoration: InputDecoration(
                errorText: repo.isValidateName == true ? repo.validName : '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintStyle: const TextStyle(
                  decorationColor: Colors.amber,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue,
                  backgroundColor: Colors.pink,
                ),
                labelText: "Name",
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.person),
              ),
              style: const TextStyle(color: Colors.black),
              onFieldSubmitted: (e) {
                if (repo.txtName.text == '') {
                  repo.isValidateName = true;
                } else {
                  repo.isValidateName = false;
                  if (repo.txtName.value.text != repo.todoModel.name) {
                    repo.txtName.clear();
                    repo.txtGender.clear();
                    debugPrint('succenss=----${repo.todoModel}');
                  }
                  repo.todoList.add(TodoModel(
                    id: repo.id++,
                    name: repo.txtName.text,
                    gender: repo.txtGender.text,
                  ));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextFormField(
              key: const Key('input_gender'),
              style: const TextStyle(color: Colors.black),
              validator: (value) => value!.isEmpty ? 'input' : null,
              controller: repo.txtGender,
              decoration: InputDecoration(
                errorText:
                    repo.isValidateGender == true ? repo.validGender : '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  // borderSide: BorderSide.none,
                ),
                labelText: "Gender",
                floatingLabelStyle:
                    const TextStyle(height: 4, color: Colors.green),
                filled: true,
                fillColor: Colors.grey[200],
                prefixIcon: const Icon(Icons.person),
              ),
              onFieldSubmitted: (e) {
                if (repo.txtGender.text == '') {
                  repo.isValidateGender = true;
                } else {
                  repo.isValidateGender = false;
                  repo.todoList.add(TodoModel(
                    id: repo.id++,
                    name: repo.txtName.text,
                    gender: repo.txtGender.text,
                  ));
                  repo.txtName.clear();
                  repo.txtGender.clear();
                }
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          //   child: TextFormField(
          // style: const TextStyle(color: Colors.black),
          //     onChanged: (e) {
          //       controller.onfilter(e);
          //     },
          //     decoration: InputDecoration(
          //       errorText: controller.isValidateGender.value == true
          //           ? controller.validGender
          //           : '',
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(15.0),
          //         // borderSide: BorderSide.none,
          //       ),
          //       labelText: "test",
          //       floatingLabelStyle:
          //           const TextStyle(height: 4, color: Colors.green),
          //       filled: true,
          //       fillColor: Colors.grey[200],
          //       prefixIcon: const Icon(Icons.person),
          //     ),
          //   ),
          // ),

          ElevatedButton(
            key: const Key('tap_add'),
            onPressed: () {
              if (repo.txtName.text == '' && repo.txtGender.text == '') {
                repo.isValidateName = true;
                repo.isValidateGender = true;
              } else {
                repo.isValidateName = false;
                repo.isValidateGender = false;

                if (repo.todoList
                    .map((todo) => todo.name)
                    .contains(repo.txtName.text)) {
                  debugPrint('duplicate');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Dublicate value',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  // repo.addtoList(TodoModel(
                  //   id: repo.id++,
                  //   name: repo.txtName.text,
                  //   gender: repo.txtGender.text,
                  // ));
                  repo.addList(
                      isEdit,
                      TodoModel(
                        id: repo.id++,
                        name: repo.txtName.text,
                        gender: repo.txtGender.text,
                      ));

                  repo.txtName.clear();
                  repo.txtGender.clear();
                  setState(() {});
                }
              }
            },
            child: Text(
              'Add',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 16),
            ),
          ),
          TextButton(
              key: const Key('gohome'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePages(),
                  ),
                );
              },
              child: const Text('Go Home')),
          ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: repo.todoList.length,
              itemBuilder: (context, index) {
                var list = repo.todoList[index];
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          '${list.id}.',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              list.name.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              list.gender.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextButton(
                        key: const Key('remove'),
                        onPressed: () {
                          repo.onRemove(TodoModel(
                              id: list.id,
                              name: list.name,
                              gender: list.gender));
                        },
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        key: const Key('edit'),
                        onPressed: () {
                          isEdit = true;

                          debugPrint('heli:$isEdit ===');
                          repo.getItem(list.id!);

                          // repo.editTodo(
                          //   TodoModel(
                          //       id: list.id,
                          //       name: list.name,
                          //       gender: list.gender),
                          //   TodoModel(
                          //       id: list.id,
                          //       name: repo.txtName.text,
                          //       gender: repo.txtGender.text),
                          // );
                          setState(() {});
                        },
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              })
          // SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       ...controller.todoList.asMap().entries.map((e) {
          //         return
          //       })
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
