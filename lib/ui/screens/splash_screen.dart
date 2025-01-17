import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:routing_app/models/auth_user.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_repo.dart';
import 'package:routing_app/routes/route_config.dart';
import 'package:routing_app/routes/route_management.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _checkCredential();
    super.initState();
  }

  _checkCredential() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authUserJson = SharedPreferencesRepo.instance.getAuthUser();
      if (authUserJson != null) {
        final authUser = AuthUser.fromJson(jsonDecode(authUserJson));
        if (authUser.idToken != null) {
          RouteManagement.instance.pushNamedAndRemoveUntil(RouteConfig.home, '/');
        } else {
          RouteManagement.instance.pushNamedAndRemoveUntil(RouteConfig.authentication, '/');
        }
      } else {
        RouteManagement.instance.pushNamedAndRemoveUntil(RouteConfig.authentication, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SPLASH SCREEN'),
      ),
    );
  }
}
