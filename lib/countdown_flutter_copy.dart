import 'dart:async';

import 'package:countdown_flutter_copy/utils.dart';
import 'package:flutter/cupertino.dart';

class CountdownFlutterCopy extends StatefulWidget {
  const CountdownFlutterCopy({
    Key? key,
    required this.duration,
    required this.builder,
    this.onFinish,
    this.countdownStatus = CountdownStatus.play,
    this.interval = const Duration(seconds: 1),
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final CountdownStatus? countdownStatus;
  final void Function()? onFinish;
  final Widget Function(BuildContext context, Duration remaining) builder;

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<CountdownFlutterCopy> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    _duration = widget.duration;
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(widget.interval, timerCallback);
  }

  void timerCallback(Timer timer) {
    if (widget.countdownStatus == CountdownStatus.play) {
      if (timer.isActive) {
        setState(() {
          if (_duration.inSeconds == 0) {
            timer.cancel();
            if (widget.onFinish != null) widget.onFinish!();
          } else {
            _duration = Duration(seconds: _duration.inSeconds - 1);
          }
        });
      }
    } else {
      setState(() {
        timer.cancel();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!_timer.isActive && widget.countdownStatus == CountdownStatus.play){
      startTimer();
    }
    return widget.builder(context, _duration);
  }
}

class CountdownFormatted extends StatelessWidget {
  const CountdownFormatted({
    Key? key,
    required this.duration,
    required this.builder,
    this.onFinish,
    this.interval = const Duration(seconds: 1),
    this.formatter,
  }) : super(key: key);

  final Duration duration;
  final Duration interval;
  final void Function()? onFinish;

  /// An function to format the remaining time
  final String Function(Duration)? formatter;

  final Widget Function(BuildContext context, String remaining) builder;

  Function(Duration) _formatter() {
    if (formatter != null) return formatter!;
    if (duration.inHours >= 1) return formatByHours;
    if (duration.inMinutes >= 1) return formatByMinutes;

    return formatBySeconds;
  }

  @override
  Widget build(BuildContext context) {
    return CountdownFlutterCopy(
      interval: interval,
      onFinish: onFinish,
      duration: duration,
      builder: (BuildContext ctx, Duration remaining) {
        return builder(ctx, _formatter()(remaining));
      },
    );
  }
}

enum CountdownStatus { stop, pause, play }
