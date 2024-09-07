import 'package:itc_library/model/department.dart';

class Thesis_model{
  final int id;
  final String studentName;
  final String generation;
  final String subject;
  final String topic;
  final String published;
  final String cover;
  final Department department;
  final String pdf;

  Thesis_model({
    required this.id,
    required this.studentName,
    required this.generation,
    required this.subject,
    required this.topic,
    required this.published,
    required this.cover,
    required this.department,
    required this.pdf
   });

  factory Thesis_model.FromJson(Map<String, dynamic> json){
    return Thesis_model(
        id: json['id'],
        studentName: json['studentName']??"",
        generation: json['generation']??"",
        subject: json['subject']??"",
        topic: json['topic']??'',
        published: json['published']??'',
        cover: json['cover']??'',
        department: Department.FromJson(json['department']??{}),
      pdf: json['pdf']??""
    );
  }
}