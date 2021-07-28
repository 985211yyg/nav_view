//
//  HYMapPointFactory.swift
//
//  Created by 冰空花束 on 2020/3/27.
//
import Flutter
import Foundation

class MapPointFlutterCreate: NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return HYGaodeMapPointView(frame: frame, viewId: viewId, messenger: messanger, args: args ?? "")
    }
    
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
    
    var messanger: FlutterBinaryMessenger!
    
    
    @objc public init(messanger: (NSObject & FlutterBinaryMessenger)?) {
        super.init()
        self.messanger = messanger
    }
    
}
