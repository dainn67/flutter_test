import 'package:routing_app/models/auth_user.dart';

abstract class AuthenticationState {}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {
  final AuthUser user;
  AuthSuccess(this.user);
}

class AuthFailed extends AuthenticationState {
  final String error;
  AuthFailed(this.error);
}
