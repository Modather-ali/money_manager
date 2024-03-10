import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future registerNewUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference<Map<String, dynamic>> userDocumentReference =
        _usersStatisticsDocument.doc(user!.uid);
    try {
      if (await isUserRegistered()) {
        debugPrint("this user already registered");
      } else {
        await userDocumentReference.set({
          "statistics_data": {},
          "creation_date": DateTime.now().toString().split(" ")[0],
        });
      }
    } catch (e) {
      debugPrint("Error in register new user: $e");
    }
  }

  Future<Map<String, dynamic>> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> userData;
    try {
      DocumentReference<Map<String, dynamic>> userDocumentReference =
          _usersStatisticsDocument.doc(user!.uid);
      var userDocumentData = await userDocumentReference.get();
      userData = userDocumentData.data()!;

      return userData;
    } catch (e) {
      debugPrint("Error in get user data: $e");
      return {};
    }
  }

  Future<bool> addStatisticsData({
    required String date,
    required num income,
    required num outcome,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> userData;
    Map<String, dynamic> statisticsData;
    try {
      DocumentReference<Map<String, dynamic>> userDocumentReference =
          _usersStatisticsDocument.doc(user!.uid);
      var userDocumentData = await userDocumentReference.get();
      userData = userDocumentData.data()!;
      statisticsData = userData["statistics_data"];
      statisticsData[date] = {
        "income": income,
        "outcome": outcome,
      };
      userDocumentReference.update({"statistics_data": statisticsData});
      return true;
    } catch (e) {
      debugPrint("Error in get user data: $e");
      return false;
    }
  }

  Future<Map<String, dynamic>> getStatisticsData() async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> userData;
    Map<String, dynamic> statisticsData;
    try {
      DocumentReference<Map<String, dynamic>> userDocumentReference =
          _usersStatisticsDocument.doc(user!.uid);
      var userDocumentData = await userDocumentReference.get();
      userData = userDocumentData.data()!;
      statisticsData = userData["statistics_data"];
      return statisticsData;
    } catch (e) {
      debugPrint("Error in get user data: $e");
      return {};
    }
  }
}
