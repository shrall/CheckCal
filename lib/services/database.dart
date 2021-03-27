import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future<void> updateUserData(String name, int limit) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'limit': limit,
    });
  }
}
