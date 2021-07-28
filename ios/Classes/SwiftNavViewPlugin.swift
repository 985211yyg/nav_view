import Flutter
import UIKit

public class SwiftFlutterMapPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        //    let channel = FlutterMethodChannel(name: "nav_view", binaryMessenger: registrar.messenger())
        //    let instance = SwiftFlutterMapPlugin()
        //    registrar.addMethodCallDelegate(instance, channel: channel)
        let mapMessenger = registrar.messenger() as! (NSObject & FlutterBinaryMessenger)
        registrar.register(MapFlutterCreate.init(messanger: mapMessenger), withId: "com.reemii.mapView")
        
        let mapPointMessenger = registrar.messenger() as! (NSObject & FlutterBinaryMessenger)
        registrar.register(MapPointFlutterCreate.init(messanger: mapPointMessenger), withId: "com.reemii.locationView")
        
        let naviMessaenger = registrar.messenger() as! (NSObject & FlutterBinaryMessenger)
        registrar.register(NaviFlutterCreate.init(messanger: naviMessaenger), withId: "com.reemii.navView")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
    
    
}
