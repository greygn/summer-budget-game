import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              t.languageIntroduction,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(t.welcome_text),
            ElevatedButton(
              onPressed: () {
                MyApp.of(context)?.setLocale(const Locale('en'));
              },
              child: Text("English"),
            ),
            ElevatedButton(
              onPressed: () {
                MyApp.of(context)?.setLocale(const Locale('ru'));
              },
              child: Text("Русский"),
            ),
            Container(height: 24,),
            Text(
              'Home Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'choose path below',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ElevatedButton(
              onPressed: () => context.router.pushPath('/dashboard'),
              child: Text('Open Dashboard'),
            ),
            ElevatedButton(
              onPressed: () => context.router.pushPath('/action-chooser'),
              child: Text('Open Action Chooser'),
            ),
            ElevatedButton(
              onPressed: () => context.router.pushPath('/job-chooser'),
              child: Text('Open Job Chooser'),
            ),
            ElevatedButton(
              onPressed: () => context.router.pushPath('/event'),
              child: Text('Open Event'),
            ),
            ElevatedButton(
              onPressed: () => context.router.pushPath('/results'),
              child: Text('Open Results'),
            ),
          ],
        ),
      ),
    );
  }
}
