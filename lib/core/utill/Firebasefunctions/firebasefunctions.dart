import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:firebase_auth/firebase_auth.dart';


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
    return docRef.update({"isFav": !data.isFav});
  }


  static Stream<QuerySnapshot<EventModel>> getstreamdata(){
    var collectionref = getRef().
    where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid);
return collectionref.snapshots();
  }

  static Stream<QuerySnapshot<EventModel>> getFavEventsStream() {
    var collectionref = getRef().
    where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isFav", isEqualTo: true);

        return collectionref.snapshots();                         // استماع للتغييرات
  }




  static Stream<QuerySnapshot<EventModel>>  getEventsByCategory(String categoryId)  {

      var ref =  getRef()
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('categoryId', isEqualTo: categoryId);

      return ref.snapshots();

  }

  static Future<void> deleteEvent(EventModel data) async {
    var ref = getRef();
    var docRef = ref.doc(data.id);
    return docRef.delete();

  }




  static Future<void> updateEvent(EventModel data) async {
    var ref = getRef();
    var docRef = ref.doc(data.id);
    return docRef.update(data.toJson());

  }


  }

