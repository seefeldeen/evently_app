import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


  class FirebaseFunctions {

  static CollectionReference<EventModel> getRef() {
  return FirebaseFirestore.instance.collection("Events").withConverter(
  fromFirestore: (snapshot, options) =>
  EventModel.fromJson(snapshot.data()!),
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
 //


  static Stream<QuerySnapshot<EventModel>> getstreamdata(){
    var collectionref = getRef().
    where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
return collectionref.snapshots();
  }



  static Stream<QuerySnapshot<EventModel>>  getEventsByCategory(String categoryId)  {

      var ref =  getRef()
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('categoryId', isEqualTo: categoryId);

      return ref.snapshots();

  }




  static Future<List<QueryDocumentSnapshot<EventModel>>> getFavEvents() async {
  var ref = getRef();
  var docs = await ref.where("isFav", isEqualTo: true).get();
  return docs.docs;
  }


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
