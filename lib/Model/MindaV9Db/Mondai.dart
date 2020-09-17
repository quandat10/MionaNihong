import 'dart:convert';

class Mondai{
  int id;
  int lesson_id;
  String name;
  int type;
  String content;
  int question_num;
  String answer;
  String audio;

  Mondai({this.id,this.lesson_id,this.name,this.type,this.content,this.question_num,
    this.answer,this.audio});

  factory Mondai.fromMap(Map<String, dynamic> json)=>
      new Mondai(
        id : json['id'],
        lesson_id : json['lesson_id'],
        name : json['name'],
        type : json['type'],
        content : json['content'],
        question_num : json['question_num'],
        answer : json['answer'],
        audio : json['audio'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "lesson_id":lesson_id,
        "name":name,
        "type":type,
        "content":content,
        "question_num":question_num,
        "answer":answer,
        "audio":audio,
      };
}