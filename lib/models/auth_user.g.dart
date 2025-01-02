// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => AuthUser(
      username: json['username'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      refreshToken: json['refreshToken'] as String?,
      idToken: json['idToken'] as String?,
      uid: json['uid'] as String?,
    );

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'idToken': instance.idToken,
      'refreshToken': instance.refreshToken,
      'uid': instance.uid,
    };
