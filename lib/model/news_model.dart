class NewsModel {
  final String date;
  final String title;
  final String text;
  final String imageUrl;


  NewsModel({
    required this.date,
    required this.title,
    required this.text,
    required this.imageUrl,

  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      date: json['date'],
      title: json['title'],
      text: json['text'],
      imageUrl: json['image_url'],
    );
  }
}
