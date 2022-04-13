import 'package:hive/hive.dart';
import 'package:todoapp/model/task.dart';

class Boxes{
  static Box<Task> getTasks() =>
      Hive.box<Task>('tasks');
}