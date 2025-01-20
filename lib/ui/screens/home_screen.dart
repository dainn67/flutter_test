import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing_app/extensions/build_context_extensions.dart';
import 'package:routing_app/providers/auth_provider.dart';
import 'package:routing_app/providers/theme_provider.dart';
import 'package:routing_app/routes/route_config.dart';
import 'package:routing_app/routes/route_management.dart';
import 'package:routing_app/services/firbase_service.dart';
import 'package:routing_app/ui/components/main_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                title: 'Sign out',
                onPressed: () async {
                  await context.read<AuthProvider>().handleLogOut();
                  RouteManagement.instance.pushNamedAndRemoveUntil(RouteConfig.authentication, '/');
                }),
            MainButton(title: 'Throw Exception', onPressed: () => throw Exception()),
            MainButton(title: 'Log firebase event', onPressed: () => FirebaseService.logEvent(name: 'test_event', params: {'id': 'test_id'})),
            MainButton(
                title: 'Change theme',
                onPressed: () {
                  context.read<ThemeProvider>().toggleTheme();
                }),
            Text(
              (AppLocalizations.of(context)?.test).toString(),
              style: TextStyle(color: context.darkMode ? Colors.red : Colors.blue),
            ),
            Text('Remote config: ${FirebaseService.remoteConfig.getBool('test')}'),
            MainButton(title: 'Fetch remote config', onPressed: (){
              FirebaseService.remoteConfig.fetchAndActivate().then((_) {
                print('FETCH DONE');
              });
            })
          ],
        ),
      ),
    );
  }
}
