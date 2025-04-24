import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
class EventModel {
  String? userId;
  String? id;
  String categoryId;
  String categoryImage;
  String title;
  String desc;
  String eventDate;

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //         other is EventModel &&
  //             runtimeType == other.runtimeType &&
  //             userId == other.userId &&
  //             id == other.id &&
  //             categoryId == other.categoryId &&
  //             categoryImage == other.categoryImage &&
  //             title == other.title &&
  //             desc == other.desc &&
  //             eventDate == other.eventDate &&
  //             eventTime == other.eventTime &&
  //             isFav == other.isFav;
  //
  // @override
  // int get hashCode =>
  //     userId.hashCode ^
  //     id.hashCode ^
  //     categoryId.hashCode ^
  //     categoryImage.hashCode ^
  //     title.hashCode ^
  //     desc.hashCode ^
  //     eventDate.hashCode ^
  //     eventTime.hashCode ^
  //     isFav.hashCode;

  String eventTime;
  bool isFav
  ;

  EventModel(
      {this.userId,
        this.id,
        required this.title,
        required this.desc,
        required this.eventDate,
        required this.eventTime,
        required this.categoryId,
        this.isFav = false,
        required this.categoryImage});

  EventModel.formJson(Map<String, dynamic> json)
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
    };
  }
}



