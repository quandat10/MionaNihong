import 'dart:convert';

class Grammar{
  int id;
  int lesson_id;
  String name;
  String uname;
  String content;
  String tag;
  int favorite;
  Grammar({this.id,this.lesson_id,this.name,this.uname,this.content,this.tag,
  this.favorite});

  factory Grammar.fromMap(Map<String, dynamic> json)=>
      new Grammar(
        id : json['id'],
        lesson_id : json['lesson_id'],
        name : json['name'],
        uname : json['uname'],
        content : json['content'],
        tag : json['tag'],
        favorite : json['favorite'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "lesson_id":lesson_id,
        "name":name,
        "uname":uname,
        "content":content,
        "tag":tag,
        "favorite":favorite,
      };
}