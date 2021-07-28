//
//  NavViewController.swift
//  bdmap
//
//  Created by 冰空花束 on 2020/2/20.
//

import UIKit
import AMapSearchKit
import AMapNaviKit
import AMapFoundationKit
import SnapKit
import Flutter

class NaviViewFl: NSObject, FlutterPlatformView, AMapNaviDriveManagerDelegate, FlutterStreamHandler, UINavigationBarDelegate {
    let frame: CGRect;
    let viewId: Int64;
    var messenger: FlutterBinaryMessenger!
    let args: Dictionary<String, Any>;
    fileprivate let startLat: CGFloat
    fileprivate let startLng: CGFloat
    fileprivate let endLat: CGFloat
    fileprivate let endLng: CGFloat
    fileprivate let orderId: String
    //    let endPoint: CLLocationCoordinate2D?
    var driveView: AMapNaviDriveView?
    
    fileprivate var count: Int! = 0
    fileprivate var showModeIndex: Int = 2
    fileprivate var locations: [[String: Any]]! = []
    fileprivate var currentLocation: CLLocationCoordinate2D!
    fileprivate var currentSpeed: Int?
    fileprivate var _eventSink: FlutterEventSink?
    fileprivate var search: AMapSearchAPI?
    fileprivate var backLocation: FlutterResult?
    fileprivate var hiddenUI: Bool = true
    fileprivate var tempNaviInfo: AMapNaviInfo!
    fileprivate var driveManagerInfo: AMapNaviRoute?
    var locationTimer: Timer?
    
    fileprivate var channel: FlutterMethodChannel?
    fileprivate var saveDrivingStrategy: AMapNaviDrivingStrategy?
//    fileprivate let peucker = HYDouglasPeucker()
    
    init(frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger, args: Any) {
        self.frame = frame
        self.viewId = viewId
        self.messenger = messenger
        
        self.args = args as! Dictionary<String, Any>
        
        self.startLat = CGFloat((self.args["startNavLatLng"] as! [Double])[0])
        self.startLng = CGFloat((self.args["startNavLatLng"] as! [Double])[1])
        self.endLat = CGFloat((self.args["endNavLatLng"] as! [Double])[0])
        self.endLng = CGFloat((self.args["endNavLatLng"] as! [Double])[1])
        self.orderId = self.args["orderId"] as! String
        print("============")
        print(orderId)
        super.init()
        self.locationTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(NaviViewFl.updateDriveManager), userInfo: nil, repeats: true)
        
