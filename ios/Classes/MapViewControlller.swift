//
//  MapViewControlller.swift
//  Pods
//
//  Created by 冰空花束 on 2020/2/16.
//


import UIKit
import AMapNaviKit
import AMapFoundationKit
import SwiftyJSON

class GaodeMapView: NSObject, FlutterPlatformView, MAMapViewDelegate{
    let frame: CGRect
    let viewId: Int64
    var messenger: FlutterBinaryMessenger!
    let args: Any?
    let targetBundle: Bundle
    let mapViewData: MAMapView
    var startPoint: MAPointAnnotation?
    var endPoint: MAPointAnnotation?
    
    init(frame: CGRect, viewId: Int64, messenger: FlutterBinaryMessenger, args: Any) {
        self.frame = frame
        self.viewId = viewId
        self.messenger = messenger
        self.args = args
        self.mapViewData = MAMapView.init(frame: frame)
        let bundle = Bundle(for: GaodeMapView.self)
        let bundleUrl = bundle.url(forResource: "nav_view_Bundle", withExtension: "bundle")
        self.targetBundle = Bundle(url: bundleUrl!)!
        print(args)
        
        
        
        super.init()
        initMapViewDateInfo()
    }
    
    func initMapViewDateInfo() {
        mapViewData.delegate = self
        //        let startOrEndParams: StartOrEndParams?
        
        do {
            let jsonData = try (args as! String).data(using: .utf8, allowLossyConversion: false)
            let json = try JSON(data: jsonData!)
            setStartPoint(lat: json["start_lat"].double, lng: json["start_lng"].double, place: json["start_place"].string)
            setEndPoint(lat: json["dest_lat"].double, lng: json["dest_lng"].double, place: json["dest_place"].string)
            
        } catch let err {
            print("解析flutter传入参数出现错误\n \(err)")
        }
        
        
        mapViewData.addAnnotations([startPoint!, endPoint!])
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.mapViewData.showAnnotations(self.mapViewData.annotations, edgePadding: UIEdgeInsets(top: 80, left: 80, bottom: 80, right: 80), animated: true)
            
        })
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAPointAnnotation.self) {
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView: MAAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier)
            
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: pointReuseIndetifier)
            }
            if annotation.coordinate.latitude == startPoint?.coordinate.latitude && annotation.coordinate.longitude == startPoint?.coordinate.longitude {
                annotationView!.image = UIImage(named: "起点", in: self.targetBundle, compatibleWith: nil)
                //设置中心点偏移，使得标注底部中间点成为经纬度对应点
                annotationView!.centerOffset = CGPoint(x: 0, y: -annotationView!.image.size.height / 2);
                
            } else if annotation.coordinate.latitude == endPoint?.coordinate.latitude && annotation.coordinate.longitude == endPoint?.coordinate.longitude {
                //                annotationView!
                annotationView!.image = UIImage(named: "终点", in: self.targetBundle, compatibleWith: nil)
                //设置中心点偏移，使得标注底部中间点成为经纬度对应点
                annotationView!.centerOffset = CGPoint(x: 0, y: -annotationView!.image.size.height / 2);
                
                
            }
            //            annotationView!.image = UIImage(named: "起点", in: targetBundle, compatibleWith: nil)
            
            
            return annotationView!
        }
        
        return nil
    }
    
    
    func view() -> UIView {
        return mapViewData
    }
    
    func setStartPoint(lat: Double?, lng: Double?, place: String?) {
        let startPointAnnotation = MAPointAnnotation()
        
        startPointAnnotation.coordinate = AMapCoordinateConvert(CLLocationCoordinate2DMake(CLLocationDegrees(lat ?? 0.0), CLLocationDegrees(lng ?? 0.0)), AMapCoordinateType.baidu)
        startPointAnnotation.title = place
        startPointAnnotation.subtitle = "阜通东大街6号"
        startPoint = startPointAnnotation
    }
    
    func setEndPoint(lat: Double?, lng: Double? , place: String?) {
        let endPointAnnotation = MAPointAnnotation()
        endPointAnnotation.coordinate = AMapCoordinateConvert(CLLocationCoordinate2DMake(CLLocationDegrees(lat ?? 0.0), CLLocationDegrees(lng ?? 0.0)), AMapCoordinateType.baidu)
        endPointAnnotation.title = place
        endPointAnnotation.subtitle = "阜通东大街6号"
        endPoint = endPointAnnotation
        
    }
    
    func initMethodChannel(){
        let channel = FlutterMethodChannel.init(name: "testView", binaryMessenger: messenger);
        //Flutter与原生代码通信用的消息通道
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if(call.method == "startLoaction"){
                //do something
            }else if(call.method == "stopLoaction"){
                
            }
        });
    }
    
    deinit {
        
    }
}

//public class GaodeMapView: NSObject, {
//    
//}
