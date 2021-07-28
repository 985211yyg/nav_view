//
//  DriverConstantsAndEnums.swift
//  bdmap
//
//  Created by 冰空花束 on 2020/3/1.
//

import UIKit
import AMapNaviKit
import SwiftyJSON

//let app = UIApplication.shared.delegate as! AppDelegate

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height  //状态条高度

// 上传位置key
let TRACE_KEY = "naviPath"
let NAVI_INFO_KEY = "naviInfo"

//UserDefaults
let TY_USERDEFAULTS_MOBILE = "mobile"  //保存的手机号
let TY_USERDEFAULTS_PASSWORD = "password"  //保存的密码
let TY_USERDEFAULTS_TOKEN = "token"  //保存的token
let TY_USERDEFAULTS_NAME = "name" //保存的name
let TY_USERDEFAULTS_ID = "id"  //保存的staff_id

let TY_USERDEFAULTS_TRAVELING_ID = "traveling_id"  //当前已经发车的id
let TY_USERDEFAULTS_TRAVELING_DATE = "traveling_date"  //当前已经发车的date
let TY_USERDEFAULTS_TRAVELING_JSON = "traveling_json"  //当前已经发车的详细json
let TY_USERDEFAULTS_LONGITUDE = "longitude"  //经度
let TY_USERDEFAULTS_LATITUDE = "latitude" //纬度

let TY_USERDEFAULTS_INITIAL_SAVED_DATE = "initial_saved_date"  //行程开始时的日期
//let TY_USERDEFAULTS_ACCOUNTING_MODEL_ARRAY = "accounting_model_array"  //全局计费模型
let TY_USERDEFAULTS_LATEST_SAVED_DATE = "latest_saved_date"  //上一次接收到鹰眼轨迹查询的日期

let TY_COMPETE_ORDER_SUCCESS_NOTIFICATION = "compete_order_success_notification" //抢单成功通知

let TY_ORDER_CANCEL_NOTIFICATION = "order_cancel_notification" // 订单被取消通知

let TY_FACE_VERIFICATION_SUCCEED_NOTIFICATION = "face_verification_succeed_notification" // 身份验证成功

let TY_DRIVER_OFFLINE_NOTIFICATION = "driver_offline_notification"



//font
let TY_STANDARD_FONT_14 = UIFont.systemFont(ofSize: 14)
let TY_STANDARD_FONT_16 = UIFont.systemFont(ofSize: 16)

//color
//let TY_COLOR_NAVIGATION: Int64 = 0x8CBDBB  //导航条标准色
//let TY_COLOR_NAVIGATION: Int64 = 0xF9555F;  //导航条标准色
//let TY_COLOR_NAVIGATION: Int64 = 0x5CA4D9;  //导航条标准色
let TY_COLOR_GRAY: Int64 = 0xA6A6A6  //订单号灰色
let TY_COLOR_LIGHT_GRAY: Int64 = 0xECECEF  //浅灰
let TY_COLOR_WECHAT: Int64 = 0x8BC64D  //微信颜色
let TY_COLOR_TEXT_GRAY: Int64 = 0x878787  //消息cell中字体颜色

//url
//let TY_MAIN_URL = "http://192.168.0.34:8080/caiyuntong"
//let TY_MAIN_URL = "http://120.76.29.221:8080"

#if DEBUG
//let TY_MAIN_URL = "http://120.24.55.27:8080"
//let TY_MAIN_URL = "http://guanguan.reemii.cn/guanguantest"
//    let TY_MAIN_URL = "http://101.201.44.71:8090/bjcx"

//    let TY_MAIN_URL = "https://bjx.reemii.cn/bjcx"
//let TY_MAIN_URL = "http://192.168.1.144:8080"
//let TY_MAIN_URL = "http://192.168.0.192:8080"

let TY_MAIN_URL = "https://bjx.reemii.cn/bjcx-test"
//    let TY_MAIN_URL = "http://bjx.reemii.cn/bjcx"
#else
//    let TY_MAIN_URL = "http://101.201.44.71:8090/bjcx"
//    let TY_MAIN_URL = "https://bjx.reemii.cn/bjcx"

let TY_MAIN_URL = "https://bjx.reemii.cn/bjcx-test"
//    let TY_MAIN_URL = "http://bjx.reemii.cn/bjcx"
#endif


