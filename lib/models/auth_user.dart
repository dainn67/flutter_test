import 'package:json_annotation/json_annotation.dart';

part 'auth_user.g.dart';

@JsonSerializable()
class AuthUser {
  String? username;
  String? email;
  String? photoUrl;
  String? idToken;
  String? refreshToken;
  String? uid;

  AuthUser({
    this.username,
    this.email,
    this.photoUrl,
    this.refreshToken,
    this.idToken,
    this.uid,
  });

  @override
  String toString() {
    return 'AuthUser(\n\tusername: $username,\n\temail: $email,\n\tphotoUrl: $photoUrl,\n\tidToken: $idToken,\n\trefreshToken: $refreshToken,\n\tuid: $uid\n)';
  }

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
