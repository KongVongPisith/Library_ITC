class Fields {
  final int id;
  final String fieldName;
  final String cover;
  Fields({required this.id,required this.fieldName, required this.cover});

  factory Fields.FromJson(Map<String,dynamic>json){
    return Fields(
        id: json['id'],
        fieldName: json['fieldName']??'',
        cover: json['cover']??''
    );
  }
}