        initMethodChannel()
        initDriveView(frame: frame)
        initDriveManager()
        let channelName = "com.reemii.nav_view.Event/" + String(viewId)
        print(channelName)
        let evenChannal = FlutterEventChannel.init(name: channelName, binaryMessenger: messenger)
        evenChannal.setStreamHandler(self)
        self.search = AMapSearchAPI()
        search!.delegate = self
    }
    
    func initDriveManager() {
        AMapNaviDriveManager.sharedInstance().delegate = self as AMapNaviDriveManagerDelegate
        AMapNaviDriveManager.sharedInstance().isUseInternalTTS = true
        AMapNaviDriveManager.sharedInstance().setOnlineCarHailingType(.transport)
        
    }
    
    func initDriveView(frame: CGRect) {
        driveView = AMapNaviDriveView(frame: frame)
        driveView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        driveView?.delegate = self
        driveView?.showMoreButton = false
        driveView?.showGreyAfterPass = true
        driveView?.showBrowseRouteButton = true
        driveView?.maxRenderFrame = 60
        driveView?.showUIElements = false
        driveView?.trackingMode = .carNorth;
        
        AMapNaviDriveManager.sharedInstance().addDataRepresentative(driveView!)
        AMapNaviDriveManager.sharedInstance().addDataRepresentative(self)
        
    }
    
    func showModeAction() {
        
        if showModeIndex == 2 {
            showModeIndex = 0
        }
        else {
            showModeIndex += 1
        }
        //改变界面的显示模式
        switch showModeIndex {
        case 0:
            driveView!.showMode = .carPositionLocked
        case 1:
            driveView!.showMode = .overview
        case 2:
            driveView!.showMode = .normal
        default:
            break
        }
    }
    
    //    func initDriveView() {
    //        driveView = AMapNaviDriveView()
    //        driveView?.delegate = self
    //        driveView?.showMoreButton = false
    //        driveView?.showGreyAfterPass = true
    //        driveView?.showBrowseRouteButton = true
    //        driveView?.maxRenderFrame = 60
    //        driveView?.showUIElements = false
    //        driveView?.showMoreButton = false
    //D
    //    }
    
    func calculateRoute(drivingStrategy : AMapNaviDrivingStrategy = AMapNaviDrivingStrategy.singleDefault) {
        if self.saveDrivingStrategy != nil && self.saveDrivingStrategy == drivingStrategy {
            return
        }
        self.saveDrivingStrategy = drivingStrategy
        //进行路径规划
        AMapNaviDriveManager.sharedInstance().calculateDriveRoute(withStart: [AMapNaviPoint.location(withLatitude:  startLat, longitude: startLng)], end: [AMapNaviPoint.location(withLatitude: endLat, longitude:  endLng)], wayPoints: nil, drivingStrategy: drivingStrategy)
    }
    
    
    func view() -> UIView {
        return driveView!
    }
    
    func initMethodChannel(){
        self.channel = FlutterMethodChannel.init(name: "com.reemii.nav_view.channel/" + String(viewId), binaryMessenger: messenger);
        //Flutter与原生代码通信用的消息通道
        channel?.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if(call.method == "nav/calcuteRoute"){
                //do something
                self.calculateRoute()
                //                self.driveManager(onCalculateRouteSuccess: AMapNaviDriveManager.sharedInstance())
            }else if(call.method == "nav/startNav"){
                //算路成功后进行模拟导航
                AMapNaviDriveManager.sharedInstance().startGPSNavi()
//                AMapNaviDriveManager.sharedInstance().startEmulatorNavi()
                self.locationTimer?.fire()
            }else if(call.method == "nav/setTitle"){
                //                call.arguments
                print(call.arguments as Any)
            }
            else if (call.method == "nav/dispose") {
                result(self.destroyDriveView())
//                result(true)
            } else if call.method == "nav/parsingAddress" {
                let request = AMapReGeocodeSearchRequest()
                
                let args: [String: Double] = call.arguments as! [String: Double]
                request.location = AMapGeoPoint.location(withLatitude: CGFloat(args["lat"] ?? 0), longitude: CGFloat(args["lng"] ?? 0))
                request.requireExtension = true
                self.search?.aMapReGoecodeSearch(request)
                self.backLocation = result
            } else if call.method == "nav/passengerLocation" {
                
            } else if call.method == "nav/showModeAction" {
                self.showModeAction()
            } else if call.method == "nav/strategyConvert" {
                let args: [String: Bool] = call.arguments as! [String: Bool]
                let drivingStrategy = ConvertDrivingPreferenceToDrivingStrategy(args["multipleRoute"] ?? false,
                                                          args["avoidCongestion"] ?? false,
                                                          args["avoidHighway"] ?? false,
                                                          args["avoidCost"] ?? false,
                                                          args["prioritiseHighway"] ?? false)
                self.calculateRoute(drivingStrategy: drivingStrategy)
            }
            
        });
    }
    
    @objc func updateDriveManager() {
        let param = ["order_id": self.orderId , "key":  NAVI_INFO_KEY, "value": backNaviInfoJson(naviInfo: self.tempNaviInfo ?? AMapNaviInfo(), speed: currentSpeed ?? 0, location: currentLocation ?? CLLocationCoordinate2D(), locations: locations).rawString(.utf8, options: []) ?? ""] as [String : Any]
        uploadLineInfo(param: param, success: { (data) in
            print("信息数据上传")
            print(data)
        }) { (error) in
            print("出现错误：", error)
        }
//        let paramPath = ["order_id": orderId , "key":  TRACE_KEY, "value": backNaviPathJson(naviPath: self.driveManagerInfo ?? AMapNaviRoute()).rawString(.utf8, options: []) ?? ""] as [String : Any]
//        uploadLineInfo(param: paramPath, success: { (data) in
//            print("导航数据上传")
//            print(data)
//        }) { (error) in
//            print("出现错误：", error)
//        }
//        print(param)
//        print(paramPath)
        
        locations.removeAll()
    }
    
    @objc func popNativeView() {
        print("back_tip")
        _eventSink!("back_tip")
    }
    
    @objc func openInfo() {
        print("order")
        _eventSink!("order")
    }
    
    func destroyDriveView() -> Bool {
        AMapNaviDriveManager.sharedInstance().stopNavi()
        AMapNaviDriveManager.sharedInstance().removeDataRepresentative(driveView!)
        AMapNaviDriveManager.sharedInstance().removeDataRepresentative(self)
        AMapNaviDriveManager.sharedInstance().delegate = nil
        self.locationTimer?.invalidate()
        
        let success = AMapNaviDriveManager.destroyInstance()
        NSLog("单例是否销毁成功 : \(success)")
        
        driveView!.removeFromSuperview()
        self.locationTimer = nil
        driveView!.delegate = nil
        return success
    }
    
    deinit {
//        destroyDriveView()
    }
}

