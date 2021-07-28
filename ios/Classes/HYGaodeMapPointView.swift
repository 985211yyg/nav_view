//
//  HYMapPointController.swift
//  AFNetworking
//
//  Created by 冰空花束 on 2020/3/27.
//

import Foundation
import AMapNaviKit
import AMapFoundationKit
import SwiftyJSON
import Flutter

class HYGaodeMapPointView: NSObject, FlutterPlatformView, MAMapViewDelegate{
    let frame: CGRect
    let viewId: Int64
    var messenger: FlutterBinaryMessenger!
    let args: Any?
    let targetBundle: Bundle
    let mapViewData: MAMapView
    var points: [MAAnnotation]
    var compositeManager: AMapNaviCompositeManager?
    //    var startPoint: MAPointAnnotation?
    //    var endPoint: MAPointAnnotation?
    
    init(frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger, args: Any) {
        self.frame = frame
        self.viewId = viewId
        self.messenger = messenger
        self.args = args
        self.mapViewData = MAMapView.init(frame: frame)
        let bundle = Bundle(for: HYGaodeMapPointView.self)
        let bundleUrl = bundle.url(forResource: "nav_view_Bundle", withExtension: "bundle")
        self.targetBundle = Bundle(url: bundleUrl!)!
        print(args)
        self.points = []
        
        
        super.init()
        initMethodChannel()
        mapViewData.delegate = self
        //        let startOrEndParams: StartOrEndParams?
        do {
            let jsonData = try (args as! String).data(using: .utf8, allowLossyConversion: false)
            let json = try JSON(data: jsonData!)
            for item in json.arrayValue {
                setPointAnnotation(lat: item["lat"].double ?? 0.0, lng: item["lng"].double ?? 0.0, name: item["name"].string ?? "")
            }
            
        } catch let err {
            print("解析flutter传入参数出现错误\n \(err)")
        }
        
        print(points)
        
        mapViewData.addAnnotations(points)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.mapViewData.showAnnotations(self.mapViewData.annotations, edgePadding: UIEdgeInsets(top: 80, left: 80, bottom: 80, right: 80), animated: true)
            
        })
    }
    
    
    func view() -> UIView {
        return mapViewData
    }
    
    private func setPointAnnotation(lat: Double, lng: Double, name: String = "") {
        let pointAnnotation = POIAnnotation(title: name, lat: CGFloat(lat), lng: CGFloat(lng))
        
//        pointAnnotation.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(lng))
//        pointAnnotation.title = name
//        pointAnnotation.id
        //        pointAnnotation.subtitle = name
        
        self.points.append(pointAnnotation)
        
    }
    
    func initMethodChannel(){
        let channel = FlutterMethodChannel.init(name: "com.reemii.location_view.channel/\(viewId)", binaryMessenger: messenger);
        //Flutter与原生代码通信用的消息通道
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if call.method == "movePosition" {
                //do something
                let args: [String: Any?] = call.arguments as! [String: Any?]
                let amapCorrdinate = AMapCoordinateConvert(CLLocationCoordinate2D(latitude: args["lat"] as! Double, longitude: args["lng"] as! Double), .aMap)
                self.mapViewData.setCenter(CLLocationCoordinate2DMake(amapCorrdinate.latitude, amapCorrdinate.longitude), animated: true)
            }else if call.method == "navSingle" {
                let compositeManager = AMapNaviCompositeManager.init()
                let config = AMapNaviCompositeUserConfig.init()
                let args: [String: Any?] = call.arguments as! [String: Any?]
                let amapCorrdinate = AMapCoordinateConvert(CLLocationCoordinate2D(latitude: args["lat"] as! Double, longitude: args["lng"] as! Double), .baidu)
                config.setRoutePlanPOIType(AMapNaviRoutePlanPOIType.end, location: AMapNaviPoint.location(withLatitude: CGFloat(amapCorrdinate.latitude), longitude: CGFloat(amapCorrdinate.longitude)), name: args["address"] as? String, poiId: nil)
                config.setNeedShowConfirmViewWhenStopGPSNavi(false)
//                config.setNeedDestoryDriveManagerInstanceWhenDismiss(false)
                config.setStartNaviDirectly(true)
                compositeManager.presentRoutePlanViewController(withOptions: config)
            }else if call.method == "navRoute" {
                let compositeManager = AMapNaviCompositeManager.init()
                let config = AMapNaviCompositeUserConfig.init()
                do {
                    let jsonData = try (call.arguments as! String).data(using: .utf8, allowLossyConversion: false)
                    let json = try JSON(data: jsonData!)
                    let arr = json.arrayValue
                    for (index, item) in arr.enumerated() {
                        let amapCorrdinate = AMapCoordinateConvert(CLLocationCoordinate2D(latitude: item["lat"].double ?? 0.0, longitude: item["lng"].double ?? 0.0), .baidu)
                        if index == (arr.count - 1) {
                            config.setRoutePlanPOIType(AMapNaviRoutePlanPOIType.end, location: AMapNaviPoint.location(withLatitude: CGFloat(amapCorrdinate.latitude), longitude: CGFloat(amapCorrdinate.longitude)), name: item["name"].string, poiId: nil)
                        } else {
                            config.setRoutePlanPOIType(AMapNaviRoutePlanPOIType.way, location: AMapNaviPoint.location(withLatitude: CGFloat(amapCorrdinate.latitude), longitude: CGFloat(amapCorrdinate.longitude)), name: item["name"].string, poiId: nil)
                        }
                    }
                    
                } catch let err {
                    print("解析flutter传入参数出现错误\n \(err)")
                }
                config.setNeedShowConfirmViewWhenStopGPSNavi(false)
//                config.setNeedDestoryDriveManagerInstanceWhenDismiss(false)
                config.setStartNaviDirectly(true)
                
                compositeManager.presentRoutePlanViewController(withOptions: config)
            }
        });
    }
    
    deinit {
        print("显示点地图组建销毁！！")
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: POIAnnotation.self) {
            
            //标注的view的初始化和复用
            let pointReuseIndetifier = "poiIdentifier"
            
            var poiAnnotationView: MAInfowindowView! = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier) as! MAInfowindowView?
            
            if poiAnnotationView == nil {
                poiAnnotationView = MAInfowindowView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
                poiAnnotationView!.canShowCallout = false
            }
            
            poiAnnotationView.giveTitleText(text: (annotation as! POIAnnotation).getName)
            
            return poiAnnotationView!
        }
        
        return nil
    }
}

