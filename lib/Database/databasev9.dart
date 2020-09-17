import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:minnav2/Model/MindaV9Db/Bunkei.dart';
import 'package:minnav2/Model/MindaV9Db/Data.dart';
import 'package:minnav2/Model/MindaV9Db/Grammar.dart';
import 'package:minnav2/Model/MindaV9Db/Ikanji.dart';
import 'package:minnav2/Model/MindaV9Db/Kaiwa.dart';
import 'package:minnav2/Model/MindaV9Db/Kana.dart';
import 'package:minnav2/Model/MindaV9Db/Kanji.dart';
import 'package:minnav2/Model/MindaV9Db/Mondai.dart';
import 'package:minnav2/Model/MindaV9Db/Reference.dart';
import 'package:minnav2/Model/MindaV9Db/Reibun.dart';
import 'package:minnav2/Model/MindaV9Db/kotoba.dart';
import 'package:minnav2/Model/ReadV5Db/ReshuuB.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

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
    String path = join(documentsDirectory.path, "minnav9_new.db");
    print("path" + path.toString());

// Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'minna_v9.db'));
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

  Future<List<Kanji>> getCententWord(String word) async {
    final db = await database;
    var res = await db.query("kanji",where: 'word = ?',whereArgs: [word]);
    List<Kanji> list = res.isNotEmpty ? res.map((c) => Kanji.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Ikanji>> getAllID() async {
    final db = await database;
    var res = await db.query("ikanji");
    List<Ikanji> list = res.isNotEmpty ? res.map((c) => Ikanji.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Kanji>> getAllKanjiAdvance(int start) async {
    final db = await database;
    var res = await db.query('kanji',offset:start,limit: 100);
    List<Kanji> list = res.isNotEmpty ? res.map((c) => Kanji.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Ikanji>> getAllContentByLesson(int lesson) async {
    final db = await database;
    var res = await db.query("ikanji",where: "lesson = ?", whereArgs: [lesson]);
    List<Ikanji> list = res.isNotEmpty ? res.map((c) => Ikanji.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Ikanji>> getNoteById(int id) async {
    final db = await database;
    var res = await db.query("ikanji",where: "id = ?", whereArgs: [id]);
    List<Ikanji> list = res.isNotEmpty ? res.map((c) => Ikanji.fromMap(c)).toList() : [];
    return list;
  }



  Future<List<Data>> getConversationByLessonId(int lesson) async {
    final db = await database;
    var res = await db.rawQuery("""
        SELECT DISTINCT lesson_id FROM data
        LIMIT 25 OFFSET ${(lesson-1)*21}
   """);
    List<Data> list = res.isNotEmpty ? res.map((c) => Data.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Data>> getMiniConversationByLessonId(int lesson) async {
    final db = await database;
    var res = await db.query("data",where: "lesson_id = ?",whereArgs: [lesson],);
    List<Data> list = res.isNotEmpty ? res.map((c) => Data.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Grammar>> getLessonIdFromGrammar(int lesson) async {
    final db = await database;
    var res = await db.query("grammar",where: "lesson_id = ?",whereArgs: [lesson],);
    List<Grammar> list = res.isNotEmpty ? res.map((c) => Grammar.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Kotoba>> getKotobaFromGrammar(int lesson) async {
    final db = await database;
    var res = await db.query("kotoba",where: "lesson_id = ?",whereArgs: [lesson],);
    List<Kotoba> list = res.isNotEmpty ? res.map((c) => Kotoba.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Kaiwa>> getLessonIdFromKaiwa(int lesson) async {
    final db = await database;
    var res = await db.query("kaiwa",where: "lesson_id = ?",whereArgs: [lesson],);
    List<Kaiwa> list = res.isNotEmpty ? res.map((c) => Kaiwa.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Bunkei>> getLessonIdFromBunkei(int lesson) async {
    final db = await database;
    var res = await db.query("bunkei",where: "lesson_id = ?",whereArgs: [lesson],);
    List<Bunkei> list = res.isNotEmpty ? res.map((c) => Bunkei.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Reibun>> getLessonIdFromReibun(int lesson) async {
    final db = await database;
    var res = await db.query("reibun",where: "lesson_id = ?",whereArgs: [lesson],);
    List<Reibun> list = res.isNotEmpty ? res.map((c) => Reibun.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<ReshuuB>> getLessonIdFromRenshuuC(int lesson) async {
    final db = await database;
    var res = await db.query("renshuu",where: "lesson_id = ?",whereArgs: [lesson],);
    List<ReshuuB> list = res.isNotEmpty ? res.map((c) => ReshuuB.fromMap(c)).toList() : [];
    return list;
  }
  Future<List<Reference>> getLessonIdFromRReference(int lesson) async {
    final db = await database;
    var res = await db.query("reference",where: "lesson_id = ?",whereArgs: [lesson],);
    List<Reference> list = res.isNotEmpty ? res.map((c) => Reference.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Mondai>> getLessonIdFromMondai(int lesson) async {
    final db = await database;
    var res = await db.query("mondai",where: "lesson_id = ?",whereArgs: [lesson],);
    List<Mondai> list = res.isNotEmpty ? res.map((c) => Mondai.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Kana>> getGroupFromKana(int id) async {
    final db = await database;
    var res = await db.query("kana",offset:id,limit: 70);
    List<Kana> list = res.isNotEmpty ? res.map((c) => Kana.fromMap(c)).toList() : [];
    return list;
  }

}