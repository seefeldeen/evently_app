import 'dart:convert';

import 'package:flutter/material.dart';

class Eventdata {
  static const String collectionName="eventNamecollection";
   String? eventID;
  final String eventtitle;
  final String description;
  final DateTime eventdate;
  final String eventimage;
  final String eventcategory;
  bool isfav;

  Eventdata(
      {this.eventID ="",
     required this.eventtitle,
        required this.description,
        required this.eventdate,
        required this.eventimage,
        required this.eventcategory,
      this.isfav = false}); // function to send this event details to firebase and another one to get events

   Map<String, dynamic> tofirestore() {
    return {
      "eventId": eventID,
      "eventTitle": eventtitle,
      "eventImage ": eventimage,
      "description": description,
      "eventCategory": eventcategory,
      "eventDate" : eventdate.millisecondsSinceEpoch,
      "isfav": isfav
    };
  }

  factory Eventdata.fromFirestore(Map<String, dynamic> json) {
    return Eventdata(
      eventID: json["eventId"] ?? "",  // Default to empty string if null
      eventtitle: json["eventTitle"] ?? "",  // Default to empty string if null
      description: json["description"] ?? "",  // Default to empty string if null
      eventcategory: json["eventCategory"] ?? "",  // Default to empty string if null
      eventimage: json["eventImage"] ??"",  // Default to empty string if null
      eventdate: json["eventDate"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["eventDate"])
          : DateTime.now(),  // Default to current time if null
      isfav: json["isfav"] ?? false,  // Default to false if null
    );
  }




  }




