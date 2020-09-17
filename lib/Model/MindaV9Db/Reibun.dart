import 'dart:convert';

class Reibun{
  int id;
  int lesson_id;
  String reibun;
  String vi_mean;
  String roumaji;

  Reibun({this.id,this.lesson_id,this.reibun,this.vi_mean,this.roumaji});

  factory Reibun.fromMap(Map<String, dynamic> json)=>
      new Reibun(
        id : json['id'],
        lesson_id : json['lesson_id'],
        reibun : json['reibun'],
        vi_mean : json['vi_mean'],
        roumaji : json['roumaji'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "lesson_id":lesson_id,
        "reibun":reibun,
        "vi_mean":vi_mean,
        "roumaji":roumaji,
      };
}