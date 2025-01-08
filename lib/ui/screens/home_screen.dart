import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/blocs/authentication/authentication_bloc.dart';
import 'package:routing_app/blocs/authentication/authentication_event.dart';
import 'package:routing_app/blocs/authentication/authentication_state.dart';
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
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthLogOutSuccess) {
                  RouteManagement.instance.pushNamedAndRemoveUntil(RouteConfig.authentication, '/');
                }
              },
              builder: (context, state) => MainButton(
                  title: 'Sign out',
                  isLoading: state is AuthLoading,
                  onPressed: () async {
                    context.read<AuthenticationBloc>().add(LogOutEvent());
                  }),
            ),
            MainButton(
                title: 'Throw Exception',
                onPressed: () {
                  try {
                    final list = [0, 1, 2];
                    print(list[3]);
                  } catch (e, stack) {
                    FirebaseCrashlytics.instance.recordError(e, stack);
                    print('Err: $e');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
