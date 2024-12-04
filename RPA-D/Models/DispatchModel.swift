//
//  DispatchModel.swift
//  RPA-D
//
//  Created by Awesomepia on 11/15/24.
//

import Foundation
import Alamofire

final class DispatchModel {
    // 일일 배차 정보 리스트
    private(set) var loadDispatchDailyListRequest: DataRequest?
    // 일일 배차 정보 상세
    private(set) var loadDispatchDailyDetailRequest: DataRequest?
    // 월별 배차 정보
    private(set) var loadDispatchMonthlyRequest: DataRequest?
    // 배차 수락 및 거부
    private(set) var sendDispatchConnectCheckDataRequest: DataRequest?
    // 운행 확인
    private(set) var sendDispatchInfoUpdateRequest: DataRequest?
    // 운행 일보 Patch
    private(set) var updateDrivingHistoryRequest: DataRequest?
    // 아침 점호 전송
    private(set) var sendMorningRollCallDataRequest: DataRequest?   
    // 일일 점검 전송
    private(set) var sendVehicleCheckDataRequest: DataRequest?
    
    func loadDispatchDailyListRequest(date: String, success: (([DispatchDailyItem]) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/daily/list/\(date)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadDispatchDailyListRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadDispatchDailyListRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchDailyListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchDailyListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DispatchDaily.self, from: data) {
                    print("loadDispatchDailyListRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadDispatchDailyListRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadDispatchDailyListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadDispatchDailyDetailRequest(id: Int, workType: String, success: ((DispatchDetailItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/daily/detail"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "id": id,
            "work_type": workType
        ]
        
        self.loadDispatchDailyDetailRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadDispatchDailyDetailRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchDailyDetailRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchDailyDetailRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DispatchDetail.self, from: data) {
                    print("loadDispatchDailyDetailRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadDispatchDailyDetailRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadDispatchDailyDetailRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadDispatchMonthlyRequest(date: String, success: (([Int]) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/monthly/\(date)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadDispatchMonthlyRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadDispatchMonthlyRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchMonthlyRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchMonthlyRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DispatchMonthly.self, from: data) {
                    print("loadDispatchMonthlyRequest succeeded")
                    success?(decodedData.data.returnDailyDispatchCount())
                    
                } else {
                    print("loadDispatchMonthlyRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadDispatchMonthlyRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
            
        }
        
    }
    
    func sendDispatchConnectCheckDataRequest(id: Int, workType: String, check: String, refusal: String = "", success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/connect/check"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "check": check, // 0 = 거부, 1 = 수락
            "refusal": refusal,
            "regularly_id": workType != "일반" ? "\(id)" : "",
            "order_id": workType != "일반" ? "" : "\(id)",
        ]
        
        self.sendDispatchConnectCheckDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendDispatchConnectCheckDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendDispatchConnectCheckDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendDispatchConnectCheckDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendDispatchConnectCheckDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendDispatchConnectCheckDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendDispatchInfoUpdateRequest(id: Int, workType: String, type: String, time: String, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/check2"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "id": "\(id)",
            "work_type": workType,
            "type": type,
            "time": time,
        ]
        
        self.sendDispatchInfoUpdateRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendDispatchInfoUpdateRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendDispatchInfoUpdateRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendDispatchInfoUpdateRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendDispatchInfoUpdateRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendDispatchInfoUpdateRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func updateDrivingHistoryRequest(id: Int, workType: String, departureKM: String = "", arrivalKM: String = "", passengerNum: Int = 0, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/driving-history"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "id": "\(id)",
            "work_type": workType,
            "departure_km": departureKM,
            "arrival_km": arrivalKM,
            "passenger_num": "\(passengerNum)",
        ]
        
        self.updateDrivingHistoryRequest = AF.request(url, method: .patch , parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.updateDrivingHistoryRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("updateDrivingHistoryRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("updateDrivingHistoryRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("updateDrivingHistoryRequest succeeded")
                success?()
                
            case .failure(let error):
                print("updateDrivingHistoryRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendMorningRollCallDataRequest(arrivalTime: String, healthStatus: Bool, cleanStatus: Bool, routeKnowStatus: Bool, alcohol: Double, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/checklist/morning/\(SupportingMethods.shared.convertDate(intoString: Date()))"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "arrival_time": String(arrivalTime.split(separator: " ")[1]),
            "health_condition": healthStatus ? "양호" : "이상",
            "cleanliness_condition": cleanStatus ? "양호" : "이상",
            "route_familiarity": routeKnowStatus ? "양호" : "이상",
            "alcohol_test": "\(alcohol)",
        ]
        
        self.sendMorningRollCallDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendMorningRollCallDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendMorningRollCallDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendMorningRollCallDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendMorningRollCallDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendMorningRollCallDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }

    func sendVehicleCheckDataRequest(busId: Int, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/vehicle/checklist/daily/\(SupportingMethods.shared.convertDate(intoString: Date()))"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "bus_id": "\(busId)",
            "oil_engine_condition": "",
            "oil_power_clutch_condition": "",
            "coolant_washer_condition": "",
            "external_body_condition": "",
            "lighting_device_condition": "",
            "blackbox_condition": "",
            "tire_condition": "",
            "interior_condition": "",
            "safety_belt_slide_condition": "",
            "uniform_worn_condition": "",
        ]
        
        self.sendVehicleCheckDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendVehicleCheckDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendVehicleCheckDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendVehicleCheckDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendVehicleCheckDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendVehicleCheckDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
}

// 일일 배차 정보 리스트 Model
struct DispatchDaily: Codable {
    let data: [DispatchDailyItem]
}

struct DispatchDailyItem: Codable {
    let id: Int
    let workType: String
    let busId: Int
    let busNum: String
    let departureDate: String
    let arrivalDate: String
    let departure: String
    let arrival: String
    let connectCheck: String
    let status: String
    let isVehicleChecked: String
    let maplink: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case workType = "work_type"
        case busId = "bus_id"
        case busNum = "bus_num"
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
        case departure
        case arrival
        case connectCheck = "connect_check"
        case status
        case isVehicleChecked = "is_vehicle_checked"
        case maplink
    }
}

// 일일 배차 정보 상세 Model
struct DispatchDetail: Codable {
    let data: DispatchDetailItem
}

struct DispatchDetailItem: Codable {
    let id: Int
    let workType: String
    let busId: Int
    let busNum: String
    let stations: [StationInfo]
    let locations: String?
    let references: String
    let maplink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case workType = "work_type"
        case busId = "bus_id"
        case busNum = "bus_num"
        case stations
        case locations
        case references
        case maplink
    }
}

struct StationInfo: Codable {
    let id: Int
    let stationName: String
    let stationType: String
    let latitude: String
    let longitude: String
    let targetTime: String
    let arrivalTime: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case stationName = "station_name"
        case stationType = "station_type"
        case latitude
        case longitude
        case targetTime = "target_time"
        case arrivalTime = "arrival_time"
    }
}

// 월별 배차 정보 모델
struct DispatchMonthly: Codable {
    let data: DispatchMonthlyItem
}

struct DispatchMonthlyItem: Codable {
    let order: [Int]
    let regularlyC: [Int]
    let regularlyT: [Int]
    
    enum CodingKeys: String, CodingKey {
        case order
        case regularlyC = "regularly_c"
        case regularlyT = "regularly_t"
    }
    
    func returnDailyDispatchCount() -> [Int] {
        var dailyDispatchCount: [Int] = Array(repeating: 0, count: self.order.count)
        
        for index in 0..<dailyDispatchCount.count {
            dailyDispatchCount[index] = self.order[index] + self.regularlyC[index] + self.regularlyT[index]
            
        }
        
        
        return dailyDispatchCount
    }
    
}
