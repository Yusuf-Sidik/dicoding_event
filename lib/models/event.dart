class Event {
  final int id;
  final String name;
  final String summary;
  final String description;
  final String imageLogo;
  final String mediaCover;
  final String category;
  final String ownerName;
  final String cityName;
  final int quota;
  final int registrants;
  final DateTime beginTime;
  final DateTime endTime;
  final String link;

  Event({
    required this.id,
    required this.name,
    required this.summary,
    required this.description,
    required this.imageLogo,
    required this.mediaCover,
    required this.category,
    required this.ownerName,
    required this.cityName,
    required this.quota,
    required this.registrants,
    required this.beginTime,
    required this.endTime,
    required this.link,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      summary: json['summary'],
      description: json['description'],
      imageLogo: json['imageLogo'],
      mediaCover: json['mediaCover'],
      category: json['category'],
      ownerName: json['ownerName'],
      cityName: json['cityName'],
      quota: json['quota'],
      registrants: json['registrants'],
      beginTime: DateTime.parse(json['beginTime']),
      endTime: DateTime.parse(json['endTime']),
      link: json['link'],
    );
  }
}
