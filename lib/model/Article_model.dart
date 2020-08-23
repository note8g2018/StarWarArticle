class Article
{
  String id;
  String title;
  String body;
  String author;
  DateTime writingTimeUTC;
  bool isPublic;
  
  Article({
    this.id,
    this.title,
    this.body,
    this.author,
    this.writingTimeUTC,
    this.isPublic = true,
});

  factory Article.fromJson(dynamic jsonObj)
  {
    return Article(
      id: jsonObj["_id"] as String,
      title: jsonObj["title"] as String,
      body: jsonObj["body"] as String,
      author: jsonObj["author"] as String,
      isPublic: jsonObj["isPublic"] as bool,
      writingTimeUTC: DateTime.parse(jsonObj["writingTimeUTC"] as String),
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      "_id": id,
      "title": title,
      "body": body,
      "author": author,
      "isPublic": isPublic,
      "writingTimeUTC": writingTimeUTC?.toUtc()?.toIso8601String(),
    };
  }
}