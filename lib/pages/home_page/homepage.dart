import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tasktrack/pages/create_new_task/create_new_task.dart';
import 'package:tasktrack/pages/edita_task/edit_task.dart';
import 'package:tasktrack/providers/task_provider.dart';
import 'package:tasktrack/utils/common_colors.dart';
import 'package:tasktrack/utils/common_loader.dart';
import 'package:tasktrack/utils/main_body.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tasktrack/widgets/common_task_card.dart';
import 'dart:developer' as dev;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false)
          .loadAllTasktRecords(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      title: "All",
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: kIconColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreatNewTask(),
              ),
            );
          },
          child: FaIcon(
            FontAwesomeIcons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  CommontaskCard(
                    onTap: () {
                      // taskProvider.deleteRecord(context,
                      //     taskid: "${taskProvider.data[index]['taskid']}");
                      showSnackBarFun(
                        context,
                        taskid: taskProvider.data[index]['taskid'],
                        title: taskProvider.data[index]['title'],
                        discription: taskProvider.data[index]['discription'],
                        taskdate: taskProvider.data[index]['taskdate'],
                        tasktime: taskProvider.data[index]['tasktime'],
                      );
                    },
                    cardBody: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${taskProvider.data[index]['taskdate']}",
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            Text(
                              "${taskProvider.data[index]['tasktime']}",
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "${taskProvider.data[index]['title']}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${taskProvider.data[index]['discription']}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            itemCount: taskProvider.data.length,
          );
        },
      ),
    );
  }
}

showSnackBarFun(
  context, {
  required int taskid,
  String? title,
  String? discription,
  String? taskdate,
  String? tasktime,
}) {
  SnackBar snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return IconButton(
              onPressed: () {
                dev.log("Task ID ${taskid}");
                taskProvider.deleteRecord(context, taskid: "${taskid}");
              },
              icon: FaIcon(
                FontAwesomeIcons.trash,
                color: Colors.red.shade900,
              ),
            );
          },
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTaskScreen(
                  discription: discription.toString(),
                  taskid: taskid,
                  title: title.toString(),
                  taskdate: taskdate.toString(),
                  tasktime: tasktime.toString(),
                ),
              ),
            );
          },
          icon: FaIcon(
            FontAwesomeIcons.pen,
            color: kIconColor,
          ),
        )
      ],
    ),
    // style: TextStyle(fontSize: 20)),

    backgroundColor: Colors.white,
    dismissDirection: DismissDirection.vertical,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 180, left: 10, right: 10),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
