import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChange;
  Future<User> currentUser();
  Future<User> singInAnonymosly();
  Future<User> singInWithGoogle();
  Future<void> singOut();
}

class Auth implements AuthBase {
  final _fireBaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChange {
    return _fireBaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _fireBaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> singInAnonymosly() async {
    final authResult = await _fireBaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> singInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAcount = await googleSignIn.signIn();
    if (googleAcount != null) {
      final googleAuth = await googleAcount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _fireBaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'Error_missing_google_auth_token',
          message: 'missing google auth token ',
        );
      }
    } else {
      throw PlatformException(
        code: 'Error_abrotted_by_user',
        message: 'sing In abort by user ',
      );
    }
  }

  @override
  Future<void> singOut() async {
    final googleSingIn = GoogleSignIn();
    await googleSingIn.signOut();
    await _fireBaseAuth.signOut();
  }
}
