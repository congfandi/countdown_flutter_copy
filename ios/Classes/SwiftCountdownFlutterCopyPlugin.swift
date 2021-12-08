import Flutter
import UIKit

public class SwiftCountdownFlutterCopyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "countdown_flutter_copy", binaryMessenger: registrar.messenger())
    let instance = SwiftCountdownFlutterCopyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
