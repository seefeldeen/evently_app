import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


  class FirebaseFunctions {

  static CollectionReference<EventModel> getRef() {
  return FirebaseFirestore.instance.collection("Events").withConverter(
  fromFirestore: (snapshot, options) =>
  EventModel.formJson(snapshot.data()!),
  toFirestore: (value, options) => value.toJson(),
  );
  }

  static Future<void> addEvent(EventModel data) async {
  var ref = getRef();
  var docRef = ref.doc();
  data.userId = FirebaseAuth.instance.currentUser?.uid ?? "";
  data.id = docRef.id;
  return docRef.set(data);
  }

  static Future<void> setFav(EventModel data) async {
  var ref = getRef();
  var docRef = ref.doc(data.id);
  data.userId = FirebaseAuth.instance.currentUser?.uid ?? "";
  data.id = docRef.id;
  return docRef.update({"isFav": !data.isFav});

  }

  static Future<List<QueryDocumentSnapshot<EventModel>>> getEvents() async{
  var ref  = getRef();
 var docs = await ref.get();
  return docs.docs;
  }


  static Future<List<QueryDocumentSnapshot<EventModel>>> getEventsByCategory(String categoryId) async {
    try {
      // الحصول على مرجع من مجموعة "events"
      var ref = FirebaseFirestore.instance.collection('events');

      // إجراء الاستعلام على مجموعة "events" باستخدام الفئة
      var querySnapshot = await ref.where('categoryId', isEqualTo: categoryId)
          .get();

      // تحويل المستندات التي تم جلبها إلى النوع الصحيح
      List<QueryDocumentSnapshot<EventModel>> eventList = querySnapshot.docs
          .map((doc) {
        // تحويل المستند من نوع Map<String, dynamic> إلى EventModel
        return doc as QueryDocumentSnapshot<EventModel>;
      }).toList();

      return eventList;
    } catch (e) {
      // في حال حدوث أي خطأ، طباعة الخطأ
      print("Error fetching events by category: $e");
      rethrow;
    }
  }


  static Future<List<QueryDocumentSnapshot<EventModel>>> getFavEvents() async {
  var ref = getRef();
  var docs = await ref.where("isFav", isEqualTo: true).get();
  return docs.docs;
  }

  // static Future<List<QueryDocumentSnapshot<EventModel>>> search(
  //     String q) async {
  //   var ref = getRef();
  //   var docs = await ref
  //       .orderBy('title')
  //       .startAt([q])
  //       .endAt(['$q\uf8ff'])
  //       .where("isFav", isEqualTo: true)
  //       .get();
  //   return docs.docs;
  // }



  }














//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   static CollectionReference<EventModel> getcollectionreference() {
//     return FirebaseFirestore.instance
//         .collection("Events")
//         .withConverter<EventModel>(
//       fromFirestore: (snapshot,
//           options) =>
//           EventModel.fromFirestore(snapshot.data()!),
//       toFirestore: (eventmodel, options) =>
//           eventmodel.tofirestore(),
//     );
//   }
//
//   static Future<bool> createvent(EventModel newevent) async {
//     try {
//       // Get the collection reference with the Firestore converter
//       var collectionref = getcollectionreference();
//
//       // Create a new document reference (Firestore will automatically generate an ID)
//       var collecdoc = collectionref.doc();
//
//       // Assign the Firestore-generated document ID to the newevent
//       newevent.eventID = collecdoc.id;
//
//       // Directly use the Eventdata object (no need for eventDataMap)
//       await collecdoc.set(newevent);  // Pass Eventdata object directly
//
//       return true;
//     } catch (error) {
//       print("Error creating event: $error");
//       return false;
//     }
//   }
//
//   static Future<List<EventModel>> getdatafromfirestore() async {
//     try {
//       var collectionref = getcollectionreference();
//
//       // Fetch the documents and automatically convert them to Eventdata
//       final snapshot = await collectionref.get();
//
//       List<EventModel> eventsList = snapshot.docs.map
//         ((doc) {
//         return doc.data(); // doc.data() will return the Eventdata object
//       }).toList();
//
//       return eventsList;
//     } catch (e) {
//       print("Error fetching events: $e");
//       throw Exception('Failed to load events');
//     }
//   }
//
//   static Stream<QuerySnapshot<EventModel>> getstreamdata(String categoryname){
//     var collectionref = getcollectionreference().where("eventCategory" ,isEqualTo:  categoryname);
// return collectionref.snapshots();
//   }
//
//   static Stream<QuerySnapshot<EventModel>> getfavouritestreamdata(){
//     var collectionref = getcollectionreference().where("isfav" ,isEqualTo:  true);
// return collectionref.snapshots();
//   }
//
//   static Future<bool> deleteevent(EventModel deletedevent) async {
//     try {
//       var collectionref = getcollectionreference();
//
//       // Reference to the document to delete
//       var docRef = collectionref.doc(deletedevent.eventID);
//
//       // Delete the document
//       await docRef.delete();
//
//       return true;
//     } catch (e) {
//       print("Error deleting event: $e");
//       return false;
//     }
//   }
//
//
//   static Future<bool> updateevent(EventModel ubdatedevent) async {
//     try {
//       var collectionref = getcollectionreference();
//
//       // Reference to the document to delete
//       var docRef = collectionref.doc(ubdatedevent.eventID);
//
//       // Delete the document
//       await docRef.update(
//         ubdatedevent.tofirestore()
//       );
//
//       return true;
//     } catch (e) {
//       print("Error deleting event: $e");
//       return false;
//     }
//   }
//
// }
