import 'package:countdown_flutter_copy/countdown_flutter_copy.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _done = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(_done ? 'Finished!' : 'Counting...'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Center(
              child: CountdownFormatted(
                duration: const Duration(hours: 2),
                builder: (BuildContext ctx, String remaining) {
                  return Text(
                    remaining,
                    style: const TextStyle(fontSize: 30),
                  ); // 01:00:00
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
