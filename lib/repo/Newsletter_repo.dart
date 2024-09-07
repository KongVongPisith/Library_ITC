import 'dart:convert';

import 'package:itc_library/model/newsletter_model.dart';
import 'package:http/http.dart' as http;

class Newsletter_repo{
  List<Newsletters_model> newsletter_model = [];
  final uri = "http://192.168.43.252:3000/newsletter";
  Future<void> getNewsletter() async{
    try{
      final response = await http.get(Uri.parse(uri));
      print(response.body);
      if(response.statusCode == 200){
        final newsletter = jsonDecode(response.body) as List<dynamic>;
        for(var json in newsletter){
          Newsletters_model nm = Newsletters_model(
              file: json['pdf']??''
          );
          newsletter_model.add(nm);
        }
      }
    }catch (e){
      throw new Exception(e);
    }
  }
}