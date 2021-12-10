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
            Row(
              children: [
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: 120,
                  child: CountdownFormatted(
                    onTick: (duration) {
                      debugPrint("tick");
                    },
                    builder: (ctx, String duration) {
                      return Text(
                        duration,
                        style: const TextStyle(fontSize: 30),
                      );
                    },
                    interval: const Duration(seconds: 1),
                    duration: Duration(minutes: (45/60).ceil()),
                    countdownStatus: status,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
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
