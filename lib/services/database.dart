import 'dart:io';

import 'package:checkcal/models/log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  static CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  Future<void> updateUserData(
      String name, int limit, DateTime joinedDate, String imgUrl) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'limit': limit,
      'joinedDate': joinedDate,
      'imgUrl': imgUrl ?? ""
    });
  }

  List<Log> getLogListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Log(
        name: doc.get('name'),
        kcal: doc.get('kcal'),
        type: doc.get('type'),
      );
    }).toList();
  }

  Future<void> addLog(
      String name, int kcal, String time, String type, DateTime date) async {
    await userCollection
        .doc(uid)
        .collection("logbooks")
        .doc(DateFormat('yyyy-MM-dd').format(date))
        .set({
      'date': DateFormat('yyyy-MM-dd').format(date),
    });
    return await userCollection
        .doc(uid)
        .collection("logbooks")
        .doc(DateFormat('yyyy-MM-dd').format(date))
        .collection('logs')
        .add({
      'name': name,
      'kcal': kcal,
      'time': time,
      'type': type,
    });
  }

  Future<bool> updateProfile(
    String uid,
    String name,
    int limit,
  ) async {
    await userCollection.doc(uid).update(
      {'name': name, 'limit': limit},
    );
    return true;
  }

  Future<bool> updateProfilePic(String uid, File imgFile) async {
    if (imgFile != null) {
      ref = FirebaseStorage.instance.ref().child("imgUrl").child(uid + ".png");
      uploadTask = ref.putFile(File(imgFile.path));

      await uploadTask.whenComplete(() => ref.getDownloadURL().then(
            (value) => imgUrl = value,
          ));

      userCollection.doc(uid).update({'imgUrl': imgUrl});

      return true;
    } else {
      return false;
    }
  }
}
