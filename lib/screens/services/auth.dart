import 'package:brew_crew/modules/user.dart';
import 'package:brew_crew/screens/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  BrewUser fromFirebaseUser(user) {
    return user != null ? BrewUser(uid: user.uid) : null;
  }

  Stream<BrewUser> get user {
    return _auth.authStateChanges().map(fromFirebaseUser);
  }

  Future signinAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return fromFirebaseUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
      return fromFirebaseUser(user);
    }
    catch(e) {
      print(e);
      return null;
    }
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return fromFirebaseUser(user);
    }
    catch(e) {
      print(e);
      return null;
    }
  }
}
