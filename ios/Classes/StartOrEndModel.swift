// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let startOrEndParams = try StartOrEndParams(json)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - StartOrEndParams
public struct StartOrEndParams: Codable, Hashable {
    public var orderFeeDetails: [JSONAny]?
    public var reason: JSONNull?
    public var statusDate: String?
    public var factStartAddress: JSONNull?
    public var factStartLng: JSONNull?
    public var destPlace: String?
    public var cancelTypeCode: JSONNull?
    public var areaid: Int?
    public var isOther: Int?
    public var startOrEndParamsOperator: JSONNull?
    public var destAddress: String?
    public var destLat: Double?
    public var completeTime: JSONNull?
    public var price: JSONNull?
    public var totalFee: JSONNull?
    public var staffid: String?
    public var id: String?
    public var text: String?
    public var factStartLat: JSONNull?
    public var createDate: String?
    public var orderType: String?
    public var carid: String?
    public var destLng: Double?
    public var mileage: JSONNull?
    public var useTime: String?
    public var carCategoryName: String?
    public var linkphone: String?
    public var linkman: String?
    public var startTime: JSONNull?
    public var driver: Driver?
    public var userid: String?
    public var couponFee: JSONNull?
    public var status: String?
    public var carCategoryid: Int?
    public var factStartPlace: JSONNull?
    public var factDestLng: JSONNull?
    public var remark: JSONNull?
    public var dealTime: String?
    public var factDestLat: JSONNull?
    public var startLng: Double?
    public var car: Car?
    public var startLat: Double?
    public var xNo: String?
    public var flightNumber: String?
    public var endTime: JSONNull?
    public var startPlace: String?
    public var carSpecialPrices: [CarSpecialPrice]?
    public var startAddress: String?
    public var factDestAddress: JSONNull?
    public var factDestPlace: JSONNull?
    public var user: User?
    
    enum CodingKeys: String, CodingKey {
        case orderFeeDetails = "order_fee_details"
        case reason = "reason"
        case statusDate = "status_date"
        case factStartAddress = "fact_start_address"
        case factStartLng = "fact_start_lng"
        case destPlace = "dest_place"
        case cancelTypeCode = "cancel_type_code"
        case areaid = "area_id"
        case isOther = "is_other"
        case startOrEndParamsOperator = "operator"
        case destAddress = "dest_address"
        case destLat = "dest_lat"
        case completeTime = "complete_time"
        case price = "price"
        case totalFee = "total_fee"
        case staffid = "staff_id"
        case id = "id"
        case text = "text"
        case factStartLat = "fact_start_lat"
        case createDate = "create_date"
        case orderType = "order_type"
        case carid = "car_id"
        case destLng = "dest_lng"
        case mileage = "mileage"
        case useTime = "use_time"
        case carCategoryName = "car_category_name"
        case linkphone = "linkphone"
        case linkman = "linkman"
        case startTime = "start_time"
        case driver = "driver"
        case userid = "user_id"
        case couponFee = "coupon_fee"
        case status = "status"
        case carCategoryid = "car_category_id"
        case factStartPlace = "fact_start_place"
        case factDestLng = "fact_dest_lng"
        case remark = "remark"
        case dealTime = "deal_time"
        case factDestLat = "fact_dest_lat"
        case startLng = "start_lng"
        case car = "car"
        case startLat = "start_lat"
        case xNo = "x_no"
        case flightNumber = "flight_number"
        case endTime = "end_time"
        case startPlace = "start_place"
        case carSpecialPrices = "car_special_prices"
        case startAddress = "start_address"
        case factDestAddress = "fact_dest_address"
        case factDestPlace = "fact_dest_place"
        case user = "user"
    }
    
