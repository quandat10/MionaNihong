import 'dart:convert';

class Data{
  int id;
  int lesson_id;
  String name;
  String kanji;
  String mean;
  String recode;

  Data({this.id,this.lesson_id,this.name,this.kanji,this.mean,this.recode});

  factory Data.fromMap(Map<String, dynamic> json)=>
      new Data(
        id : json['id'],
        lesson_id : json['lesson_id'],
        name : json['name'],
        kanji : json['kanji'],
        mean : json['mean'],
        recode : json['recode'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "lesson_id":lesson_id,
        "name":name,
        "kanji":kanji,
        "mean":mean,
        "recode":recode,
      };
}