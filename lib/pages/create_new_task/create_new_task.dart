import 'package:flutter/material.dart';
import 'package:tasktrack/providers/task_provider.dart';
import 'package:tasktrack/utils/common_colors.dart';
import 'package:tasktrack/utils/common_loader.dart';
import 'package:tasktrack/utils/main_body.dart';
import 'package:tasktrack/widgets/common_button.dart';
import 'package:tasktrack/widgets/common_textfeild.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CreatNewTask extends StatefulWidget {
  const CreatNewTask({super.key});

  @override
  State<CreatNewTask> createState() => _CreatNewTaskState();
}

class _CreatNewTaskState extends State<CreatNewTask> {
  final formKey = GlobalKey<FormState>();
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).clearData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainBody(
      title: 'New Task',
      automaticallyImplyLeading: true,
      iconThemeColor: kIconColor,
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonTextFeild(
                        hinttext: "Title",
                        label: "Title",
                        maxLength: 50,
                        validation: true,
                        controller: taskProvider.titleTxtController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CommonTextFeild(
                        hinttext: "Discription",
                        label: "Discription",
                        maxLength: 150,
                        maxLines: 3,
                        controller: taskProvider.discriptionTxtController,
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
                              taskProvider.dateTxtController.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                            },
                            currentTime: DateTime.now(),
                          );
                        },
                        child: IgnorePointer(
                          ignoring: true,
                          child: CommonTextFeild(
                            label: 'Date',
                            hinttext: "",
                            validation: true,
                            controller: taskProvider.dateTxtController,
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
                              taskProvider.timeTxtController.text =
                                  DateFormat('HH:mm a').format(time);
                            },
                          );
                        },
                        child: IgnorePointer(
                          ignoring: true,
                          child: CommonTextFeild(
                            label: 'Time',
                            hinttext: "",
                            controller: taskProvider.timeTxtController,
                          ),
                        ),
                      ),
                    ),
                    taskProvider.getloadSaveData
                        ? CommonLoader()
                        : CommonBtn(
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                taskProvider.createNewTask(context);
                              }
                            },
                            btnName: "Save",
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
