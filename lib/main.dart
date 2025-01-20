import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:routing_app/l10n/l10n.dart';
import 'package:routing_app/providers/auth_provider.dart';
import 'package:routing_app/providers/theme_provider.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_helper.dart';
import 'package:routing_app/routes/custom_navigator_observer.dart';
import 'package:routing_app/routes/route_management.dart';
import 'package:routing_app/services/firbase_service.dart';
import 'package:routing_app/services/log_service.dart';
import 'package:routing_app/services/sqlite_service.dart';
import 'package:routing_app/ui/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await FirebaseService.init();

  await SharedPreferencesHelper.init().catchError((e) {
    printError('init shared_prefs error: $e');
  });
  await SqliteService.instance.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      supportedLocales: L10n.all,
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [CustomNavigatorObserver()],
      navigatorKey: RouteManagement.navigationKey,
      onGenerateRoute: RouteManagement.instance.onGenerateRoute,
      home: const SplashScreen(),
    );
  }
}
