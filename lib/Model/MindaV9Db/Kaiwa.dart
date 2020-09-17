import 'dart:convert';

class Kaiwa{
  int id;
  int lesson_id;
  String character;
  String kaiwa;
  String vi_mean;
  String c_roumaji;
  String r_roumaji;

  Kaiwa({this.id,this.lesson_id,this.character,this.kaiwa,this.vi_mean,this.c_roumaji,
  this.r_roumaji});

  factory Kaiwa.fromMap(Map<String, dynamic> json)=>
      new Kaiwa(
        id : json['id'],
        lesson_id : json['lesson_id'],
        character : json['character'],
        kaiwa : json['kaiwa'],
        vi_mean : json['vi_mean'],
        c_roumaji : json['c_roumaji'],
        r_roumaji : json['r_roumaji'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "lesson_id":lesson_id,
        "character":character,
        "kaiwa":kaiwa,
        "vi_mean":vi_mean,
        "c_roumaji":c_roumaji,
        "r_roumaji":r_roumaji,
      };
}