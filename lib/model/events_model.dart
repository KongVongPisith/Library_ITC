class Events_model {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Events_model(
      {required this.author,
      required this.title,
      required this.description,
      required this.content,
      required this.url,
      required this.publishedAt,
      required this.urlToImage});

  factory Events_model.FromJson(Map<String, dynamic> json) {
    return Events_model(
        author: json['author']??'',
        title: json['title']??'',
        description: json['description']??'',
        content: json['content']??'',
        url:json['url']??'',
        publishedAt: json['publishedAt']??'',
        urlToImage: json['urlToImage']??'',
    );
  }
}