//let TY_MAIN_URL = "http://tt.jt169.com"
//let TY_MAIN_URL = "http://192.168.1.183:8080"
let TY_LOGIN_URL = "/common/staff/token"  //登录
let TY_TRIP_LIST = "/staff/special/order/mines"  //获取行程列表
let TY_DRIVER_MESSAGE_LIST = "/staff/pushmsg/list" // 司机消息列表
let TY_DRIVER_CANCEL_ORDER = "/staff/special/order/cancel"  //司机取消订单
let TY_DRIVER_COMPETE_ORDER = "/staff/special/order/grab"  //司机端抢单

let TY_MODIFY_PASSWORD = "/staff/staff/update_pwd"  //司机端修改密码
let TY_GET_VERIFY_CODE = "/common/staff/send_forgetpwd_code"  //司机端忘记密码验证码发送
let TY_GET_ADD_CODE = "/common/addCode" //获取验证码之前随机码
let TY_FORGET_PASSWORD_RESET_PASSWORD = "/common/staff/update_pwd"  //司机端忘记密码重置密码


let TY_STAFF_INFO = "/staff/staff/info" // 司机个人信息
let TY_TRIP_START = "/staff/special/order/trip"  //专车接到用户，出发
let TY_STAFF_SWITCH = "/staff/staff/handover"  //专车司机交接班
let TY_STAFF_ONLINE_OFFLINE = "/staff/staff/online"  //专车司机上下线

let TY_UPLOAD_LINE_INFO = "/staff/special/order/tripTrack/set"

let TY_CHECK_UPDATE = "/common/app/check_version"  //检查版本更新
let TY_ORDER_DETAIL = "/staff/special/order/info"  //获取订单详情
let TY_ORDER_EDIT_ORDER_PRICE = "/staff/special/order/taxiPrice" //修改订单价格

let TY_GET_UPTOKEN = "/staff/staff/uptoken" // 获取七牛Token
let TY_STAFF_UPDATEINFO = "/staff/staff/save_avatar"  //司机端保存头像
let TY_STAFF_MATCH = "/staff/staff/match" // 验证头像

//新增的钱包功能相关接口
let TY_GET_ACCOUNT_BALANCE = "/staff/staff/balance"  //司机端查询账户余额  clear
let TY_BIND_NEW_UNION_CARD = "/staff/staff/bind_new_card"  //司机绑定新卡  clear
let TY_GET_UNION_CARD_LIST = "/staff/staff/card_info"  //获取司机已绑定的银行卡 clear
let TY_DRIVER_NAME_ID_AUTH = "/staff/staff/auth_bc"  //司机实名身份认证  clear
let TY_DRIVER_SET_DEFAULT_CARD = "/staff/staff/set_default_card" //司机设置默认银行卡 clear
let TY_DRIVER_INCOME_RECORD = "/staff/staff/transfer_in_record"  //司机收入明细，包含出发地，目的地，时间，收入 clear
let TY_DRIVER_WITHDRAW_RECORD = "/staff/staff/transfer_out_record"  //司机提现明细 clear
let TY_UNBIND_UNION_CARD = "/staff/staff/unbind_card"  //司机解绑银行卡  clear
let TY_DRIVER_WITHDRAW = "/staff/staff/draw_cash"  //司机提现 clear
let TY_WITHDRAW_RULES = "/mobile/transfer_instruction.html"  //提现规则嵌入的webview url

// 获取司机照片
let TY_GET_DIRVER_PHOTO = "/staff/staff/photo"

// -------------------------  Start --------------------------------------
//Kira marked at 2018-2-27, the urls below are about special line driver.

