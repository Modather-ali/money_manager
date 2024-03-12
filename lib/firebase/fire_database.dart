import 'package:cloud_firestore/cloud_firestore.dart';
import '../tools/logger_utils.dart';

class FireDatabase {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> isExistsDocument({
    String collectionPath = 'User',
    String? docPath,
  }) async {
    try {
      var documentReference = await FirebaseFirestore.instance
          .collection(collectionPath)
          .doc(docPath)
          .get();

      Logger.print("is document exists: ${documentReference.exists}");
      return documentReference.exists;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getItemData({
    required String id,
    required String collectionPath,
  }) async {
    Map<String, dynamic>? data;
    try {
      CollectionReference<Map<String, dynamic>> collectionReference =
          FirebaseFirestore.instance.collection(collectionPath);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await collectionReference.doc(id).get();

      data = documentSnapshot.data();
    } catch (e) {
      Logger.print("error in get $id date: $e");
    }
    return data;
  }

  static Future<bool> checkIfItemExists({
    required String item,
    required Object field,
    required String collectionPath,
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _collection(collectionPath).where(field, isEqualTo: item).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      Logger.print('Error checkIfItemExists: $e');
      return false;
    }
  }

  static Future<String?> searchForDocument(
    Object field, {
    required Object item,
    required String collectionPath,
  }) async {
    String? docID;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _collection(collectionPath).where(field, isEqualTo: item).get();
      if (querySnapshot.docs.isNotEmpty) {
        docID = querySnapshot.docs.first.id;
      }
    } catch (e) {
      Logger.print('Error in finding document:$e');
    }
    return docID;
  }

  static Future<bool> saveItemData(
    dynamic item, {
    required String collectionPath,
  }) async {
    try {
      await _collection(collectionPath).doc(item.id).set(item.toJson());

      return true;
    } catch (e) {
      Logger.print("Error in save data: $e");
      return false;
    }
  }

  static Future<bool> updateItemData(
    dynamic item, {
    required String collectionPath,
  }) async {
    try {
      await _collection(collectionPath).doc(item.id).update(item.toJson());

      return true;
    } catch (e) {
      Logger.print("Error in update item data: $e");
      return false;
    }
  }

  static Future<bool> deleteItem(
    String id, {
    required String collectionPath,
  }) async {
    try {
      await _collection(collectionPath).doc(id).delete();
      return true;
    } catch (e) {
      Logger.print("Error in delete: $e");

      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getListOfItems(
      {required String collectionPath}) async {
    List<Map<String, dynamic>> items = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _collection(collectionPath).get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        items.add(data);
      }
    } catch (e) {
      Logger.print('Error in get items :$e');
    }
    return items;
  }

  static Future<List<Map<String, dynamic>>> getFilteredItemsList({
    required Object searchField,
    Object? isEqualTo,
    required String collectionPath,
  }) async {
    List<Map<String, dynamic>> items = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _collection(collectionPath)
              .where(searchField, isEqualTo: isEqualTo)
              .get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();

        items.add(data);
      }
    } catch (e) {
      Logger.print('Error in get items :$e');
    }
    return items;
  }

  static Future<int> getCollectionSize({required String collectionPath}) async {
    int size = 0;
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _collection(collectionPath).get();
      size = querySnapshot.size;
      Logger.print('$collectionPath size = $size');
    } catch (e) {
      Logger.print('error in getCollectionLength: $e');
    }
    return size;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> listenDocChanges({
    required String docID,
    required String collectionPath,
  }) {
    DocumentReference<Map<String, dynamic>> reference =
        _collection(collectionPath).doc(docID);

    return reference.snapshots();
  }

  static Future<dynamic> getFieldData({
    required String docID,
    required String collectionPath,
    required Object field,
  }) async {
    DocumentReference<Map<String, dynamic>> reference =
        _collection(collectionPath).doc(docID);
    dynamic fieldValue;
    try {
      DocumentSnapshot snapshot = await reference.get(
        const GetOptions(source: Source.serverAndCache),
      );
      fieldValue = snapshot.get(field);
      Logger.print(fieldValue);
    } catch (error) {
      Logger.print('Error in getFieldData : $error');
    }
    return fieldValue;
  }

  static CollectionReference<Map<String, dynamic>> _collection(
    String collectionPath,
  ) =>
      _firestore.collection(collectionPath);
}
