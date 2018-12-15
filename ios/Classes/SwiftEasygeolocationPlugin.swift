import Flutter
import CoreLocation
import UIKit

public class SwiftEasygeolocationPlugin: NSObject, FlutterPlugin, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var localService:LocationService?
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "easygeolocation", binaryMessenger: registrar.messenger())
    let instance = SwiftEasygeolocationPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        localService = LocationService.init(resultHandler: result, arguments: call.arguments)
        if call.method == "getCurrentPosition" {
            localService?.getCurrentPosition()
        } else {
            result([
                "status": "FlutterMethodNotImplemented"
                ])
        }
    }
}
