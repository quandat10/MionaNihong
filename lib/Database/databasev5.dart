import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:minnav2/Model/MindaV9Db/Ikanji.dart';
import 'package:minnav2/Model/ReadV5Db/ReadingModel.dart';
import 'package:minnav2/Model/ReadV5Db/ReshuuB.dart';
import 'package:minnav2/Model/ReadV5Db/Vocab.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



class DBProvider2 {
  DBProvider2._();

  static final DBProvider2 db = DBProvider2._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    // Construct a file path to copy database to
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "readv5_new.db");
    print("path" + path.toString());

// Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'read_v5.db'));
//      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      writeToFile(data, path);
      // Save copied asset to documents
//      await new File(path).writeAsBytes(bytes);

    }
    var departuresDatabase = await openDatabase(path);
    return departuresDatabase;
  }
  void writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytesSync(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<List<Vocab>> getAllID() async {
    final db = await database;
    var res = await db.query("tuvung");
    List<Vocab> list = res.isNotEmpty ? res.map((c) => Vocab.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Vocab>> getAllContentByLesson(int lesson) async {
    final db = await database;
    var res = await db.query("tuvung",where: "lesson_id = ?", whereArgs: [lesson]);
    List<Vocab> list = res.isNotEmpty ? res.map((c) => Vocab.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<ReadingModel>> getAllIDReading(int lesson) async {
    final db = await database;
    var res = await db.query("dulieu",where: "lesson_id = ?", whereArgs: [lesson]);
    List<ReadingModel> list = res.isNotEmpty ? res.map((c) => ReadingModel.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<ReshuuB>> getImageByLessonIdFromRenshuuB(int lesson) async {
    final db = await database;
    var res = await db.query("renshuub",where: "lesson_id = ?", whereArgs: [lesson]);
    List<ReshuuB> list = res.isNotEmpty ? res.map((c) => ReshuuB.fromMap(c)).toList() : [];
    return list;
  }



}