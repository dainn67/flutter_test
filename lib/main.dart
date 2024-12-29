import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/blocs/authentication/authentication_bloc.dart';
import 'package:routing_app/blocs/counter/counter_bloc.dart';
import 'package:routing_app/routes/custom_navigator_observer.dart';
import 'package:routing_app/routes/route_management.dart';
import 'package:routing_app/ui/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CounterBloc>(create: (_) => CounterBloc()),
        BlocProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc()),
      ],
      child: MaterialApp(
        title: 'Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        navigatorObservers: [CustomNavigatorObserver()],
        navigatorKey: RouteManagement.navigationKey,
        onGenerateRoute: RouteManagement.instance.onGenerateRoute,
        home: const HomeScreen(),
      ),
    );
  }
}
