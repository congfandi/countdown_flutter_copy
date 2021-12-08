
import 'dart:async';

import 'package:flutter/services.dart';

class CountdownFlutterCopy {
  static const MethodChannel _channel = MethodChannel('countdown_flutter_copy');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
