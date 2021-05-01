import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'global.dart';

class DatabaseCreator {
  StringBuffer sql = StringBuffer();

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    if (!await Directory(dirname(path)).exists()) {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath('ponto');
    dbMaster = await openDatabase(path,
        version: 1, onCreate: onCreate, onUpgrade: onUpgrade);
    print("Banco criado:");
    print(dbMaster);
  }

  Future<void> onCreate(Database db, int version) async {
    await createTable(db: db, version: version);
  }

  Future onUpgrade(Database db, int oldVersion, int newVersion) {}

  Future createTable({Database db, int version}) async {
    sql.write(" CREATE TABLE IF NOT EXISTS USUARIO ( ");
    sql.write(" id INTEGER PRIMARY KEY, ");
    sql.write(" login TEXT, ");
    sql.write(" senha TEXT, ");
    sql.write(" nome TEXT ) ");

    await db.execute(sql.toString());
  }
}
