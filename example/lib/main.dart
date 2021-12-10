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

  String buttonText = "pause";
  CountdownStatus status = CountdownStatus.play;

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
              child: CountdownFlutterCopy(
                builder: (ctx, duration) {
                  return Text(
                    "${duration.inSeconds}",
                    style: const TextStyle(fontSize: 30),
                  );
                },
                interval: const Duration(seconds: 1),
                duration: const Duration(hours: 2),
                countdownStatus: status,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (status == CountdownStatus.play) {
                      status = CountdownStatus.pause;
                    } else {
                      status = CountdownStatus.play;
                    }
                    buttonText = buttonText == "play" ? "pause" : "play";
                  });
                },
                child: Text(buttonText))
          ],
        ),
      ),
    );
  }
}
