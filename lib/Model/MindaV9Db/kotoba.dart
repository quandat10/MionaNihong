import 'dart:convert';

class Kotoba{
  int id;
  int lesson_id;
  String hiragana;
  String kanji;
  String roumaji;
  String cn_mean;
  String mean;
  String mean_unsigned;

  Kotoba({this.id,this.lesson_id,this.hiragana,this.kanji,this.roumaji,this.cn_mean,
  this.mean,this.mean_unsigned});

  factory Kotoba.fromMap(Map<String, dynamic> json)=>
      new Kotoba(
        id : json['id'],
        lesson_id : json['lesson_id'],
        hiragana : json['hiragana'],
        kanji : json['kanji'],
        roumaji : json['roumaji'],
        cn_mean : json['cn_mean'],
        mean : json['mean'],
        mean_unsigned : json['mean_unsigned'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "lesson_id":lesson_id,
        "hiragana":hiragana,
        "kanji":kanji,
        "roumaji":roumaji,
        "cn_mean":cn_mean,
        "mean":mean,
        "mean_unsigned":mean_unsigned,
      };
}