    public init(orderFeeDetails: [JSONAny]?, reason: JSONNull?, statusDate: String?, factStartAddress: JSONNull?, factStartLng: JSONNull?, destPlace: String?, cancelTypeCode: JSONNull?, areaid: Int?, isOther: Int?, startOrEndParamsOperator: JSONNull?, destAddress: String?, destLat: Double?, completeTime: JSONNull?, price: JSONNull?, totalFee: JSONNull?, staffid: String?, id: String?, text: String?, factStartLat: JSONNull?, createDate: String?, orderType: String?, carid: String?, destLng: Double?, mileage: JSONNull?, useTime: String?, carCategoryName: String?, linkphone: String?, linkman: String?, startTime: JSONNull?, driver: Driver?, userid: String?, couponFee: JSONNull?, status: String?, carCategoryid: Int?, factStartPlace: JSONNull?, factDestLng: JSONNull?, remark: JSONNull?, dealTime: String?, factDestLat: JSONNull?, startLng: Double?, car: Car?, startLat: Double?, xNo: String?, flightNumber: String?, endTime: JSONNull?, startPlace: String?, carSpecialPrices: [CarSpecialPrice]?, startAddress: String?, factDestAddress: JSONNull?, factDestPlace: JSONNull?, user: User?) {
        self.orderFeeDetails = orderFeeDetails
        self.reason = reason
        self.statusDate = statusDate
        self.factStartAddress = factStartAddress
        self.factStartLng = factStartLng
        self.destPlace = destPlace
        self.cancelTypeCode = cancelTypeCode
        self.areaid = areaid
        self.isOther = isOther
        self.startOrEndParamsOperator = startOrEndParamsOperator
        self.destAddress = destAddress
        self.destLat = destLat
        self.completeTime = completeTime
        self.price = price
        self.totalFee = totalFee
        self.staffid = staffid
        self.id = id
        self.text = text
        self.factStartLat = factStartLat
        self.createDate = createDate
        self.orderType = orderType
        self.carid = carid
        self.destLng = destLng
        self.mileage = mileage
        self.useTime = useTime
        self.carCategoryName = carCategoryName
        self.linkphone = linkphone
        self.linkman = linkman
        self.startTime = startTime
        self.driver = driver
        self.userid = userid
        self.couponFee = couponFee
        self.status = status
        self.carCategoryid = carCategoryid
        self.factStartPlace = factStartPlace
        self.factDestLng = factDestLng
        self.remark = remark
        self.dealTime = dealTime
        self.factDestLat = factDestLat
        self.startLng = startLng
        self.car = car
        self.startLat = startLat
        self.xNo = xNo
        self.flightNumber = flightNumber
        self.endTime = endTime
        self.startPlace = startPlace
        self.carSpecialPrices = carSpecialPrices
        self.startAddress = startAddress
        self.factDestAddress = factDestAddress
        self.factDestPlace = factDestPlace
        self.user = user
    }
}

// MARK: StartOrEndParams convenience initializers and mutators

