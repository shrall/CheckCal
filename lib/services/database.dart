import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> updateUserData(String name, int limit) async {
    print("uid : " + uid);
    await userCollection.doc(uid).set({
      'name': name,
      'limit': limit,
    });
  }
}
