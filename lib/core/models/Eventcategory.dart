
import 'package:events/core/constants/App_assets/Appassets.dart';
import 'package:flutter/material.dart';

class Eventcategory {
  String id ;
  String categorynam ;
  String categoryimg ;
  IconData categoryicon ;

Eventcategory({
  required this.id,
    required this.categoryicon,
    required this.categoryimg,
    required this.categorynam,
});


   static List<Eventcategory> categories = [

    Eventcategory(
  categoryicon: Icons.all_inclusive_outlined,
  categoryimg: Appassets.Book_Club,
  categorynam: "All", id: '0'),

     Eventcategory(
     categoryicon: Icons.menu_book_outlined,
        categoryimg: Appassets.Book_Club,
        categorynam: "Book club", id: '1'),

  Eventcategory(
        categoryicon: Icons.bike_scooter,
        categoryimg: Appassets.sport,
        categorynam: "sports"
        , id: '2'),
    Eventcategory(
        categoryicon: Icons.cake_outlined,
        categoryimg: Appassets.Birthday,
        categorynam: "Birthday",
        id: '3'),
    Eventcategory(
        categoryicon: Icons.groups,
        categoryimg: Appassets.meeting,
        categorynam: "meeting",
        id: '4'),
    Eventcategory(
        categoryicon: Icons.holiday_village_outlined,
        categoryimg: Appassets.holiday,
        categorynam: "holiday",
        id: '5'),
    Eventcategory(
        categoryicon: Icons.fastfood_outlined,
        categoryimg: Appassets.eating,
        categorynam: "eating",
        id: '6'),
    Eventcategory(
        categoryicon: Icons.games_outlined,
        categoryimg: Appassets.gaming,
        categorynam: "gaming",
        id: '7'),
    Eventcategory(
        categoryicon: Icons.work_outline,
        categoryimg: Appassets.workshop,
        categorynam: "workshop",
        id: '8'),
    Eventcategory(
        categoryicon: Icons.park_outlined,
        categoryimg: Appassets.exhibtion,
        categorynam: "exhibtion",
        id: '9'),
  ];
  static List<Eventcategory> creationcategories = [

    Eventcategory(
        categoryicon: Icons.menu_book_outlined,
        categoryimg: Appassets.Book_Club,
        categorynam: "Book club", id: '1'),

    Eventcategory(
        categoryicon: Icons.bike_scooter,
        categoryimg: Appassets.sport,
        categorynam: "sports"
        , id: '2'),
    Eventcategory(
        categoryicon: Icons.cake_outlined,
        categoryimg: Appassets.Birthday,
        categorynam: "Birthday",
        id: '3'),
    Eventcategory(
        categoryicon: Icons.groups,
        categoryimg: Appassets.meeting,
        categorynam: "meeting",
        id: '4'),
    Eventcategory(
        categoryicon: Icons.holiday_village_outlined,
        categoryimg: Appassets.holiday,
        categorynam: "holiday",
        id: '5'),
    Eventcategory(
        categoryicon: Icons.fastfood_outlined,
        categoryimg: Appassets.eating,
        categorynam: "eating",
        id: '6'),
    Eventcategory(
        categoryicon: Icons.games_outlined,
        categoryimg: Appassets.gaming,
        categorynam: "gaming",
        id: '7'),
    Eventcategory(
        categoryicon: Icons.work_outline,
        categoryimg: Appassets.workshop,
        categorynam: "workshop",
        id: '8'),
    Eventcategory(
        categoryicon: Icons.park_outlined,
        categoryimg: Appassets.exhibtion,
        categorynam: "exhibtion",
        id: '9'),
  ];




}