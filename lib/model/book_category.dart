class Category{
  final int id;
  final String name;
  final String cover;

  Category({required this.id, required this.name, required this.cover});

  factory Category.FromJson(Map<String,dynamic>json){
    return Category(
        id: json['id'],
        name: json['name']??"",
        cover: json['cover']??""
    );
  }
}