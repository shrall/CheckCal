import 'package:checkcal/models/user.dart';
import 'package:checkcal/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  MyUser _userFromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<MyUser> get user {
    return _auth.authStateChanges().map((User user) => _userFromFirebase(user));
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String name, int limit) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // await DatabaseService(uid: user.uid).updateUserData(name, limit);
      return _userFromFirebase(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
