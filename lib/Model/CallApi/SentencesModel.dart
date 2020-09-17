import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minnav2/server/domain.dart';


class Sentences {
  String orig;
  String translit;
  String trans;


  Sentences( {this.orig, this.translit,this.trans});
  factory Sentences.fromJson(Map<String, dynamic>json){
    return Sentences(
      orig: json['orig'],
      translit: json['translit'],
      trans: json["trans"],
    );
  }
  Map<String, dynamic> toJson() => {
    'orig': orig,
    'translit': translit,
    "trans":trans


  };
}
Future<List<Sentences>> fetchTranslateResponse(http.Client client, String url) async{
  final response = await client.get(url);
  if(response.statusCode == 200){
    String body = utf8.decode(response.bodyBytes);
    Map<String, dynamic> mapResponse = json.decode(body);

    print(body);
    final translates = mapResponse["sentences"].cast<Map<String, dynamic>>();
    final listOfTranslates = await translates.map<Sentences>((json){
      return Sentences.fromJson(json);
    }).toList();
//    print(listOfTranslates);
    return listOfTranslates;
  }else{
    throw Exception("failed to load translate from the internet");
  }
}
