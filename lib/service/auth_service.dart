import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //email and password
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // update username
      var userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;
      await currentUser.user.updateProfile(userUpdateInfo);
      await currentUser.user.reload();
      return currentUser.user.uid;
    }

    // email and password sign in
    Future<String> signInWithEmailAndPassword(
        String email, String password) async {
      return (await _firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password)).user.uid;
    }

    //sign out
    signOut() {
      return _firebaseAuth.signOut();
    }
  }

