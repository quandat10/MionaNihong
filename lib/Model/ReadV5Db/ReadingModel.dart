
import 'dart:convert';

ReadingModel clientFromJson(String str) {
  final jsonData = json.decode(str);
  return ReadingModel.fromMap(jsonData);
}

String clientToJson(ReadingModel data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class ReadingModel {
  int id;
  int lesson_id;
  String baidoc;
  String baidich;
  String nguphap;
  String huongdan;

  //Constructor
  ReadingModel({this.id,this.lesson_id,this.baidoc,this.baidich,this.nguphap,this.huongdan});


  factory ReadingModel.fromMap(Map<String, dynamic> json) =>
      new ReadingModel(
        id: json["id"],
        lesson_id: json["lesson_id"],
        baidoc: json["baidoc"],
        baidich: json["baidich"],
        nguphap: json["nguphap"],
        huongdan: json["huongdan"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "lesson_id": lesson_id,
        "baidoc": baidoc,
        "baidich": baidich,
        "nguphap": nguphap,
        "huongdan": huongdan,
      };
}
