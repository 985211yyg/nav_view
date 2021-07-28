//
//  File.swift
//  nav_view
//
//  Created by 冰空花束 on 2020/2/16.
//

import Foundation

class MapFlutterCreate: NSObject, FlutterPlatformViewFactory {
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return GaodeMapView(frame: frame, viewId: viewId, messenger: messanger, args: args ?? "")
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
