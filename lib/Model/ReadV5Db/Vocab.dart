
import 'dart:convert';

Vocab clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Vocab.fromMap(jsonData);
}

String clientToJson(Vocab data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Vocab {
  int id;
  int lesson_id;
  String kanji;
  String hiragana;
  String phonetic;
  String mean;
  String cn_mean;

  //Constructor
  Vocab({this.id,this.lesson_id,this.kanji,this.hiragana,this.phonetic,this.mean,this.cn_mean});


  factory Vocab.fromMap(Map<String, dynamic> json) =>
      new Vocab(
        id: json["id"],
        lesson_id: json["lesson_id"],
        kanji: json["kanji"],
        hiragana: json["hiragana"],
        phonetic: json["phonetic"],
        mean: json["mean"],
        cn_mean: json["cn_mean"],
      );

  Map<String, dynamic> toMap() =>
      {
        "id": id,
        "lesson_id": lesson_id,
        "kanji": kanji,
        "hiragana": hiragana,
        "phonetic": phonetic,
        "mean": mean,
        "cn_mean": cn_mean,

      };
}
