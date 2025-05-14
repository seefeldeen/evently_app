class EventModel {
  String? userId;
  String? id;
  String categoryId;
  String categoryImage;
  String title;
  String desc;
  String eventDate;
  double latitude;
  double longitude;
  String eventTime;
  bool isFav;

  EventModel(
      {this.userId,
        this.id,
        required this.title,
        required this.desc,
        required this.eventDate,
        required this.eventTime,
        required this.categoryId,
        this.isFav = false,
        required this.categoryImage,
      this.longitude =0,
      this.latitude = 0});

  EventModel.fromJson(Map<String, dynamic> json)
      : this(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    desc: json["desc"],
    eventDate: json["eventDate"],
    eventTime: json["eventTime"],
    categoryId: json["categoryId"],
    categoryImage: json["categoryImage"],
    isFav: json["isFav"] ?? false,
    latitude: json["latitude"]?? 0,
    longitude: json["longitude"]??0
  );

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "id": id,
      "categoryId": categoryId,
      "categoryImage": categoryImage,
      "title": title,
      "desc": desc,
      "eventDate": eventDate,
      "eventTime": eventTime,
      "isFav": isFav,
      "longitude" : longitude,
      "latitude" : latitude
    };
  }
}



