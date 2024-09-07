import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itc_library/model/events_model.dart';
class Events_repo{
  List<Events_model> event_model = [];
  final uri =
      'https://newsapi.org/v2/everything?q=tesla&from=2024-06-27&sortBy=publishedAt&apiKey=19fcabd07c6c4e99a9624e5ddf097f6f';
  Future<void> getEvents() async{
    try{
      final response = await http.get(Uri.parse(uri));
      if(response.statusCode==200){
        final data = jsonDecode(response.body);
        List<dynamic> eventsData = data['articles'];

        eventsData.forEach((element) {
          Events_model em = Events_model.FromJson(element);
          event_model.add(em);
        });
      }
    }catch (e){
      throw Exception(e);
    }
}
}