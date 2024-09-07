class Department{
  final int id;
  final String name;
  final String cover;
  Department({required this.id, required this.name, required this.cover});

  factory Department.FromJson(Map<String, dynamic>json){
    return Department(
        id: json['id'],
        name: json['name']??'',
        cover: json['cover']??''
    );
  }
}