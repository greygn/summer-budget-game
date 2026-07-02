import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class JobChooserPage extends StatefulWidget {
  const JobChooserPage({Key? key}) : super(key: key);

  @override
  _JobChooserPageState createState() => _JobChooserPageState();
}

class _JobChooserPageState extends State<JobChooserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Job Chooser'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Job Chooser Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
