import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CloudFirestore {
  final CollectionReference<Map<String, dynamic>> _usersStatisticsDocument =
      FirebaseFirestore.instance.collection("users_statistics");

  Future<bool> isUserRegistered() async {
    List docsId = [];

    QuerySnapshot result = await _usersStatisticsDocument.get();

    for (var queryDocumentSnapshot in result.docs) {
      docsId.add(queryDocumentSnapshot.id);
    }

    debugPrint('$docsId');

    return docsId.contains(FirebaseAuth.instance.currentUser!.uid);
  }

  registerNewUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    DocumentReference<Map<String, dynamic>> documentReference =
        _usersStatisticsDocument.doc(user!.uid);

    try {
      if (await isUserRegistered()) {
        debugPrint("this user already registered");
      } else {
        await documentReference.set({
          "data": {},
          "creation_date": DateTime.now().toString().split(" ")[0],
        });
      }
    } catch (e) {
      debugPrint("Error in register new user: $e");
    }
  }
}