public extension StartOrEndParams {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(StartOrEndParams.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        orderFeeDetails: [JSONAny]?? = nil,
        reason: JSONNull?? = nil,
        statusDate: String?? = nil,
        factStartAddress: JSONNull?? = nil,
        factStartLng: JSONNull?? = nil,
        destPlace: String?? = nil,
        cancelTypeCode: JSONNull?? = nil,
        areaid: Int?? = nil,
        isOther: Int?? = nil,
        startOrEndParamsOperator: JSONNull?? = nil,
        destAddress: String?? = nil,
        destLat: Double?? = nil,
        completeTime: JSONNull?? = nil,
        price: JSONNull?? = nil,
        totalFee: JSONNull?? = nil,
        staffid: String?? = nil,
        id: String?? = nil,
        text: String?? = nil,
        factStartLat: JSONNull?? = nil,
        createDate: String?? = nil,
        orderType: String?? = nil,
        carid: String?? = nil,
        destLng: Double?? = nil,
        mileage: JSONNull?? = nil,
        useTime: String?? = nil,
        carCategoryName: String?? = nil,
        linkphone: String?? = nil,
        linkman: String?? = nil,
        startTime: JSONNull?? = nil,
        driver: Driver?? = nil,
        userid: String?? = nil,
        couponFee: JSONNull?? = nil,
        status: String?? = nil,
        carCategoryid: Int?? = nil,
        factStartPlace: JSONNull?? = nil,
        factDestLng: JSONNull?? = nil,
        remark: JSONNull?? = nil,
        dealTime: String?? = nil,
        factDestLat: JSONNull?? = nil,
        startLng: Double?? = nil,
        car: Car?? = nil,
        startLat: Double?? = nil,
        xNo: String?? = nil,
        flightNumber: String?? = nil,
        endTime: JSONNull?? = nil,
        startPlace: String?? = nil,
        carSpecialPrices: [CarSpecialPrice]?? = nil,
        startAddress: String?? = nil,
        factDestAddress: JSONNull?? = nil,
        factDestPlace: JSONNull?? = nil,
        user: User?? = nil
    ) -> StartOrEndParams {
        return StartOrEndParams(
            orderFeeDetails: orderFeeDetails ?? self.orderFeeDetails,
            reason: reason ?? self.reason,
            statusDate: statusDate ?? self.statusDate,
            factStartAddress: factStartAddress ?? self.factStartAddress,
            factStartLng: factStartLng ?? self.factStartLng,
            destPlace: destPlace ?? self.destPlace,
            cancelTypeCode: cancelTypeCode ?? self.cancelTypeCode,
            areaid: areaid ?? self.areaid,
            isOther: isOther ?? self.isOther,
            startOrEndParamsOperator: startOrEndParamsOperator ?? self.startOrEndParamsOperator,
            destAddress: destAddress ?? self.destAddress,
            destLat: destLat ?? self.destLat,
            completeTime: completeTime ?? self.completeTime,
            price: price ?? self.price,
            totalFee: totalFee ?? self.totalFee,
            staffid: staffid ?? self.staffid,
            id: id ?? self.id,
            text: text ?? self.text,
            factStartLat: factStartLat ?? self.factStartLat,
            createDate: createDate ?? self.createDate,
            orderType: orderType ?? self.orderType,
            carid: carid ?? self.carid,
            destLng: destLng ?? self.destLng,
            mileage: mileage ?? self.mileage,
            useTime: useTime ?? self.useTime,
            carCategoryName: carCategoryName ?? self.carCategoryName,
            linkphone: linkphone ?? self.linkphone,
            linkman: linkman ?? self.linkman,
            startTime: startTime ?? self.startTime,
            driver: driver ?? self.driver,
            userid: userid ?? self.userid,
            couponFee: couponFee ?? self.couponFee,
            status: status ?? self.status,
            carCategoryid: carCategoryid ?? self.carCategoryid,
            factStartPlace: factStartPlace ?? self.factStartPlace,
            factDestLng: factDestLng ?? self.factDestLng,
            remark: remark ?? self.remark,
            dealTime: dealTime ?? self.dealTime,
            factDestLat: factDestLat ?? self.factDestLat,
            startLng: startLng ?? self.startLng,
            car: car ?? self.car,
            startLat: startLat ?? self.startLat,
            xNo: xNo ?? self.xNo,
            flightNumber: flightNumber ?? self.flightNumber,
            endTime: endTime ?? self.endTime,
            startPlace: startPlace ?? self.startPlace,
            carSpecialPrices: carSpecialPrices ?? self.carSpecialPrices,
            startAddress: startAddress ?? self.startAddress,
            factDestAddress: factDestAddress ?? self.factDestAddress,
            factDestPlace: factDestPlace ?? self.factDestPlace,
            user: user ?? self.user
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Car
public struct Car: Codable, Hashable {
    public var statusDate: String?
    public var identificationCode: JSONNull?
    public var shift: String?
    public var insurNum: JSONNull?
    public var isCharter: Int?
    public var areaid: Int?
    public var insurType: JSONNull?
    public var isSpecial: Int?
    public var insurcom: JSONNull?
    public var insurCount: JSONNull?
    public var staffid: String?
    public var carNum: String?
    public var model: String?
    public var id: String?
    public var text: String?
    public var createDate: String?
    public var fuelType: JSONNull?
    public var brand: JSONNull?
    public var gpsBrand: JSONNull?
    public var gpsModel: JSONNull?
    public var mileage: Int?
    public var ownerName: JSONNull?
    public var commercialType: JSONNull?
    public var checkState: JSONNull?
    public var factCompanyid: JSONNull?
    public var carStartDate: String?
    public var volume: String?
    public var seat: Int?
    public var insurExp: JSONNull?
    public var isRent: Int?
    public var status: Int?
    public var carCategoryid: Int?
    public var gpsImei: JSONNull?
    public var color: String?
    public var certificate: JSONNull?
    public var fareType: JSONNull?
    public var transDateStop: JSONNull?
    public var fixState: JSONNull?
    public var engineNumber: JSONNull?
    public var feePrintid: JSONNull?
    public var transArea: JSONNull?
    public var plateColor: JSONNull?
    public var companyid: String?
    public var insureff: JSONNull?
    public var vehicleType: JSONNull?
    public var registerDate: JSONNull?
    public var avatar: JSONNull?
    public var certifyDateA: JSONNull?
    public var transAgency: JSONNull?
    public var transDateStart: JSONNull?
    public var nextFixDate: JSONNull?
    public var certifyDateB: JSONNull?
    public var gpsInstallDate: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case statusDate = "status_date"
        case identificationCode = "identification_code"
        case shift = "shift"
        case insurNum = "insur_num"
        case isCharter = "is_charter"
        case areaid = "area_id"
        case insurType = "insur_type"
        case isSpecial = "is_special"
        case insurcom = "insur_com"
        case insurCount = "insur_count"
        case staffid = "staff_id"
        case carNum = "car_num"
        case model = "model"
        case id = "id"
        case text = "text"
        case createDate = "create_date"
        case fuelType = "fuel_type"
        case brand = "brand"
        case gpsBrand = "gps_brand"
        case gpsModel = "gps_model"
        case mileage = "mileage"
        case ownerName = "owner_name"
        case commercialType = "commercial_type"
        case checkState = "check_state"
        case factCompanyid = "fact_company_id"
        case carStartDate = "car_start_date"
        case volume = "volume"
        case seat = "seat"
        case insurExp = "insur_exp"
        case isRent = "is_rent"
        case status = "status"
        case carCategoryid = "car_category_id"
        case gpsImei = "gps_imei"
        case color = "color"
        case certificate = "certificate"
        case fareType = "fare_type"
        case transDateStop = "trans_date_stop"
        case fixState = "fix_state"
        case engineNumber = "engine_number"
        case feePrintid = "fee_print_id"
        case transArea = "trans_area"
        case plateColor = "plate_color"
        case companyid = "company_id"
        case insureff = "insur_eff"
        case vehicleType = "vehicle_type"
        case registerDate = "register_date"
        case avatar = "avatar"
        case certifyDateA = "certify_date_a"
        case transAgency = "trans_agency"
        case transDateStart = "trans_date_start"
        case nextFixDate = "next_fix_date"
        case certifyDateB = "certify_date_b"
        case gpsInstallDate = "gps_install_date"
    }
    
    public init(statusDate: String?, identificationCode: JSONNull?, shift: String?, insurNum: JSONNull?, isCharter: Int?, areaid: Int?, insurType: JSONNull?, isSpecial: Int?, insurcom: JSONNull?, insurCount: JSONNull?, staffid: String?, carNum: String?, model: String?, id: String?, text: String?, createDate: String?, fuelType: JSONNull?, brand: JSONNull?, gpsBrand: JSONNull?, gpsModel: JSONNull?, mileage: Int?, ownerName: JSONNull?, commercialType: JSONNull?, checkState: JSONNull?, factCompanyid: JSONNull?, carStartDate: String?, volume: String?, seat: Int?, insurExp: JSONNull?, isRent: Int?, status: Int?, carCategoryid: Int?, gpsImei: JSONNull?, color: String?, certificate: JSONNull?, fareType: JSONNull?, transDateStop: JSONNull?, fixState: JSONNull?, engineNumber: JSONNull?, feePrintid: JSONNull?, transArea: JSONNull?, plateColor: JSONNull?, companyid: String?, insureff: JSONNull?, vehicleType: JSONNull?, registerDate: JSONNull?, avatar: JSONNull?, certifyDateA: JSONNull?, transAgency: JSONNull?, transDateStart: JSONNull?, nextFixDate: JSONNull?, certifyDateB: JSONNull?, gpsInstallDate: JSONNull?) {
        self.statusDate = statusDate
        self.identificationCode = identificationCode
        self.shift = shift
        self.insurNum = insurNum
        self.isCharter = isCharter
        self.areaid = areaid
        self.insurType = insurType
        self.isSpecial = isSpecial
        self.insurcom = insurcom
        self.insurCount = insurCount
        self.staffid = staffid
        self.carNum = carNum
        self.model = model
        self.id = id
        self.text = text
        self.createDate = createDate
        self.fuelType = fuelType
        self.brand = brand
        self.gpsBrand = gpsBrand
        self.gpsModel = gpsModel
        self.mileage = mileage
        self.ownerName = ownerName
        self.commercialType = commercialType
        self.checkState = checkState
        self.factCompanyid = factCompanyid
        self.carStartDate = carStartDate
        self.volume = volume
        self.seat = seat
        self.insurExp = insurExp
        self.isRent = isRent
        self.status = status
        self.carCategoryid = carCategoryid
        self.gpsImei = gpsImei
        self.color = color
        self.certificate = certificate
        self.fareType = fareType
        self.transDateStop = transDateStop
        self.fixState = fixState
        self.engineNumber = engineNumber
        self.feePrintid = feePrintid
        self.transArea = transArea
        self.plateColor = plateColor
        self.companyid = companyid
        self.insureff = insureff
        self.vehicleType = vehicleType
        self.registerDate = registerDate
        self.avatar = avatar
        self.certifyDateA = certifyDateA
        self.transAgency = transAgency
        self.transDateStart = transDateStart
        self.nextFixDate = nextFixDate
        self.certifyDateB = certifyDateB
        self.gpsInstallDate = gpsInstallDate
    }
}

// MARK: Car convenience initializers and mutators

public extension Car {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Car.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        statusDate: String?? = nil,
        identificationCode: JSONNull?? = nil,
        shift: String?? = nil,
        insurNum: JSONNull?? = nil,
        isCharter: Int?? = nil,
        areaid: Int?? = nil,
        insurType: JSONNull?? = nil,
        isSpecial: Int?? = nil,
        insurcom: JSONNull?? = nil,
        insurCount: JSONNull?? = nil,
        staffid: String?? = nil,
        carNum: String?? = nil,
        model: String?? = nil,
        id: String?? = nil,
        text: String?? = nil,
        createDate: String?? = nil,
        fuelType: JSONNull?? = nil,
        brand: JSONNull?? = nil,
        gpsBrand: JSONNull?? = nil,
        gpsModel: JSONNull?? = nil,
        mileage: Int?? = nil,
        ownerName: JSONNull?? = nil,
        commercialType: JSONNull?? = nil,
        checkState: JSONNull?? = nil,
        factCompanyid: JSONNull?? = nil,
        carStartDate: String?? = nil,
        volume: String?? = nil,
        seat: Int?? = nil,
        insurExp: JSONNull?? = nil,
        isRent: Int?? = nil,
        status: Int?? = nil,
        carCategoryid: Int?? = nil,
        gpsImei: JSONNull?? = nil,
        color: String?? = nil,
        certificate: JSONNull?? = nil,
        fareType: JSONNull?? = nil,
        transDateStop: JSONNull?? = nil,
        fixState: JSONNull?? = nil,
        engineNumber: JSONNull?? = nil,
        feePrintid: JSONNull?? = nil,
        transArea: JSONNull?? = nil,
        plateColor: JSONNull?? = nil,
        companyid: String?? = nil,
        insureff: JSONNull?? = nil,
        vehicleType: JSONNull?? = nil,
        registerDate: JSONNull?? = nil,
        avatar: JSONNull?? = nil,
        certifyDateA: JSONNull?? = nil,
        transAgency: JSONNull?? = nil,
        transDateStart: JSONNull?? = nil,
        nextFixDate: JSONNull?? = nil,
        certifyDateB: JSONNull?? = nil,
        gpsInstallDate: JSONNull?? = nil
    ) -> Car {
        return Car(
            statusDate: statusDate ?? self.statusDate,
            identificationCode: identificationCode ?? self.identificationCode,
            shift: shift ?? self.shift,
            insurNum: insurNum ?? self.insurNum,
            isCharter: isCharter ?? self.isCharter,
            areaid: areaid ?? self.areaid,
            insurType: insurType ?? self.insurType,
            isSpecial: isSpecial ?? self.isSpecial,
            insurcom: insurcom ?? self.insurcom,
            insurCount: insurCount ?? self.insurCount,
            staffid: staffid ?? self.staffid,
            carNum: carNum ?? self.carNum,
            model: model ?? self.model,
            id: id ?? self.id,
            text: text ?? self.text,
            createDate: createDate ?? self.createDate,
            fuelType: fuelType ?? self.fuelType,
            brand: brand ?? self.brand,
            gpsBrand: gpsBrand ?? self.gpsBrand,
            gpsModel: gpsModel ?? self.gpsModel,
            mileage: mileage ?? self.mileage,
            ownerName: ownerName ?? self.ownerName,
            commercialType: commercialType ?? self.commercialType,
            checkState: checkState ?? self.checkState,
            factCompanyid: factCompanyid ?? self.factCompanyid,
            carStartDate: carStartDate ?? self.carStartDate,
            volume: volume ?? self.volume,
            seat: seat ?? self.seat,
            insurExp: insurExp ?? self.insurExp,
            isRent: isRent ?? self.isRent,
            status: status ?? self.status,
            carCategoryid: carCategoryid ?? self.carCategoryid,
            gpsImei: gpsImei ?? self.gpsImei,
            color: color ?? self.color,
            certificate: certificate ?? self.certificate,
            fareType: fareType ?? self.fareType,
            transDateStop: transDateStop ?? self.transDateStop,
            fixState: fixState ?? self.fixState,
            engineNumber: engineNumber ?? self.engineNumber,
            feePrintid: feePrintid ?? self.feePrintid,
            transArea: transArea ?? self.transArea,
            plateColor: plateColor ?? self.plateColor,
            companyid: companyid ?? self.companyid,
            insureff: insureff ?? self.insureff,
            vehicleType: vehicleType ?? self.vehicleType,
            registerDate: registerDate ?? self.registerDate,
            avatar: avatar ?? self.avatar,
            certifyDateA: certifyDateA ?? self.certifyDateA,
            transAgency: transAgency ?? self.transAgency,
            transDateStart: transDateStart ?? self.transDateStart,
            nextFixDate: nextFixDate ?? self.nextFixDate,
            certifyDateB: certifyDateB ?? self.certifyDateB,
            gpsInstallDate: gpsInstallDate ?? self.gpsInstallDate
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CarSpecialPrice
public struct CarSpecialPrice: Codable, Hashable {
    public var carCategoryid: Int?
    public var longPrice: Int?
    public var statusDate: String?
    public var longMile: Int?
    public var stopDate: String?
    public var fareTypeNote: JSONNull?
    public var areaid: Int?
    public var minutesPrice: Double?
    public var timeRange: String?
    public var basePrice: Int?
    public var milePrice: Double?
    public var commissionRate: Int?
    public var id: Int?
    public var baseMile: Int?
    public var createDate: String?
    public var receiveRange: Double?
    public var baseMinutes: Int?
    
    enum CodingKeys: String, CodingKey {
        case carCategoryid = "car_category_id"
        case longPrice = "long_price"
        case statusDate = "status_date"
        case longMile = "long_mile"
        case stopDate = "stop_date"
        case fareTypeNote = "fare_type_note"
        case areaid = "area_id"
        case minutesPrice = "minutes_price"
        case timeRange = "time_range"
        case basePrice = "base_price"
        case milePrice = "mile_price"
        case commissionRate = "commission_rate"
        case id = "id"
        case baseMile = "base_mile"
        case createDate = "create_date"
        case receiveRange = "receive_range"
        case baseMinutes = "base_minutes"
    }
    
    public init(carCategoryid: Int?, longPrice: Int?, statusDate: String?, longMile: Int?, stopDate: String?, fareTypeNote: JSONNull?, areaid: Int?, minutesPrice: Double?, timeRange: String?, basePrice: Int?, milePrice: Double?, commissionRate: Int?, id: Int?, baseMile: Int?, createDate: String?, receiveRange: Double?, baseMinutes: Int?) {
        self.carCategoryid = carCategoryid
        self.longPrice = longPrice
        self.statusDate = statusDate
        self.longMile = longMile
        self.stopDate = stopDate
        self.fareTypeNote = fareTypeNote
        self.areaid = areaid
        self.minutesPrice = minutesPrice
        self.timeRange = timeRange
        self.basePrice = basePrice
        self.milePrice = milePrice
        self.commissionRate = commissionRate
        self.id = id
        self.baseMile = baseMile
        self.createDate = createDate
        self.receiveRange = receiveRange
        self.baseMinutes = baseMinutes
    }
}

// MARK: CarSpecialPrice convenience initializers and mutators

public extension CarSpecialPrice {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(CarSpecialPrice.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        carCategoryid: Int?? = nil,
        longPrice: Int?? = nil,
        statusDate: String?? = nil,
        longMile: Int?? = nil,
        stopDate: String?? = nil,
        fareTypeNote: JSONNull?? = nil,
        areaid: Int?? = nil,
        minutesPrice: Double?? = nil,
        timeRange: String?? = nil,
        basePrice: Int?? = nil,
        milePrice: Double?? = nil,
        commissionRate: Int?? = nil,
        id: Int?? = nil,
        baseMile: Int?? = nil,
        createDate: String?? = nil,
        receiveRange: Double?? = nil,
        baseMinutes: Int?? = nil
    ) -> CarSpecialPrice {
        return CarSpecialPrice(
            carCategoryid: carCategoryid ?? self.carCategoryid,
            longPrice: longPrice ?? self.longPrice,
            statusDate: statusDate ?? self.statusDate,
            longMile: longMile ?? self.longMile,
            stopDate: stopDate ?? self.stopDate,
            fareTypeNote: fareTypeNote ?? self.fareTypeNote,
            areaid: areaid ?? self.areaid,
            minutesPrice: minutesPrice ?? self.minutesPrice,
            timeRange: timeRange ?? self.timeRange,
            basePrice: basePrice ?? self.basePrice,
            milePrice: milePrice ?? self.milePrice,
            commissionRate: commissionRate ?? self.commissionRate,
            id: id ?? self.id,
            baseMile: baseMile ?? self.baseMile,
            createDate: createDate ?? self.createDate,
            receiveRange: receiveRange ?? self.receiveRange,
            baseMinutes: baseMinutes ?? self.baseMinutes
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Driver
public struct Driver: Codable, Hashable {
    public var companyid: String?
    public var idCard: String?
    public var avatar: String?
    public var stars: Double?
    public var drivingLicense: String?
    public var phone: String?
    public var companyName: String?
    public var name: String?
    public var carNum: String?
    public var model: String?
    public var id: String?
    public var drivingLicenseType: String?
    public var account: Double?
    public var status: Int?
    public var carCategory: String?
    
    enum CodingKeys: String, CodingKey {
        case companyid = "company_id"
        case idCard = "id_card"
        case avatar = "avatar"
        case stars = "stars"
        case drivingLicense = "driving_license"
        case phone = "phone"
        case companyName = "company_name"
        case name = "name"
        case carNum = "car_num"
        case model = "model"
        case id = "id"
        case drivingLicenseType = "driving_license_type"
        case account = "account"
        case status = "status"
        case carCategory = "car_category"
    }
    
    public init(companyid: String?, idCard: String?, avatar: String?, stars: Double?, drivingLicense: String?, phone: String?, companyName: String?, name: String?, carNum: String?, model: String?, id: String?, drivingLicenseType: String?, account: Double?, status: Int?, carCategory: String?) {
        self.companyid = companyid
        self.idCard = idCard
        self.avatar = avatar
        self.stars = stars
        self.drivingLicense = drivingLicense
        self.phone = phone
        self.companyName = companyName
        self.name = name
        self.carNum = carNum
        self.model = model
        self.id = id
        self.drivingLicenseType = drivingLicenseType
        self.account = account
        self.status = status
        self.carCategory = carCategory
    }
}

// MARK: Driver convenience initializers and mutators

public extension Driver {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Driver.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        companyid: String?? = nil,
        idCard: String?? = nil,
        avatar: String?? = nil,
        stars: Double?? = nil,
        drivingLicense: String?? = nil,
        phone: String?? = nil,
        companyName: String?? = nil,
        name: String?? = nil,
        carNum: String?? = nil,
        model: String?? = nil,
        id: String?? = nil,
        drivingLicenseType: String?? = nil,
        account: Double?? = nil,
        status: Int?? = nil,
        carCategory: String?? = nil
    ) -> Driver {
        return Driver(
            companyid: companyid ?? self.companyid,
            idCard: idCard ?? self.idCard,
            avatar: avatar ?? self.avatar,
            stars: stars ?? self.stars,
            drivingLicense: drivingLicense ?? self.drivingLicense,
            phone: phone ?? self.phone,
            companyName: companyName ?? self.companyName,
            name: name ?? self.name,
            carNum: carNum ?? self.carNum,
            model: model ?? self.model,
            id: id ?? self.id,
            drivingLicenseType: drivingLicenseType ?? self.drivingLicenseType,
            account: account ?? self.account,
            status: status ?? self.status,
            carCategory: carCategory ?? self.carCategory
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - User
public struct User: Codable, Hashable {
    public var openidApp: String?
    public var statusDate: String?
    public var unionid: String?
    public var companyid: JSONNull?
    public var openid: String?
    public var sex: Int?
    public var avatar: String?
    public var point: Int?
    public var password: String?
    public var phone: String?
    public var id: String?
    public var wxClientid: String?
    public var createDate: String?
    public var openidMini: String?
    public var account: Int?
    public var username: String?
    public var status: Int?
    
    enum CodingKeys: String, CodingKey {
        case openidApp = "openid_app"
        case statusDate = "status_date"
        case unionid = "unionid"
        case companyid = "company_id"
        case openid = "openid"
        case sex = "sex"
        case avatar = "avatar"
        case point = "point"
        case password = "password"
        case phone = "phone"
        case id = "id"
        case wxClientid = "wx_client_id"
        case createDate = "create_date"
        case openidMini = "openid_mini"
        case account = "account"
        case username = "username"
        case status = "status"
    }
    
    public init(openidApp: String?, statusDate: String?, unionid: String?, companyid: JSONNull?, openid: String?, sex: Int?, avatar: String?, point: Int?, password: String?, phone: String?, id: String?, wxClientid: String?, createDate: String?, openidMini: String?, account: Int?, username: String?, status: Int?) {
        self.openidApp = openidApp
        self.statusDate = statusDate
        self.unionid = unionid
        self.companyid = companyid
        self.openid = openid
        self.sex = sex
        self.avatar = avatar
        self.point = point
        self.password = password
        self.phone = phone
        self.id = id
        self.wxClientid = wxClientid
        self.createDate = createDate
        self.openidMini = openidMini
        self.account = account
        self.username = username
        self.status = status
    }
}

// MARK: User convenience initializers and mutators

public extension User {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        openidApp: String?? = nil,
        statusDate: String?? = nil,
        unionid: String?? = nil,
        companyid: JSONNull?? = nil,
        openid: String?? = nil,
        sex: Int?? = nil,
        avatar: String?? = nil,
        point: Int?? = nil,
        password: String?? = nil,
        phone: String?? = nil,
        id: String?? = nil,
        wxClientid: String?? = nil,
        createDate: String?? = nil,
        openidMini: String?? = nil,
        account: Int?? = nil,
        username: String?? = nil,
        status: Int?? = nil
    ) -> User {
        return User(
            openidApp: openidApp ?? self.openidApp,
            statusDate: statusDate ?? self.statusDate,
            unionid: unionid ?? self.unionid,
            companyid: companyid ?? self.companyid,
            openid: openid ?? self.openid,
            sex: sex ?? self.sex,
            avatar: avatar ?? self.avatar,
            point: point ?? self.point,
            password: password ?? self.password,
            phone: phone ?? self.phone,
            id: id ?? self.id,
            wxClientid: wxClientid ?? self.wxClientid,
            createDate: createDate ?? self.createDate,
            openidMini: openidMini ?? self.openidMini,
            account: account ?? self.account,
            username: username ?? self.username,
            status: status ?? self.status
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Encode/decode helpers

@objcMembers public class JSONNull: NSObject, Codable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    override public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

@objcMembers public class JSONAny: NSObject, Codable {
    
    public let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
