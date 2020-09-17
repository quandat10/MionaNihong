import 'dart:convert';

class Bunkei{
  int id;
  int lesson_id;
  String bunkei;
  String vi_mean;
  String roumaji;
  String favorite;

  Bunkei({this.id,this.lesson_id,this.bunkei,this.vi_mean,this.roumaji,this.favorite});

  factory Bunkei.fromMap(Map<String, dynamic> json)=>
      new Bunkei(
        id : json['id'],
        lesson_id : json['lesson_id'],
        bunkei : json['bunkei'],
        vi_mean : json['vi_mean'],
        roumaji : json['roumaji'],
        favorite : json['favorite'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "lesson_id":lesson_id,
        "bunkei":bunkei,
        "vi_mean":vi_mean,
        "roumaji":roumaji,
        "favorite":favorite,
      };
}