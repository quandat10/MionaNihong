import 'dart:convert';

class Reference{
  int id;
  int lesson_id;
  String japanese;
  String roumaji;
  String vietnamese;
  String note;

  Reference({this.id,this.lesson_id,this.japanese,this.vietnamese,this.roumaji,this.note});

  factory Reference.fromMap(Map<String, dynamic> json)=>
      new Reference(
        id : json['id'],
        lesson_id : json['lesson_id'],
        japanese : json['japanese'],
        vietnamese : json['vietnamese'],
        roumaji : json['roumaji'],
        note : json['note'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "lesson_id":lesson_id,
        "japanese":japanese,
        "roumaji":roumaji,
        "vietnamese":vietnamese,
        "note":note,
      };
}