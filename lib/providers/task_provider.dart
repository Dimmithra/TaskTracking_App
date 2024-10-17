import 'package:flutter/material.dart';
import 'package:tasktrack/database/database_helper.dart';
import 'package:tasktrack/models/task_model.dart';
import 'dart:developer' as dev;

import 'package:tasktrack/pages/home_page/homepage.dart';

class TaskProvider extends ChangeNotifier {
  final databaseConnection = DataBaseHelper();
  TextEditingController titleTxtController = TextEditingController();
  TextEditingController get gettitleTxtController => titleTxtController;

  TextEditingController discriptionTxtController = TextEditingController();
  TextEditingController get getdiscriptionTxtController =>
      discriptionTxtController;

  TextEditingController dateTxtController = TextEditingController();
  TextEditingController get getdateTxtController => dateTxtController;

  TextEditingController timeTxtController = TextEditingController();
  TextEditingController get gettimeTxtController => timeTxtController;

  // text edit controllers
  TextEditingController edittitleTxtController = TextEditingController();
  TextEditingController get getedittitleTxtController => edittitleTxtController;

  TextEditingController editdiscriptionTxtController = TextEditingController();
  TextEditingController get geteditdiscriptionTxtController =>
      editdiscriptionTxtController;

  TextEditingController editdateTxtController = TextEditingController();
  TextEditingController get geteditdateTxtController => editdateTxtController;

  TextEditingController edittimeTxtController = TextEditingController();
  TextEditingController get getedittimeTxtController => edittimeTxtController;

  TaskModel? taskModel;
  TaskModel? get gettaskModel => taskModel;
  settaskModel(val) {
    taskModel = val;
    notifyListeners();
  }

  clearData() async {
    gettitleTxtController.clear();
    getdiscriptionTxtController.clear();
    getdateTxtController.clear();
    gettimeTxtController.clear();
  }

  Future<void> createNewTask(context) async {
    setloadSaveData(true);
    try {
      settaskModel(null);
      var res = await databaseConnection.createNewTask(
        TaskModel(
          title: gettitleTxtController.text,
          discription: getdiscriptionTxtController.text,
          taskdate: getdateTxtController.text,
          tasktime: gettimeTxtController.text,
        ),
      );
      TaskModel temp = TaskModel();
      dev.log(temp.toMap().toString());
      if (res == 'success') {
        settaskModel(temp);

        final snackBar = SnackBar(
          content: Text('${res}'),
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {},
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('${res}'),
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      dev.log({e}.toString());
    } finally {
      setloadSaveData(false);
    }
  }

  bool loadSaveData = false;
  bool get getloadSaveData => loadSaveData;
  setloadSaveData(val) {
    loadSaveData = val;
    notifyListeners();
  }

  //get all data
  List<Map<String, dynamic>> data = [];

  Future<void> loadAllTasktRecords(context) async {
    setloadHomeData(true);
    try {
      // setcontactModel(null);
      List<Map<String, dynamic>> taskRecord =
          await databaseConnection.getAllData();
      data.clear();
      data.addAll(taskRecord);
      // data.sort((a, b) {
      //   final String nameA = a['lastName'].toString().toLowerCase();
      //   final String nameB = b['lastName'].toString().toLowerCase();
      //   return nameA.compareTo(nameB);
      // });
      // data.sort((a, b) =>
      //     (a['lastName'] as String).compareTo(b['lastName'] as String));
      dev.log("${taskRecord..toString()}");
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadHomeData(false);
    }
  }

  bool loadHomeData = false;
  bool get getloadHomeData => loadHomeData;
  setloadHomeData(val) {
    loadHomeData = val;
    notifyListeners();
  }

  //delete task details
  Future<void> deleteRecord(context, {required String taskid}) async {
    try {
      setloadDeleteRec(true);
      var res = await DataBaseHelper().deleteItem(taskid);
      notifyListeners();
      if (res == 'success') {
        final snackBar = SnackBar(
          content: Text('Task record Delete Success'),
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {},
          ),
        );
        loadAllTasktRecords(context);

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Task record Delete Fail'),
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      dev.log('$e');
    } finally {
      setloadDeleteRec(false);
    }
  }

  bool loadDeleteRec = false;
  bool get getloadDeleteRec => loadDeleteRec;
  setloadDeleteRec(val) {
    loadDeleteRec = val;
    notifyListeners();
  }

  //EDIT Task details

  bool loadSelectedData = false;
  bool get getloadSelectedData => loadSelectedData;
  setloadSelectedData(val) {
    loadSelectedData = val;
    notifyListeners();
  }

  Future<void> loadEditData(
    context, {
    required String title,
    required String discription,
    required String taskdate,
    required String tasktime,
  }) async {
    try {
      setloadSelectedData(true);
      edittitleTxtController.text = title;
      editdiscriptionTxtController.text = discription;
      editdateTxtController.text = taskdate;
      edittimeTxtController.text = tasktime;
    } catch (e) {
    } finally {
      setloadSelectedData(false);
    }
  }

  Future<void> updateTaskRecords(
    context, {
    required int taskid,
    required String title,
    required String discription,
    required String taskdate,
    required String tasktime,
  }) async {
    setloadUpdateData(true);
    try {
      var res = await DataBaseHelper().updateTaskRecorde(
        taskid,
        title,
        discription,
        taskdate,
        tasktime,
      );
      if (res == 'success') {
        final snackBar = SnackBar(
          content: Text('Task record modification Success'),
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {},
          ),
        );

        Navigator.pop(context);
        loadAllTasktRecords(context);

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('Task record modification Fail'),
          action: SnackBarAction(
            label: 'Done',
            onPressed: () {},
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      dev.log('$e');
    } finally {
      setloadUpdateData(false);
    }
  }

  bool loadUpdateData = false;
  bool get getloadUpdateData => loadUpdateData;
  setloadUpdateData(val) {
    loadUpdateData = val;
    notifyListeners();
  }
}