class MAInfowindowView: MAAnnotationView {
    
    var titleLabel : UILabel!
    
    let kMinWidth = CGFloat(20)
    let kMaxWidth = CGFloat(200)
    let kHeight = CGFloat(44)
    let KHoriMargin = CGFloat(3)
    let kVertMargin = CGFloat(3)
    let kFontSize = CGFloat(14)
    let kArrorHeight = CGFloat(8)
    let kBackgroundColor = UIColor.white
    
    override init!(annotation: MAAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        
        self.backgroundColor = UIColor.clear
        self.bounds = CGRect.init(x: 0, y: 0, width: kMinWidth, height: kHeight)
        self.centerOffset = CGPoint.init(x: 0, y:  -kHeight / 2.0)
        
        self.titleLabel = UILabel()
        self.titleLabel.backgroundColor = UIColor.clear
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.font = UIFont.systemFont(ofSize: CGFloat(kFontSize))
        self.addSubview(self.titleLabel)

    }
    
    public func giveTitleText (text: String) {
        
        self.titleLabel.text = text
        
        self.titleLabel.sizeToFit()
        
        if self.titleLabel.frame.size.width > kMaxWidth {
            self.titleLabel.frame = CGRect.init(x: 0, y: 0, width: kMaxWidth, height: kHeight - kVertMargin * 2 - kArrorHeight)
        }
        
        self.bounds = CGRect.init(x: 0, y: 0, width: self.titleLabel.frame.size.width + KHoriMargin * 2, height: kHeight)
        
        self.titleLabel.center = CGPoint.init(x: self.bounds.midX, y: self.bounds.midY - kVertMargin)
    }
    
    override func draw(_ rect: CGRect) {
        self.draw(context: UIGraphicsGetCurrentContext()!)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: CGFloat(0.0), height: CGFloat(0.0))
    }
    
    func draw(context: CGContext) {
        context.setLineWidth(CGFloat(1.0))
        context.setFillColor(kBackgroundColor.cgColor)
        self.getDrawPath(context:context)
        context.fillPath()
    }
    
    func getDrawPath(context: CGContext) {
        let rrect: CGRect = self.bounds
        let radius: CGFloat = 6.0
        let minx: CGFloat = rrect.minX
        let midx: CGFloat = rrect.midX
        let maxx: CGFloat = rrect.maxX
        let miny: CGFloat = rrect.minY
        let maxy: CGFloat = rrect.maxY - kArrorHeight
        context.move(to: CGPoint(x: CGFloat(midx + kArrorHeight), y: maxy))
        context.addLine(to: CGPoint(x: midx, y: CGFloat(maxy + kArrorHeight)))
        context.addLine(to: CGPoint(x: CGFloat(midx - kArrorHeight), y: maxy))
        context.addArc(tangent1End: CGPoint(x: minx, y: maxy), tangent2End: CGPoint(x: minx, y: miny), radius: radius)
        context.addArc(tangent1End: CGPoint(x: minx, y: minx), tangent2End: CGPoint(x: maxx, y: miny), radius: radius)
        context.addArc(tangent1End: CGPoint(x: maxx, y: miny), tangent2End: CGPoint(x: maxx, y: maxx), radius: radius)
        context.addArc(tangent1End: CGPoint(x: maxx, y: maxy), tangent2End: CGPoint(x: midx, y: maxy), radius: radius)
        context.closePath()
    }

}

class POIAnnotation: NSObject,MAAnnotation {
    
    let _title: String
    let _subtitle: String
    let lat: CGFloat
    let lng: CGFloat
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(CLLocationDegrees(self.lat), CLLocationDegrees(self.lng))
        }
    }
    
    var getName: String {
        get {
            return self.title
        }
    }
    
    private var title: String {
        get {
            return self._title
        }
    }
    
    private var subtitle: String {
        get {
            return self._subtitle
        }
    }
    
    init(title: String = "", subtitle: String = "", lat: CGFloat = 0.0, lng: CGFloat = 0.0) {

        self._title = title
        self._subtitle = subtitle
        self.lat = lat
        self.lng =  lng
                super.init()
    }
    
}
