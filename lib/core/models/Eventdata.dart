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
      eventID: json["eventId"],  // Assuming 'eventId' is the Firestore field name
      eventtitle: json["eventTitle"],  // Assuming 'eventTitle' is the Firestore field name
      description: json["description"],  // Assuming 'description' is the Firestore field name
      eventcategory: json["eventCategory"],  // Assuming 'eventCategory' is the Firestore field name
      eventimage: json["eventImage"],  // Assuming 'eventImage' is the Firestore field name
      eventdate: DateTime.fromMillisecondsSinceEpoch(json["eventDate"]),  // Assuming you need to parse the DateTime
     isfav: json["isfav"]

      // Assuming you need to convert to TimeOfDay
    );
  }




  }




