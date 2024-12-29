class AuthenticationState {
  String email;
  String username;
  String password;

  AuthenticationState(this.email, this.username, this.password);

  @override
  String toString() {
    return 'email: $email\nusername: $username\npassword: $password';
  }
}
