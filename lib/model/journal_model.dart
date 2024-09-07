import 'package:itc_library/model/field.dart';

class Journal_model{
  final int id;
  final String researcher;
  final String topic;
  final String cover;
  final String pdf;
  final String description;
  final String publishedBy;
  final String subject;
  final Fields fields;
  Journal_model({required this.id, required this.researcher, required this.topic, required this.cover, required this.pdf, required this.description, required this.publishedBy, required this.subject, required this.fields});

  factory Journal_model.FromJson(Map<String,dynamic>json){
    return Journal_model(
        id: json['id'],
        researcher: json['researcher']??'',
        topic: json['topic']??'',
        cover: json['cover']??'',
        pdf: json['cover']??'',
        description: json['description']??'',
        publishedBy: json['publishedBy']??'',
        subject: json['subject']??'',
        fields: Fields.FromJson(json['fieldsResearch']??{}));
  }
}