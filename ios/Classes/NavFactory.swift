//
//  NavFactory.swift
//  bdmap
//
//  Created by 冰空花束 on 2020/2/20.
//

import Foundation

class NaviFlutterCreate: NSObject, FlutterPlatformViewFactory {
    fileprivate var naviViewFl:FlutterPlatformView?
    fileprivate var frame: CGRect?
    fileprivate var viewId: Int64?
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        if self.frame != frame || self.viewId != viewId || self.naviViewFl == nil {
            self.naviViewFl = NaviViewFl(frame: frame, viewId: viewId, messenger: messanger, args: args ?? "")
            self.frame = frame
        }
        return self.naviViewFl!
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
