import 'dart:convert';

import 'package:itc_library/model/department.dart';
import 'package:itc_library/model/thesis_model.dart';
import 'package:http/http.dart' as http;

class Thesis_repo{
  List<Thesis_model> thesis_model=[];
  List<Department> department_model=[];

  final uri = "http://192.168.43.252:3000/thesis";

  Future<void> getThesis() async{
    final response = await http.get(Uri.parse(uri));
    if(response.statusCode==200){
      final data = jsonDecode(response.body) as List<dynamic>;
      for(var json in data){
        Thesis_model tm = Thesis_model(
            id: json['id'],
            studentName: json['studentName']??"",
            generation: json['generation']??"",
            subject: json['subject']??"",
            topic: json['topic']??'',
            published: json['published']??'',
            cover: json['cover']??'',
            department: Department.FromJson(json['department']??{}),
          pdf: json['pdf']??''
        );
        thesis_model.add(tm);
        department_model = _extractDepartment(thesis_model);
      }
    }
  }

  List<Department> _extractDepartment(List<Thesis_model> thesises) {
    final departmentSet = <int, Department>{};
    for (var thesis in thesises) {
      departmentSet[thesis.department.id] = thesis.department;
    }
    return departmentSet.values.toList();
  }

  Future<void> getThesisByDepartment(int department_id) async{
    thesis_model = [];
    final response = await http.get(Uri.parse(uri));
    if(response.statusCode==200){
      final data = jsonDecode(response.body) as List<dynamic>;
      for(var json in data){
        Thesis_model tm = Thesis_model(
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
        if(tm.department.id==department_id){
          thesis_model.add(tm);
        }
      }
    }
  }
}