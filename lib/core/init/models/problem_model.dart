class ProblemModel {
  final String? title;
  final String? description;
  final double? lat;
  final double? lng;
  final List<String>? imageUrls;

  ProblemModel({
    this.title,
    this.description,
    this.lat,
    this.lng,
    this.imageUrls,
  });
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'lat': lat,
        'lng': lng,
        'imageUrls': imageUrls
      };
  @override
  String toString() {
    return "Title: $title\nDescription: $description\nImageUrl:$imageUrls\nLat:$lat\nLng:$lng";
  }
}
