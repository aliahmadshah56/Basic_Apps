class Article {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });


  Article.fromJson(Map<String, dynamic> json) {
    source = json["source"] != null ? Source.fromJson(json['source']) : null;
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = json['publishedAt'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (source != null) {
      data['source'] = source!.toJson();
    }
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }
}

// Ensure you have a Source class like this:

class Source {
  String? id;
  String? name;

  Source({
    this.id,
    this.name,
  });

  // JSON deserialization
  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json['id'],
    name: json['name'],
  );

  // JSON serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}
