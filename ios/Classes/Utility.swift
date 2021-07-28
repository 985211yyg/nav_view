//
//  Utility.swift
//  AFNetworking
//
//  Created by 冰空花束 on 2020/3/9.
//

import Foundation
import AFNetworking
import SwiftyJSON

// /staff/special/order/tripTrack/set

func uploadLineInfo(param: [String: Any], success: @escaping (Any) -> Void, failure: @escaping (Any) -> Void) {
    //根据car_id执行后续网络逻辑
    let sessionManager = AFHTTPSessionManager()
    let requestSerializer = AFJSONRequestSerializer()
    //    requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let responseSerializer = AFHTTPResponseSerializer()
    sessionManager.requestSerializer = requestSerializer
    sessionManager.responseSerializer = responseSerializer
    sessionManager.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json","text/javascript","text/html") as? Set<String>
    
    let requestStr = (UserDefaults.standard.string(forKey: "domain") ?? "") + TY_UPLOAD_LINE_INFO + "?token=\(UserDefaults.standard.string(forKey: "brToken") ?? "")"  //专车司机交接班
    
    sessionManager.post(requestStr, parameters: param, headers: nil, progress: nil, success: { (_, response) in
        if let json = try? JSON(data: (response as! NSData) as Data) {
            if json["code"].int == 0 {
                success(json["data"])
            } else if json["code"].int == 918 || json["code"].int == 919 {
                failure(json["msg"])
            } else {
                failure(json["msg"])
            }
        }
    }, failure: { (_, error) in
        failure(error)
        return
    })
}


func formatTime(date: Date, fmt: String? = "HH:mm") -> String {
    let dateFormat = DateFormatter.init()
    dateFormat.dateFormat = fmt
    return dateFormat.string(from: date)
    
}
