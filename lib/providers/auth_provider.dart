import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/auth_user.dart';
import '../repositories/shared_preferences/shared_preferences_repo.dart';

enum AuthState { anonymous, loggedIn, signedUp, loading, failed }

class AuthProvider extends ChangeNotifier {
  AuthState authState = AuthState.anonymous;
  AuthUser? authUser;
  String? errors;

  Future<AuthUser?> handleSignIn(String email, String password) async {
    authState = AuthState.loading;
    notifyListeners();

    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user;

      authUser = AuthUser(
        username: user?.displayName,
        email: user?.email,
        photoUrl: user?.photoURL,
        refreshToken: user?.refreshToken,
        idToken: user?.refreshToken,
        uid: user?.uid,
      );

      // Save to shared pref
      SharedPreferencesRepo.instance.setAuthUser(jsonEncode(authUser!.toJson()));

      // Update status
      authState = AuthState.loggedIn;
      notifyListeners();

      return authUser;
    } catch (e) {
      errors = e.toString();
      authState = AuthState.failed;
      notifyListeners();

      return null;
    }
  }

  handleSignUp(String email, String password) async {
    authState = AuthState.loading;
    notifyListeners();

    try {
      final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = credential.user;

      authUser = AuthUser(
        username: user?.displayName,
        email: user?.email,
        photoUrl: user?.photoURL,
        refreshToken: user?.refreshToken,
        idToken: user?.refreshToken,
        uid: user?.uid,
      );

      authState = AuthState.signedUp;
      notifyListeners();
    } catch (e) {
      errors = e.toString();
      authState = AuthState.failed;
      notifyListeners();
    }
  }

  handleLogOut() async {
    authState = AuthState.loading;
    notifyListeners();

    await SharedPreferencesRepo.instance.clearAuthUser();

    authState = AuthState.anonymous;
    notifyListeners();
  }
}
