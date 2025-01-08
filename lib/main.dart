import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/blocs/authentication/authentication_bloc.dart';
import 'package:routing_app/blocs/counter/counter_bloc.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_helper.dart';
import 'package:routing_app/repositories/sqlite/topic_repo.dart';
import 'package:routing_app/routes/custom_navigator_observer.dart';
import 'package:routing_app/routes/route_management.dart';
import 'package:routing_app/services/log_service.dart';
import 'package:routing_app/services/sqlite_service.dart';
import 'package:routing_app/ui/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await SharedPreferencesHelper.init().catchError((e) {
    printError('init shared_prefs error: $e');
  });
  await SqliteService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (context) => TopicRepository())],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(create: (context) => CounterBloc()),
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(
              RepositoryProvider.of<TopicRepository>(context),
            ),
          ),
        ],
        child: Builder(
          builder: (context) => MaterialApp(
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
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
