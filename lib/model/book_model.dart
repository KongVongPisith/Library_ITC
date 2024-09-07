import 'book_category.dart';

class Book_model{
  final int id;
  final String title;
  final String isbn;
  final String published;
  final String code;
  final String genre;
  final String author;
  final String image;
  final String pdf;
  final String description;
  final Category category;
  Book_model({
    required this.id, required this.title, required this.author, required this.genre,
    required this.image, required this.code, required this.pdf, required this.isbn,
    required this.published, required this.category, required this.description
  });

  factory Book_model.fromJson(Map<String, dynamic> json) {
    return Book_model(
        id: json['id'],
        title: json['title'],
        isbn: json['isbn'],
        published: json['published'],
        code: json['code'],
        genre: json['genre'],
        author: json['author'],
        image: json['image'],
        pdf: json['pdf'],
        category: Category.FromJson(json['category']),
        description: json['description']
    );
  }
}
