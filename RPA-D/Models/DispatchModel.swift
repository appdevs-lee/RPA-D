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
    let locations: String
    let references: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case workType = "work_type"
        case busId = "bus_id"
        case busNum = "bus_num"
        case stations
        case locations
        case references
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
