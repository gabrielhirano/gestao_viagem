import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

const task = 'firstTask';

class TesteApp extends StatefulWidget {
  const TesteApp({super.key});

  @override
  State<TesteApp> createState() => _TesteAppState();
}

class _TesteAppState extends State<TesteApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work',
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                var uniqueId = DateTime.now().second.toString();
                print('set ${uniqueId}');

                await Workmanager().registerPeriodicTask(
                  uniqueId,
                  task,
                  constraints: Constraints(networkType: NetworkType.connected),
                  inputData: {
                    'data': '${DateTime.now().minute}: ${DateTime.now().second}'
                  },
                );
              },
              child: Text('Work')),
        ),
      ),
    );
  }
}
