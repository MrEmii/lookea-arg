import 'dart:async';
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/user_model.dart';

class LocalData {
  LocalData._();
  static final LocalData db = LocalData._();
  static UserModel user;
  static Database _database;

  static bool keepSession = true;

  Future<Database> get database async {
    if (_database != null)
    return _database;

    _database = await initDB();
    return _database;
  }


  initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, "l00k34.db");
    return await openDatabase(path, version: 2, onOpen: (db) {
    },
    onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS user_data (
          id TEXT PRIMARY_KEY,
          name         TEXT,
          lastname     TEXT,
          cellphone    TEXT,
          preference   TEXT,
          client       INTEGER,
          photo        TEXT,
          payments     TEXT
        );
      ''');
      await db.execute('''
        CREATE TABLE IF NOT EXISTS shop_data (
          id TEXT PRIMARY_KEY,
          username TEXT
        );
      ''');
    },
    onUpgrade: _onUpgrade
    );
  }


  debug() async {
    final db = await database;

    var res = await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    print(res);
  }

  removeSession() async {
    final db = await database;
    var user_db = await db.delete("user_data");
    print(user_db);
  }

  queryUser() async {
    final db = await database;
    var user_db = await db.query("user_data");
    return user_db;
  }

  updateUser(UserModel u) async{
    final db = await database;
    LocalData.user = u;
    await db.rawQuery("UPDATE user_data SET name = '${u.name}',lastname = '${u.lastname}',cellphone = '${u.cellphone}',preference = '${u.shopType}',client = '${u.isClient}',photo = '${u.photoUrl}',payments = '${json.encode(u.paymentsMethods)}'  WHERE id = '${user.id}'");
  }

  addUser(UserModel newUser) async {
    LocalData.user = newUser;
    final db = await database;
    print(newUser.toJson());
    await db.insert("user_data", newUser.toJson());
    keepSession = true;
  }

  void _onUpgrade (Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {

    }
  }
}
