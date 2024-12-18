//
//  MainModel.swift
//  RPA-D
//
//  Created by Awesomepia on 11/25/24.
//

import UIKit
import Alamofire

final class MainModel {
    // 하루 일과 정보
    private(set) var loadDailyRoutineDataRequest: DataRequest?
    // 퇴근
    private(set) var sendGetOffWorkDataRequest: DataRequest?
    // 관리자 메인(노선 문제 발생) 리스트
    private(set) var loadProblemListDataRequest: DataRequest?
    // 문제 발생 노선 상세
    private(set) var loadProblemRouteDetailDataRequest: DataRequest?
    
    func loadDailyRoutineDataRequest(success: ((RoutineItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let checkHour = String(SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd HH:mm").split(separator: " ")[1].split(separator: ":")[0])
        var date = ""
        if Int(checkHour)! < 04 {
            date = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: -86400))
            
        } else {
            date = SupportingMethods.shared.convertDate(intoString: Date())
            
        }
        
        let url = ServerSetting.server.URL + "/dispatch/daily/routine/\(date)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadDailyRoutineDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadDailyRoutineDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDailyRoutineDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDailyRoutineDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Routine.self, from: data) {
                    print("loadDailyRoutineDataRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadDailyRoutineDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadDailyRoutineDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendGetOffWorkDataRequest(statusType: String, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/daily/routine/get-off-work"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let checkHour = String(SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd HH:mm").split(separator: " ")[1].split(separator: ":")[0])
        var date = ""
        if Int(checkHour)! < 04 {
            date = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: -86400))
            
        } else {
            date = SupportingMethods.shared.convertDate(intoString: Date())
            
        }
        
        let parameters: Parameters = [
            "date": date,
            "status_type": statusType
        ]
        
        self.sendGetOffWorkDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendGetOffWorkDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendGetOffWorkDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendGetOffWorkDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendGetOffWorkDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendGetOffWorkDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
                
            }
            
        }
        
    }
    
    func loadProblemListDataRequest(success: (([ProblemListItem]) -> ())?, failure: ((_ message: String) -> ())?) {
        let checkHour = String(SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd HH:mm").split(separator: " ")[1].split(separator: ":")[0])
        var date = ""
        if Int(checkHour)! < 04 {
            date = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: -86400))
            
        } else {
            date = SupportingMethods.shared.convertDate(intoString: Date())
            
        }
        
        // FIXME: 날짜 다시 조정 필수!!!
        let url = ServerSetting.server.URL + "/dispatch/problem/list/\(date)"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadProblemListDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadProblemListDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadProblemListDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadProblemListDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Problem.self, from: data) {
                    print("loadProblemListDataRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadProblemListDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadProblemListDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadProblemRouteDetailDataRequest(id: Int, workType: String, success: ((ProblemDetailItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/problem/detail"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "id": id,
            "work_type": workType,
        ]
        
        self.loadProblemRouteDetailDataRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadProblemRouteDetailDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadProblemRouteDetailDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadProblemRouteDetailDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(ProblemDetail.self, from: data) {
                    print("loadProblemRouteDetailDataRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadProblemRouteDetailDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadProblemRouteDetailDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
}

struct Routine: Codable {
    let data: RoutineItem
}

struct RoutineItem: Codable {
    let status: String
    let info: RoutineStatusInfo
    let goToWork: RoutineGoToWork
    let tasks: [RoutineDispatch?]
    let getOffWork: RoutineGetOffWork
    
    enum CodingKeys: String, CodingKey {
        case status
        case info
        case goToWork = "go_to_work"
        case tasks
        case getOffWork = "get_off_work"
    }
}

struct RoutineStatusInfo: Codable {
    let dispatchId: Int?
    let workType: String?
    let departureTime: String
    let busId: Int?
    let busNum: String
    let departure: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case dispatchId = "dispatch_id"
        case workType = "work_type"
        case departureTime = "departure_time"
        case busId = "bus_id"
        case busNum = "bus_num"
        case departure
        case status
    }
}

struct RoutineGoToWork: Codable {
    let wakeTime: String
    let attendanceTime: String
    
    enum CodingKeys: String, CodingKey {
        case wakeTime = "wake_time"
        case attendanceTime = "attendance_time"
    }
}

struct RoutineDispatch: Codable {
    let dispatchId: Int?
    let workType: String
    let busId: Int?
    let busNum: String
    let departure: String
    let departureDate: String
    let arrival: String
    let arrivalDate: String
    let status: String
    let statusInfo: [StatusInfo]
    
    enum CodingKeys: String, CodingKey {
        case dispatchId = "dispatch_id"
        case workType = "work_type"
        case busId = "bus_id"
        case busNum = "bus_num"
        case departure
        case departureDate = "departure_date"
        case arrival
        case arrivalDate = "arrival_date"
        case status
        case statusInfo = "status_info"
    }
}

struct RoutineGetOffWork: Codable {
    let rollCallTime: String
    let tomorrowDispatchCheckTime: String
    let getOffTime: String
    
    enum CodingKeys: String, CodingKey {
        case rollCallTime = "roll_call_time"
        case tomorrowDispatchCheckTime = "tomorrow_dispatch_check_time"
        case getOffTime = "get_off_time"
    }
}

struct StatusInfo: Codable {
    let statusName: String
    let completionTime: String
    
    enum CodingKeys: String, CodingKey {
        case statusName = "status_name"
        case completionTime = "completion_time"
    }
}

struct Problem: Codable {
    let data: [ProblemListItem]
}

struct ProblemListItem: Codable {
    let id: Int
    let workType: String
    let busNum: String
    let departureDate: String
    let arrivalDate: String
    let departure: String
    let arrival: String
    let route: String
    let group: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case workType = "work_type"
        case busNum = "bus_num"
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
        case departure
        case arrival
        case route
        case group
    }
}

struct ProblemDetail: Codable {
    let data: ProblemDetailItem
}

struct ProblemDetailItem: Codable {
    let driverName: String
    let driverPhone: String
    let busNum: String
    let group: String
    let route: String
    let departure: String
    let arrival: String
    let departureDate: String
    let arrivalDate: String
    let problem: String
    let stations: [StationInfo]
    
    enum CodingKeys: String, CodingKey {
        case driverName = "driver_name"
        case driverPhone = "driver_phone"
        case busNum = "bus_num"
        case group
        case route
        case departure
        case arrival
        case departureDate = "departure_date"
        case arrivalDate = "arrival_date"
        case problem
        case stations
    }
}
