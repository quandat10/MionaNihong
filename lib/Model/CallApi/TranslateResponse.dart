import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minnav2/server/domain.dart';


class JatoVi {
  String orig;
  String src_translit;
  String trans;


  JatoVi( {this.orig, this.src_translit,this.trans});
  factory JatoVi.fromJson(Map<String, dynamic>json){
    return JatoVi(
      orig: json['orig'],
      src_translit: json['src_translit'],
      trans: json["trans"],
    );
  }
  Map<String, dynamic> toJson() => {
    'orig': orig,
    'src_translit': src_translit,
    "trans":trans


  };
}
Future<List<JatoVi>> fetchTransJatoVi(http.Client client, String url) async{
  final response = await client.get(url);
  if(response.statusCode == 200){
    String body = utf8.decode(response.bodyBytes);
    Map<String, dynamic> mapResponse = json.decode(body);

    print(body);
    final translates = mapResponse["sentences"].cast<Map<String, dynamic>>();
    final listOfTranslates = await translates.map<JatoVi>((json){
      return JatoVi.fromJson(json);
    }).toList();
//    print(listOfTranslates);
    return listOfTranslates;
  }else{
    throw Exception("failed to load translate from the internet");
  }
}
