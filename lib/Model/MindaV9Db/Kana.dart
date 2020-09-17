import 'dart:convert';
Kana clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Kana.fromMap(jsonData);
}

String clientToJson(Kana data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
class Kana{
  int id;
  String romaji;
  String hira;
  String kata;
  String groupe;

  Kana({this.id,this.romaji,this.hira,this.kata,this.groupe});

  factory Kana.fromMap(Map<String, dynamic> json)=>
      new Kana(
        id : json['id'],
        romaji : json['romaji'],
        hira : json['hira'],
        kata : json['kata'],
        groupe : json['groupe'],
      );
  Map<String, dynamic> toMap() =>
      {
        "id":id,
        "romaji":romaji,
        "hira":hira,
        "kata":kata,
        "groupe":groupe,
      };
}