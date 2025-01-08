import 'package:routing_app/models/auth_user.dart';

abstract class AuthenticationState {}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSignInSuccess extends AuthenticationState {
  final AuthUser user;

  AuthSignInSuccess(this.user);
}

class AuthLogOutSuccess extends AuthenticationState {}

class AuthFailed extends AuthenticationState {
  final dynamic _error;
  
  String getError() {
    final errorString = _error.toString(); 
    if (errorString.contains('email-already-in-use')) {
      return 'Account already exists';
    } else if (errorString.contains('invalid-credential')) {
      return 'Invalid email or password';
    }

    return 'An error happened! Try again later';
  }

  AuthFailed(this._error);
}
