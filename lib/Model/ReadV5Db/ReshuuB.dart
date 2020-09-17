
import 'dart:convert';

ReshuuB clientFromJson(String str) {
  final jsonData = json.decode(str);
  return ReshuuB.fromMap(jsonData);
}

String clientToJson(ReshuuB data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ReshuuB {
  int id;
  int lesson_id;
  String content;
  String question;


  //Constructor
  ReshuuB({this.id,this.lesson_id,this.content,this.question});


  factory ReshuuB.fromMap(Map<String, dynamic> json) =>
      new ReshuuB(
        id: json["id"],
        lesson_id: json["lesson_id"],
        question: json["question"],
        content: json["content"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "lesson_id": lesson_id,
        "content": content,
        "question": question,

      };
}
