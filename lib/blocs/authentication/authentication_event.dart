abstract class AuthenticationEvent {}

class SignInEvent extends AuthenticationEvent {
  String email;
  String password;

  SignInEvent(this.email, this.password);
}

class SignUpEvent extends AuthenticationEvent {
  String email;
  String username;
  String password;

  SignUpEvent(this.email, this.username, this.password);
}

class LogOutEvent extends AuthenticationEvent {}
