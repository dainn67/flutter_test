import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routing_app/blocs/authentication/authentication_event.dart';
import 'package:routing_app/blocs/authentication/authentication_state.dart';
import 'package:routing_app/models/auth_user.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_repo.dart';
import 'package:routing_app/repositories/sqlite/topic_repo.dart';
import 'package:routing_app/routes/route_config.dart';

import '../../routes/route_management.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this.topicRepository) : super(AuthInitial()) {
    on<SignInEvent>(_handleSignIn);
    on<SignUpEvent>(_handleSignUp);
  }

  final TopicRepository topicRepository;

  _handleSignIn(AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());

    final signInEvent = event as SignInEvent;
    final email = signInEvent.email;
    final password = signInEvent.password;

    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user;

      final authUser = AuthUser(
        username: user?.displayName,
        email: user?.email,
        photoUrl: user?.photoURL,
        refreshToken: user?.refreshToken,
        idToken: user?.refreshToken,
        uid: user?.uid,
      );

      // Save to shared pref
      SharedPreferencesRepo.instance.saveAuthUser(jsonEncode(authUser.toJson()));

      emit(AuthSuccess(authUser));
    } catch (e) {
      _checkError(e);
      emit(AuthFailed(e.toString()));
    }
  }

  _handleSignUp(AuthenticationEvent event, Emitter<AuthenticationState> emit) async {
    final signUpEvent = event as SignUpEvent;
    final email = signUpEvent.email;
    final username = signUpEvent.username;
    final password = signUpEvent.password;

    try {
      final UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      _checkError(e);
      emit(AuthFailed(e.toString()));
    }
  }

  _checkError(dynamic e) {
    if (e.toString().contains('email-already-in-use')) {
      Fluttertoast.showToast(msg: 'Account already exists');
    }
  }
}
