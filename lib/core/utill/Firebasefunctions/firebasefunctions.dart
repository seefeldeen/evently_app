import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/core/models/Eventdata.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseFunctions {
  static CollectionReference<Eventdata> getcollectionreference() {
    var collectionref = FirebaseFirestore.instance;
    return collectionref
        .collection(Eventdata.collectionName)
        .withConverter<Eventdata>(
      fromFirestore: (snapshot, options) =>
          Eventdata.fromFirestore(snapshot.data()!),
      toFirestore: (eventmodel, _) => eventmodel.tofirestore(),
    );
  }

  static Future<bool> createvent(Eventdata newevent) async {
    try {
      // Get the collection reference with the Firestore converter
      var collectionref = getcollectionreference();

      // Create a new document reference (Firestore will automatically generate an ID)
      var collecdoc = collectionref.doc();

      // Assign the Firestore-generated document ID to the newevent
      newevent.eventID = collecdoc.id;

      // Directly use the Eventdata object (no need for eventDataMap)
      await collecdoc.set(newevent);  // Pass Eventdata object directly

      return true;
    } catch (error) {
      print("Error creating event: $error");
      return false;
    }
  }

  static Future<List<Eventdata>> getdatafromfirestore() async {
    try {
      var collectionref = getcollectionreference();

      // Fetch the documents and automatically convert them to Eventdata
      final snapshot = await collectionref.get();

      List<Eventdata> eventsList = snapshot.docs.map
        ((doc) {
        return doc.data(); // doc.data() will return the Eventdata object
      }).toList();

      return eventsList;
    } catch (e) {
      print("Error fetching events: $e");
      throw Exception('Failed to load events');
    }
  }

  static Stream<QuerySnapshot<Eventdata>> getstreamdata(){
    var collectionref = getcollectionreference();
return collectionref.snapshots();
  }

  static Future<bool> deleteevent(Eventdata deletedevent) async {
    try {
      var collectionref = getcollectionreference();

      // Reference to the document to delete
      var docRef = collectionref.doc(deletedevent.eventID);

      // Delete the document
      await docRef.delete();

      return true;
    } catch (e) {
      print("Error deleting event: $e");
      return false;
    }
  }
}
