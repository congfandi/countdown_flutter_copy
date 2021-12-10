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
    this.onTick,
    this.interval = const Duration(seconds: 1),
  }) : super(key: key);

  /* duration
    you can use this variable to know how long the time will be on
   */
  final Duration duration;

  /* interval
  you can use this interval to setup timer between time type like second,minute etc
  */
  final Duration interval;

  /*countdownStatus
  this status to know the status of timer and we can pause timer using this status
  */
  final CountdownStatus? countdownStatus;

  /*onFinish
  this is callbak to let you know that timer is times up
  */
  final void Function()? onFinish;

  /*onTick
  you can use this callback to do something in every single tick of timer
  */
  final void Function(Duration duration)? onTick;

  /*builder
  this function will genereted as widget in your project
  */
  final Widget Function(BuildContext context, Duration remaining) builder;

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<CountdownFlutterCopy> {
  /*set timer timer*/
  late Timer _timer;

  /*set duration*/
  late Duration _duration;

  /*initilise timer*/
  @override
  void initState() {
    _duration = widget.duration;
    startTimer();
    super.initState();
  }

  /*Kill timer when you close your page*/
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  /*start timer */
  void startTimer() {
    _timer = Timer.periodic(widget.interval, timerCallback);
  }

  /*setup callback for timer*/
  void timerCallback(Timer timer) {
    if (widget.countdownStatus == CountdownStatus.play) {
      if (timer.isActive) {
        setState(() {
          if (_duration.inSeconds == 0) {
            timer.cancel();
            if (widget.onFinish != null) widget.onFinish!();
          } else {
            _duration = Duration(seconds: _duration.inSeconds - 1);
            if (widget.onTick != null) widget.onTick!(_duration);
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
    if (!_timer.isActive && widget.countdownStatus == CountdownStatus.play) {
      startTimer();
    }
    return widget.builder(context, _duration);
  }
}

class CountdownFormatted extends StatelessWidget {
  const CountdownFormatted(
      {Key? key,
      required this.duration,
      required this.builder,
      this.onFinish,
      this.countdownStatus = CountdownStatus.play,
      this.onTick,
      this.interval = const Duration(seconds: 1),
      this.formatter})
      : super(key: key);

  /* duration
    you can use this variable to know how long the time will be on
   */
  final Duration duration;

  /* interval
  you can use this interval to setup timer between time type like second,minute etc
  */
  final Duration interval;

  /*countdownStatus
  this status to know the status of timer and we can pause timer using this status
  */
  final CountdownStatus? countdownStatus;

  /*onFinish
  this is callbak to let you know that timer is times up
  */
  final void Function()? onFinish;

  /*onTick
  you can use this callback to do something in every single tick of timer
  */
  final void Function(Duration duration)? onTick;

  /*builder
  this function will genereted as widget in your project
  */
  final Widget Function(BuildContext context, String remaining) builder;

  /// An function to format the remaining time
  final String Function(Duration)? formatter;

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
      onTick: onTick,
      countdownStatus: countdownStatus,
      builder: (BuildContext ctx, Duration remaining) {
        return builder(ctx, _formatter()(remaining));
      },
    );
  }
}

//this enum function to set timer status
enum CountdownStatus { stop, pause, play }