/*
 
 /*  Colors  */
 //登录页渐变色
 let COLOR_LOGIN_GRADIENT_TOP = UIColor.colorWithHexTest(0xF43C4D)
 let COLOR_LOGIN_GRADIENT_BOTTOM = UIColor.colorWithHexTest(0xFDA059)
 
 //导航条颜色
 let COLOR_NAVIGATION_BAR = UIColor.colorWithHexTest(0xF43C4D)
 
 //专线业务的main url
 #if DEBUG
 let MAIN_URL = "https://bjx.reemii.cn/bjcx"
 #else
 let MAIN_URL = "https://bjx.reemii.cn/bjcx"
 #endif
 
 let LOGIN_URL = "/common/staff/token?grant_type=password&phone="   //目测这个url会跟专车的url合并
 
 let MYSELF_INFO = "/staff/staff/self"  //获取个人信息   合并
 let ORDER_LIST = "/staff/busline/batch/list"  //订单列表  合并
 let ORDER_DETAIL_ZHUANXIAN = "/staff/busline/batch/info"  //获取专线订单详情页，订单type为2  合并
 let ORDER_DETAIL_GONGWUCHUXING = "/staff/charter/order/info"  //获取公务出行订单详情页，订单type为3  合并
 let VERIFY_CODE = "/common/staff/send_forgetpwd_code"  //司机端忘记密码，发送验证码  目测为合并
 let UPDATE_PASSWORD = "/common/staff/update_pwd"  //司机端更新密码  需要合并
 let ZHUANXIAN_START = "/staff/busline/batch/start"  //专线订单发车  单独的接口
 let ZHUANXIAN_ARRIVED = "/staff/busline/batch/arrived"  //专线订单到达  单独的接口，可能需要抽取
 let SCAN_ZHUANXIAN = "/staff/busline/order/check/static"  //专线扫码验票  单独的接口，需要抽取
 let SCAN_GUNDONG = "/staff/busline/order/check/roll"  //滚动发车扫码验票  单独的接口，需要抽取
 let GUNDONG_LIST = "/staff/busline/batch/roll/list"  //获取滚动发车班线列表页面  单独的接口，需要抽取
 
 /* 公务出行（包车） */
 let BAOCHE_START = "/staff/charter/order/tripStart"  //包车开始，记录起始里程  单独的接口，需要抽取
 let BAOCHE_ARRIVED = "/staff/charter/order/arrived"  //包车结束，记录结束里程  单独的接口，需要抽取
 let BAOCHE_EXTRA_FEE = "/staff/charter/order/setOrderPrices"  //包车新增费用项  单独的接口，需要抽取
 let BAOCHE_NEGOTIATE = "/staff/charter/order/feeComfirm"  //包车议价  单独的接口，需要抽取
 
 /*  Text  */
 let SERVICE_HOTLINE = "0875-2881616"
 let COMPANY_NAME = "云南保山交通运输集团公司"
 let RIGHT_DESCRIPTION = "芮米科技 版权所有\r Copyright ⓒ 2015-2017 ReeMii.\r All Rights Reserved."
 
 /*  UserDefaults  */
 let USER_DEFAULTS_SAVED_MOBILE = "Saved_Mobile"
 let USER_DEFAULTS_SAVED_PASSWORD = "Saved_Password"
 let USER_DEFAULTS_SAVED_TOKEN = "Saved_token"
 
 /*  Kira added at 12-11，新增对于公务出行的相关信息存储，包括订单号、起始里程、起始地点、起始经纬度等信息 */
 let USER_DEFAULTS_GWCX_ORDER_ID = "Gwcx_Order_Id"  //公务出行订单号
 let USER_DEFAULTS_GWCX_START_MILE = "Gwcx_Start_Mile"  //公务出行起始里程
 let USER_DEFAULTS_GWCX_START_PLACE = "Gwcx_Start_Place"  //公务出行起始地点
 let USER_DEFAULTS_GWCX_START_LATITUDE = "Gwcx_Start_Latitude"  //公务出行起始纬度
 let USER_DEFAULTS_GWCX_START_LONGITUDE = "Gwcx_Start_Longitude"  //公务出行起始经度
 
 /* StatusCode */
 let TOKEN_EXPIRE = 918
 
 /* 3rd Framework Key */
 //let Baidu_Map_AK = "DPG2nQBYOdFfyLG80q6ghZFNvO0IZKPP"
 let Baidu_Map_AK = "53aXyoHWdwvzvGSCO9OwqIGImNQrPwFv"
 
 */

//------------------ End ------------------------------


// API 调用时， Token相关状态码
let TY_TOKEN_EXPIRE = 918

//出租车类型的car_category_id
let TY_CAR_CATEGORY_ID_TAXI = 5

//取消订单原因数组
let TY_CANCEL_ORDER_REASONS = [
    "有急事不能前往", "路程太远不能前往","其他"
]

