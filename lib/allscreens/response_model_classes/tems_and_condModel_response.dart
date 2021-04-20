import 'package:flutter/material.dart';

class TemsandCondModelResponse{
final double termid;
final String termquestion;
final String termanswer;


TemsandCondModelResponse({required this.termid,required this.termquestion,required this.termanswer});

factory TemsandCondModelResponse.fromJson(Map<String, dynamic> json) {
return new  TemsandCondModelResponse(
  termid: json['TERMID'],
  termquestion: json['TERMQUESTION'],
  termanswer : json['TERMTANSWER'],
);
}
}