import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer' as dev;

import 'package:tasktrack/models/task_model.dart';

class DataBaseHelper {
  final databaseName = "tasktracker.db";

  String user = '''
  CREATE TABLE taskdetails(
    taskid  INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    discription TEXT,
    taskdate TEXT,
    tasktime TEXT
  )
  ''';

  //SQL  data base connection
  Future<Database> initDB() async {
    final databasepath = await getDatabasesPath();
    final path = join(databasepath, databaseName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(user);
      },
    );
  }

  //insert new task
  Future<String> createNewTask(TaskModel taskModel) async {
    try {
      final Database db = await initDB();
      var res = await db.insert("taskdetails", taskModel.toMap());
      dev.log(
        res.toString(),
      );
      return 'success';
    } catch (e) {
      return 'New task create fail ${e}';
    }
  }

  //get all task records
  Future<List<Map<String, dynamic>>> getAllData() async {
    final Database db = await initDB();
    return await db.query("taskdetails");
  }

  //delete task
  Future<String> deleteItem(String taskid) async {
    final Database db = await initDB();
    try {
      await db.delete('taskdetails', where: 'taskid = ?', whereArgs: [taskid]);
      return "success";
    } catch (e) {
      return '$e';
    }
  }

  //update
  Future<String> updateTaskRecorde(
    int taskid,
    String title,
    String discription,
    String taskdate,
    String tasktime,
  ) async {
    // final db = await DatabaseHelper.instance.database;
    final Database db = await initDB();
    try {
      await db.update(
        'taskdetails',
        {
          'taskid': taskid,
          'title': title,
          'discription': discription,
          'taskdate': taskdate,
          'tasktime': tasktime
        },
        where: 'taskid = ?',
        whereArgs: [taskid],
      );
      dev.log(
        "ID::${taskid},title:${title},discription:${discription},taskdate:${taskdate},email:${tasktime}",
      );
      return 'success';
    } catch (e) {
      return '$e';
      // dev.log('$e');
    }
  }
}
