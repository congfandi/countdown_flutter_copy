import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:countdown_flutter_copy/countdown_flutter_copy.dart';

void main() {
  const MethodChannel channel = MethodChannel('countdown_flutter_copy');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await CountdownFlutterCopy.platformVersion, '42');
  });
}
