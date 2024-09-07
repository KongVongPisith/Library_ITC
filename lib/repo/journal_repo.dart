import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:itc_library/model/field.dart';
import 'package:itc_library/model/journal_model.dart';

class Journal_repo{
List<Journal_model> journal_data = [];
List<Fields> field_data = [];
final uri = "http://192.168.43.252:3000/journal";

Future<void> getJournal()async{
  try{
    final response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final Data = jsonDecode(response.body) as List<dynamic>;
      for(var json in Data){
        Journal_model jm = Journal_model(
            id: json['id'],
            researcher: json['researcher']??'',
            topic: json['topic']??'',
            cover: json['cover']??'',
            pdf: json['cover']??'',
            description: json['description']??'',
            publishedBy: json['publishedBy']??'',
            subject: json['subject']??'',
            fields: Fields.FromJson(json['fieldsResearch']??{})
        );
        journal_data.add(jm);
        field_data = _extractField(journal_data);
      }
    }
  }catch (e){
    print(e);
  }
}

List<Fields> _extractField(List<Journal_model> journals) {
  final fieldSet = <int, Fields>{};
  for (var journal in journals) {
    fieldSet[journal.fields.id] = journal.fields;
  }
  return fieldSet.values.toList();
}

Future<void> getJournalByField( int field_id ) async{
  journal_data =[];
try{
  final response = await http.get(Uri.parse(uri));
  if (response.statusCode == 200) {
    final Data = jsonDecode(response.body) as List<dynamic>;
    for(var json in Data){
      Journal_model jm = Journal_model(
          id: json['id'],
          researcher: json['researcher']??'',
          topic: json['topic']??'',
          cover: json['cover']??'',
          pdf: json['cover']??'',
          description: json['description']??'',
          publishedBy: json['publishedBy']??'',
          subject: json['subject']??'',
          fields: Fields.FromJson(json['fieldsResearch']??{})
      );
      if(jm.fields.id == field_id){
        journal_data.add(jm);
      }
    }
  }
}catch (e){
  print(e);
}
}
}