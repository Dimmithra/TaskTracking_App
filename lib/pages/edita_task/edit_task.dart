import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasktrack/pages/home_page/homepage.dart';
import 'package:tasktrack/providers/task_provider.dart';
import 'package:tasktrack/utils/common_colors.dart';
import 'package:tasktrack/utils/common_loader.dart';
import 'package:tasktrack/utils/main_body.dart';
import 'package:provider/provider.dart';
import 'package:tasktrack/widgets/common_button.dart';
import 'package:tasktrack/widgets/common_textfeild.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({
    super.key,
    required this.taskid,
    required this.title,
    required this.discription,
    required this.taskdate,
    required this.tasktime,
  });
  final int taskid;
  final String title;
  final String discription;
  final String taskdate;
  final String tasktime;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).loadEditData(
        context,
        discription: widget.discription,
        title: widget.title,
        taskdate: widget.taskdate,
        tasktime: widget.tasktime,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      title: "Edit",
      automaticallyImplyLeading: true,
      iconThemeColor: kIconColor,
      body: SingleChildScrollView(
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            if (taskProvider.getloadSelectedData) {
              return const CommonLoader();
            }
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CommonTextFeild(
                    hinttext: 'Title',
                    label: 'Title',
                    controller: taskProvider.edittitleTxtController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: CommonTextFeild(
                    hinttext: 'Discription',
                    label: 'Discription',
                    controller: taskProvider.editdiscriptionTxtController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime(
                          DateTime.now().year + 50,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                        onChanged: (date) {
                          // print('change $date');
                        },
                        onConfirm: (date) {
                          taskProvider.editdateTxtController.text =
                              DateFormat('dd/MM/yyyy').format(date);
                        },
                        currentTime: DateTime.now(),
                      );
                    },
                    child: IgnorePointer(
                      ignoring: true,
                      child: CommonTextFeild(
                        label: "Task Date",
                        hinttext: "Task Date",
                        controller: taskProvider.editdateTxtController,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      DatePicker.showTime12hPicker(
                        context,
                        onConfirm: (time) {
                          taskProvider.edittimeTxtController.text =
                              DateFormat('HH:mm a').format(time);
                        },
                      );
                    },
                    child: IgnorePointer(
                      ignoring: true,
                      child: CommonTextFeild(
                        label: 'Task Time',
                        hinttext: 'Task Time',
                        controller: taskProvider.edittimeTxtController,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonBtn(
                        backgroundColor: Colors.blue.shade800,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        btnName: "Cancel",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: taskProvider.getloadUpdateData
                          ? const CommonLoader()
                          : CommonBtn(
                              onPress: () {
                                taskProvider.updateTaskRecords(
                                  context,
                                  taskid: widget.taskid,
                                  title: taskProvider
                                      .getedittitleTxtController.text,
                                  discription: taskProvider
                                      .geteditdiscriptionTxtController.text,
                                  taskdate: taskProvider
                                      .geteditdateTxtController.text,
                                  tasktime: taskProvider
                                      .getedittimeTxtController.text,
                                );
                              },
                              btnName: "Edit",
                            ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