extension NaviViewFl: AMapNaviDriveDataRepresentable {
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("获取event")
        _eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        _eventSink = nil
        return nil
    }
    
    func driveManager(_ driveManager: AMapNaviDriveManager, updateTurnIconImage turnIconImage: UIImage?, turn turnIconType: AMapNaviIconType) {
        //        turnTip?.image = turnIconImage
        let imgData = turnIconImage?.pngData()
        let flutterData = FlutterStandardTypedData(bytes: imgData ?? Data())
        self.channel?.invokeMethod("setNaviTurnTipIcon", arguments: flutterData)
    }
    
    func driveManager(onCalculateRouteSuccess driveManager: AMapNaviDriveManager) {
        NSLog("CalculateRouteSuccess")
        
        _eventSink!("calculateSuccess")
        self.driveManagerInfo = driveManager.naviRoute ?? AMapNaviRoute()
    }
    
    // 规划失败回调
//    func driveManager(_ driveManager: AMapNaviDriveManager, onCalculateRouteFailure error: Error, routePlanType type: AMapNaviRoutePlanType) {
//        NSLog("CalculateRouteFailure")
//
//        print(error.localizedDescription)
//    }
    
    func driveManager(_ driveManager: AMapNaviDriveManager, onCalculateRouteFailure error: Error) {
                NSLog("CalculateRouteFailure")
        
                print(error.localizedDescription)
    }
    
    // 路线偏离规划调用
    func driveManagerNeedRecalculateRoute(forYaw driveManager: AMapNaviDriveManager) {
        let param = ["order_id": orderId , "key":  TRACE_KEY, "value": backNaviPathJson(naviPath: driveManager.naviRoute ?? AMapNaviRoute()).rawString(.utf8, options: []) ?? ""] as [String : Any]
        uploadLineInfo(param: param, success: { (data) in
            print("上传成功0")
            print(data)
        }) { (error) in
            print("上传出现异常0")
            print(error)
        }
    }
    
    func driveManager(onArrivedDestination driveManager: AMapNaviDriveManager) {
        let param = ["order_id": orderId , "key":  NAVI_INFO_KEY, "value": backNaviInfoJson(naviInfo: tempNaviInfo ?? AMapNaviInfo(), speed: currentSpeed ?? 0, location: currentLocation ?? CLLocationCoordinate2D(), locations: locations).rawString(.utf8, options: []) ?? ""] as [String : Any]
        uploadLineInfo(param: param, success: { (data) in
            print(data)
            print("上传路径成功！！！1")
        }) { (error) in
            print("上传出现异常1")
            print(error)
        }
        locations.removeAll()
    }
    
    //    driveManage
    
    func driveManager(_ driveManager: AMapNaviDriveManager, didStartNavi naviMode: AMapNaviMode) {
        
        let param = ["order_id": orderId , "key":  TRACE_KEY, "value": backNaviPathJson(naviPath: driveManager.naviRoute ?? AMapNaviRoute()).rawString(.utf8, options: []) ?? ""] as [String : Any]
        uploadLineInfo(param: param, success: { (data) in
            print(data)
            print("上传路径信息成功！！！0")
        }) { (error) in
            print("上传出现异常0")
            print(error)
        }
    }
    
    func driveManagerDidEndEmulatorNavi(_ driveManager: AMapNaviDriveManager) {
        let param = ["order_id": orderId , "key":  NAVI_INFO_KEY, "value": backNaviInfoJson(naviInfo: tempNaviInfo ?? AMapNaviInfo(), speed: currentSpeed ?? 0, location: currentLocation ?? CLLocationCoordinate2D(), locations: locations).rawString(.utf8, options: []) ?? ""] as [String : Any]
        uploadLineInfo(param: param, success: { (data) in
            print(data)
            print("上传路径信息成功！！！1")
        }) { (error) in
            print("上传出现异常1")
            print(error)
        }
        locations.removeAll()
    }
    
    func driveManager(_ driveManager: AMapNaviDriveManager, error: Error) {
        print(error)
    }
    
    func driveManager(_ driveManager: AMapNaviDriveManager, update naviInfo: AMapNaviInfo?) {
        if (naviInfo != nil) {
            tempNaviInfo = naviInfo
            self.driveManagerInfo = driveManager.naviRoute ?? AMapNaviRoute()
            let remainTime = (naviInfo?.routeRemainTime ?? 0) / 60
            let remainDistance = (naviInfo?.routeRemainDistance ?? 0) / 1000
            let date = Int(Date().timeIntervalSince1970) + naviInfo!.routeRemainTime
            
            //            residueTime?.text = "剩余 \(remainDistance)公里 \(remainTime)分钟"
            //
            //            nextRoudDis?.text = "\(naviInfo?.segmentRemainDistance ?? 0)米 进入"
            //            roudeName?.text = naviInfo?.nextRoadName ?? "无名道路"
            //            overTime?.text = "预计\(formatTime(date: Date.init(timeIntervalSince1970: TimeInterval.init(exactly: date)!)))到达"
            
            let naviInfo = [
                "residueTime": "剩余 \(remainDistance)公里 \(remainTime)分钟",
                "nextRoudDis": "\(naviInfo?.segmentRemainDistance ?? 0)",
                "roudeName": naviInfo?.nextRoadName ?? "无名道路",
                "overTime": formatTime(date: Date.init(timeIntervalSince1970: TimeInterval.init(exactly: date)!))
            ]
            
            self.channel?.invokeMethod("setNaviInfo", arguments: naviInfo)
        }
    }
    
    func driveManager(_ driveManager: AMapNaviDriveManager, update naviLocation: AMapNaviLocation?) {
        currentSpeed = naviLocation?.speed ?? 0
        currentLocation = CLLocationCoordinate2D(latitude: Double(naviLocation?.coordinate.latitude ?? 0.0), longitude: Double(naviLocation?.coordinate.longitude ?? 0.0))
        locations.append(["latitude": currentLocation.latitude, "longitude": currentLocation.longitude])
    }
    
    func driveManager(_ driveManager: AMapNaviDriveManager, showCross crossImage: UIImage) {
        NSLog("showCrossImage")
        let imgData = crossImage.pngData()
        let flutterData = FlutterStandardTypedData(bytes: imgData ?? Data())
        self.channel?.invokeMethod("setNaviCrossTipIcon", arguments: flutterData)
    }
    
    func driveManagerHideCrossImage(_ driveManager: AMapNaviDriveManager) {
        NSLog("hideCrossImage")
        //隐藏路口放大图
        self.channel?.invokeMethod("setNaviCrossTipIcon", arguments: nil)
    }
}



extension NaviViewFl: AMapNaviDriveViewDelegate {
    func driveViewCloseButtonClicked(_ driveView: AMapNaviDriveView) {
        //        showNaviInfo()
    }
}

extension NaviViewFl: AMapSearchDelegate {
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        if response.regeocode == nil {
            print("解析失败！！！")
            return
        }
        if (backLocation != nil) {
            print("解析成功！！")
            backLocation!(response.regeocode.formattedAddress)
            backLocation = nil
        }
        
    }
}

//extension NaviViewFl {
//    func computedDouglasPeucher(pointList: [LatLngEntity]) -> [LatLngEntity] {
//        peucker.douglasAlgorithm(pointList, threshold: 5.0) as! [LatLngEntity]
//    }
//}
