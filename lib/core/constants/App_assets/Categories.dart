import 'package:events/core/constants/App_assets/Appassets.dart';

class Categorydata {

final String title ;
final String id ;
final String image ;

Categorydata({ required this.title,
    required this.id,
    required this.image});


 List<Categorydata> Categories= [
  
Categorydata( title: 'bookclub', id: 'bookclub', image: Appassets.Book_Club),
    Categorydata( title: 'sport', id: 'sport', image: Appassets.sport),
    Categorydata( title: 'birthday', id: 'birthday', image: Appassets.Birthday),
    Categorydata( title: 'meeting', id: 'meeting', image: Appassets.meeting),
    Categorydata( title: 'holiday', id: 'holiday', image: Appassets.holiday),
    Categorydata( title: 'eating', id: 'eating', image: Appassets.eating),
    Categorydata( title: 'gaming', id: 'gaming', image: Appassets.gaming),

    Categorydata( title: 'workshop', id: 'workshop', image: Appassets.workshop),

Categorydata( title: 'exhibtion', id: 'exhibtion', image: Appassets.exhibtion),

];



}