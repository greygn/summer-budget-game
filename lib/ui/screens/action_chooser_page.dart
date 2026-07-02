import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ActionChooserPage extends StatefulWidget {
  const ActionChooserPage({Key? key}) : super(key: key);

  @override
  _ActionChooserPageState createState() => _ActionChooserPageState();
}

class _ActionChooserPageState extends State<ActionChooserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Action Chooser'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Action Chooser Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
