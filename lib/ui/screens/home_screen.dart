import 'package:flutter/material.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_repo.dart';
import 'package:routing_app/routes/route_config.dart';
import 'package:routing_app/routes/route_management.dart';
import 'package:routing_app/ui/components/main_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            MainButton(
                title: 'Counter screen',
                onPressed: () {
                  RouteManagement.instance.pushNamed(RouteConfig.counter);
                }),
            MainButton(
                title: 'Authentication screen',
                onPressed: () {
                  RouteManagement.instance.pushNamed(RouteConfig.authentication);
                }),
            MainButton(
                title: 'Sign out',
                onPressed: () async {
                  await SharedPreferencesRepo.instance.clearAuthUser();
                  RouteManagement.instance.pushNamedAndRemoveUntil(RouteConfig.authentication, '/');
                }),
          ],
        ),
      ),
    );
  }
}
