import 'dart:convert';

Ikanji clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Ikanji.fromMap(jsonData);
}

String clientToJson(Ikanji data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Ikanji {
  int id;
  String word;
  int lesson;
  String vi_mean;

//  String uvi_mean;
  String cn_mean;

//  String ucn_mean;
  String image;
  String remember;
  String remember_jp;

//  String write;
  String onjomi;

//  String ronjomi;
  String kunjomi;

//  String rkunjomi;
  String numstroke;
//  int favorite;
  String note;

//  int tag;
//  int num;
//  int time_answer;
//  int t_number;
//  int time_access;
//  int score;

  Ikanji({this.id, this.word, this.lesson, this.cn_mean, this.onjomi,
    this.kunjomi, this.image, this.remember, this.remember_jp, this.note, this.vi_mean,this.numstroke});

  factory Ikanji.fromMap(Map<String, dynamic> json) =>
      new Ikanji(
        id: json["id"],
        word: json["word"],
        lesson: json["lesson"],
        vi_mean: json["vi_mean"],
//    uvi_mean: json["uvi_mean"],
        cn_mean: json["cn_mean"],
//    ucn_mean: json["ucn_mean"],
        image: json["image"],
        remember: json["remember"],
        remember_jp: json["remember_jp"],
//    write: json["write"],
        onjomi: json["onjomi"],
//    ronjomi: json["ronjomi"],
        kunjomi: json["kunjomi"],
//    rkunjomi: json["rkunjomi"],
    numstroke: json["numstroke"],
//    favorite: json["favorite"],
        note: json["note"],
//    tag: json["tag"],
//    num: json["num"],
//    time_answer: json["time_answer"],
//    t_number: json["t_number"],
//    time_access: json["time_access"],
//    score: json["score"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "word": word,
        "lesson": lesson,
        "vi_mean": vi_mean,
//    "uvi_mean": uvi_mean,
        "cn_mean": cn_mean,
//    "ucn_mean": ucn_mean,
        "image": image,
        "remember": remember,
        "remember_jp": remember_jp,
//    "write": write,
        "onjomi": onjomi,
//    "ronjomi": ronjomi,
        "kunjomi": kunjomi,
//    "rkunjomi": rkunjomi,
    "numstroke": numstroke,
//    "favorite": favorite,
        "note": note,
//    "tag": tag,
//    "num": num,
//    "time_answer": time_answer,
//    "t_number": t_number,
//    "time_access": time_access,
//    "score": score,
      };}