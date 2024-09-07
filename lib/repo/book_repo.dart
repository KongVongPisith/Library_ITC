import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itc_library/model/book_category.dart';
import 'package:itc_library/model/book_model.dart';

class Book_repo{
  List<Book_model> book_model = [];
  List<Category> category = [];
  // Computer host ip address by Command 'ipconfig' in cmd
  final uri = "http://192.168.43.252:3000/book";
  Future<void> getBook_test() async {
    try{
      final response = await http.get(Uri.parse(uri));
      print(response.body);
      print(response);
      if(response.statusCode==200){
        print(response);
        final eventsData = jsonDecode(response.body) as List<dynamic>;
        print(eventsData);
        for(var json in eventsData){
          Book_model em = Book_model(
              id: json['id'] as int,
              author: json['author']??'',
              title: json['title']??'',
              isbn: json['isbn']??'',
              genre: json['genre']??'',
              published: json['published']??'',
              image: json['image']??'',
              code: json['code']??'',
              pdf: json['pdf']??'',
              category: Category.FromJson(json['category']),
              description: json['description']??''
          );
          book_model.add(em);
          category = _extractCategories(book_model);
        }
      }
    }catch(e){
      throw Exception(e);
    }
  }

  List<Category> _extractCategories(List<Book_model> books) {
    final categoriesSet = <int, Category>{};
    for (var book in books) {
      categoriesSet[book.category.id] = book.category;
    }
    return categoriesSet.values.toList();
  }

  Future<void> getBooksByCategory(int categoryId) async {
    book_model = [];
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final booksData = jsonDecode(response.body) as List<dynamic>;
        for(var json in booksData){
          Book_model em = Book_model(
              id: json['id'] as int,
              author: json['author']??'',
              title: json['title']??'',
              isbn: json['isbn']??'',
              genre: json['genre']??'',
              published: json['published']??'',
              image: json['image']??'',
              code: json['code']??'',
              pdf: json['pdf']??'',
              category: Category.FromJson(json['category']),
              description: json['description']??''
          );
          if(em.category.id==categoryId){
            book_model.add(em);
          }
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}