// 订单状态
enum TYOrderStatus: String {
    case Deal = "deal"
    case Normal = "normal"
    case Trip = "trip"
    case Arrived = "arrived"
    case Insufficent = "insufficient"
    case Charged = "charged"
    case Evaluted = "evaluted"
    case Cancel = "cancel"
    case Pickup = "pickup"
    case Unknown
    
    var description: String {
        switch self {
        case .Deal:
            return "已接单"
        case .Normal:
            return "已创建"
        case .Trip:
            return "行程中"
        case .Arrived:
            return "已到达"
        case .Insufficent:
            return "余额不足"
        case .Charged:
            return "已支付"
        case .Evaluted:
            return "已评价"
        case .Cancel:
            return "已取消"
        case .Pickup:
            return "已到达乘客位置"
        case .Unknown:
            return "未知"
        }
    }
}

// 订单类型
enum TYOrderType: String {
    case Now = "now"
    case Ordered = "reserve"
    case AirportLine = "airportLine"
    case Unknown
    
    var description: String {
        switch  self {
        case .Now:
            return "立刻"
        case .Ordered:
            return "预约"
        case .AirportLine:
            return "机场包车"
        case .Unknown:
            return "未知"
        }
    }
}

func backNaviPathJson(naviPath: AMapNaviRoute) -> JSON {
    let mSteps = [[String: Any]]()
//    var naviStepDict: [String: Any] = [String: Any]()
//    for naviStep in naviPath.routeSegments ?? [] {
//        var tempList = [[String: Any]]()
//        for point in naviStep.coordinates {
//            tempList.append(["latitude": point.latitude, "longitude": point.longitude])
//        }
//        naviStepDict["mLength"] = naviStep.length
//        naviStepDict["mTime"] = naviStep.time
//        naviStepDict["mCoords"] = tempList
//        mSteps.append(naviStepDict)
//    }
    var latLngList = [[String: Any]]()
    for point in naviPath.routeCoordinates {
        latLngList.append(["latitude": point.latitude, "longitude": point.longitude])
    }
    var infoDict: [String: Any] = [String: Any]()
    infoDict["allLength"] = naviPath.routeLength
    infoDict["allTime"] = naviPath.routeTime
    infoDict["stepsCount"] = naviPath.routeSegmentCount
    infoDict["mSteps"] = mSteps
    infoDict["latLngList"] = latLngList
    infoDict["startPoi"] = ["latitude": naviPath.routeStartPoint?.latitude ?? 0.0, "longitude": naviPath.routeStartPoint?.longitude ?? 0.0]
    infoDict["endPoi"] = ["latitude": naviPath.routeEndPoint?.latitude ?? 0.0, "longitude": naviPath.routeEndPoint?.longitude ?? 0.0]
    infoDict["pathid"] = naviPath.routeUID
    infoDict["center"] = ["latitude": naviPath.routeCenterPoint?.latitude ?? 0.0, "longitude": naviPath.routeCenterPoint?.longitude ?? 0.0]
    return JSON(rawValue: infoDict) ?? JSON()
}

func backNaviInfoJson(naviInfo: AMapNaviInfo, speed: Int, location: CLLocationCoordinate2D, locations: [[String: Any]]) -> JSON {
    var infoDict: [String: Any] = [String: Any]()
    infoDict["RouteRemainDis"] = naviInfo.routeRemainDistance  // 离终点剩余距离(单位:米)
    infoDict["RouteRemainTime"] = naviInfo.routeRemainTime     // 离终点预估剩余时间(单位:秒)
    infoDict["SegRemainDis"] = naviInfo.segmentRemainDistance  // 当前路段剩余距离(单位:米)
    infoDict["SegRemainTime"] = naviInfo.segmentRemainTime     // 当前路段预估剩余时间(单位:秒)
    infoDict["CurSegIndex"] = naviInfo.currentSegmentIndex     // 当前所在的segment段的index,从0开始
    infoDict["CurrentSpeed"] = speed
    infoDict["CurrentLocation"] = ["latitude": location.latitude, "longitude": location.longitude]
    infoDict["Locations"] = []
    infoDict["InfoIndex"] = Int(Date().timeIntervalSince1970)
    return JSON(rawValue: infoDict) ?? JSON()
}

