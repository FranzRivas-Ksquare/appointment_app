import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

void initDB() async {
  final databasesPath = await getApplicationDocumentsDirectory();
  String path = '$databasesPath/appointments.db';
}

