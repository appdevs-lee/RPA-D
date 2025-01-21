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
    // 운행 일보 가져오기
    private(set) var loadDrivingHistoryRequest: DataRequest?
    // 운행 일보 Patch
    private(set) var updateDrivingHistoryRequest: DataRequest?
    // 정류장 도착 Post
    private(set) var sendStationCheckDataRequest: DataRequest?
    // 아침 점호 전송
    private(set) var sendMorningRollCallDataRequest: DataRequest?   
    // 아침 점호 정보
    private(set) var loadMorningRollCallDataRequest: DataRequest?
    // 저녁 점호 전송
    private(set) var sendEveningRollCallDataRequest: DataRequest?
    // 저녁 점호 정보
    private(set) var loadEveningRollCallDataRequest: DataRequest?
    // 일일 점검 전송
    private(set) var sendVehicleCheckDataRequest: DataRequest?
    // 일일 점검 조회
    private(set) var loadVehicleCheckDataRequest: DataRequest?
    
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
    
    func sendDispatchConnectCheckDataRequest(id: Int, workType: String, check: String, refusal: String = "", imageData: UIImage? = nil, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/connect/check"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        if check == "0" {
            // 거부
            self.sendDispatchConnectCheckDataRequest = AF.upload(multipartFormData: { multipartForData in
                if let imageData = imageData {
                    multipartForData.append(imageData.jpegData(compressionQuality: 0.1)!, withName: "image", fileName: "files", mimeType: "image/jpeg")
                }
                multipartForData.append(check.data(using: .utf8)!, withName: "check")
                multipartForData.append(refusal.data(using: .utf8)!, withName: "refusal")
                multipartForData.append((workType != "일반" ? "\(id)" : "").data(using: .utf8)!, withName: "regularly_id")
                multipartForData.append((workType != "일반" ? "" : "\(id)").data(using: .utf8)!, withName: "order_id")
            }, to: url, headers: headers).uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            })
        } else {
            // 수락
            let parameters: Parameters = [
                "check": check, // 0 = 거부, 1 = 수락
                "refusal": refusal,
                "regularly_id": workType != "일반" ? "\(id)" : "",
                "order_id": workType != "일반" ? "" : "\(id)",
            ]
            
            self.sendDispatchConnectCheckDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            
        }
        
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
    
    func loadDrivingHistoryRequest(id: Int, workType: String, success: ((DrivingHistoryItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/driving-history"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        var parameters: Parameters = [
            "id": id,
            "work_type": workType,
        ]
        
        self.loadDrivingHistoryRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadDrivingHistoryRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDrivingHistoryRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDrivingHistoryRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DrivingHistory.self, from: data) {
                    print("loadDrivingHistoryRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadDrivingHistoryRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadDrivingHistoryRequest error: \(error.localizedDescription)")
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
        
        var parameters: Parameters = [
            "id": "\(id)",
            "work_type": workType,
            "passenger_num": "\(passengerNum)",
        ]
        
        if departureKM != "" && arrivalKM == "" {
            parameters.updateValue(departureKM, forKey: "departure_km")
            
        } else if departureKM == "" && arrivalKM != "" {
            parameters.updateValue(arrivalKM, forKey: "arrival_km")
            
        }
        
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
    
    func sendStationCheckDataRequest(dispatchId: Int, stationId: Int, arriveTime: String, isLastStation: Bool, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/station/check"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "regularly_connect_id": dispatchId,
            "station_id": stationId,
            "arrival_time": arriveTime,
            "is_last_station": isLastStation ? "true" : "false"
        ]
        
        self.sendStationCheckDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendStationCheckDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendStationCheckDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendStationCheckDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendStationCheckDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendStationCheckDataRequest error: \(error.localizedDescription)")
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
    
    func loadMorningRollCallDataRequest(success: ((MorningRollCallItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/checklist/morning/\(SupportingMethods.shared.convertDate(intoString: Date()))"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadMorningRollCallDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadMorningRollCallDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadMorningRollCallDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadMorningRollCallDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(MorningRollCall.self, from: data) {
                    print("loadMorningRollCallDataRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadMorningRollCallDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadMorningRollCallDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendEveningRollCallDataRequest(dashboard: String, fuel: String, urea: String, gauge: String, specialNotes: String, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let checkHour = String(SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd HH:mm").split(separator: " ")[1].split(separator: ":")[0])
        var date = ""
        if Int(checkHour)! < 04 {
            date = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: -86400))
            
        } else {
            date = SupportingMethods.shared.convertDate(intoString: Date())
            
        }
        
        let url = ServerSetting.server.URL + "/dispatch/checklist/evening/\(date)"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "battery_condition": "양호",
            "drive_distance": dashboard,
            "fuel_quantity": fuel,
            "urea_solution_quantity": urea,
            "suit_gauge": gauge,
            "special_notes": specialNotes,
        ]
        
        self.sendEveningRollCallDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendEveningRollCallDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("sendEveningRollCallDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendEveningRollCallDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendEveningRollCallDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendEveningRollCallDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }

    func sendVehicleCheckDataRequest(busId: Int, inspectionList: [Inspection], success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/vehicle/checklist/daily/\(SupportingMethods.shared.convertDate(intoString: Date()))"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
//        let parameters: Parameters = [
//            "bus_id": "\(busId)",
//            "oil_engine_condition": inspectionList[0].status! ? "양호" : "이상",
//            "oil_power_clutch_condition": inspectionList[1].status! ? "양호" : "이상",
//            "coolant_washer_condition": inspectionList[2].status! ? "양호" : "이상",
//            "external_body_condition": inspectionList[3].status! ? "양호" : "이상",
//            "lighting_device_condition": inspectionList[4].status! ? "양호" : "이상",
//            "blackbox_condition": inspectionList[5].status! ? "양호" : "이상",
//            "tire_condition": inspectionList[6].status! ? "양호" : "이상",
//            "interior_condition": inspectionList[7].status! ? "양호" : "이상",
//            "safety_belt_slide_condition": inspectionList[8].status! ? "양호" : "이상",
//            "uniform_worn_condition": inspectionList[9].status! ? "양호" : "이상",
//        ]
        
        let parameters: Parameters = [
            "bus_id": "\(busId)",
            "bus_condition_inside": inspectionList[0].status! ? "양호" : "이상",
            "bus_condition_outside": inspectionList[1].status! ? "양호" : "이상",
            "oil_power_clutch_condition": inspectionList[2].status! ? "양호" : "이상",
            "coolant_washer_condition": inspectionList[3].status! ? "양호" : "이상",
            "urea_solution_condition": inspectionList[4].status! ? "양호" : "이상",
            "fan_belt_condition": inspectionList[5].status! ? "양호" : "이상",
            "main_light": inspectionList[6].status! ? "양호" : "이상",
            "turn_signal_light": inspectionList[7].status! ? "양호" : "이상",
            "back_light_brake": inspectionList[8].status! ? "양호" : "이상",
            "get_on_door": inspectionList[9].status! ? "양호" : "이상",
            "get_off_door": inspectionList[9].status! ? "양호" : "이상",
            "overall_height": inspectionList[9].status! ? "양호" : "이상",
            "front_tire": inspectionList[9].status! ? "양호" : "이상",
            "back_tire": inspectionList[9].status! ? "양호" : "이상",
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
    
    func sendVehicleCheckDataRequest(busId: Int, inspectionList: [VehicleInspection], success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/vehicle/checklist/daily/\(SupportingMethods.shared.convertDate(intoString: Date()))"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "bus_id": busId,
            "bus_condition_inside": inspectionList[0].contents[0].status! ? "양호" : "이상", // 내부
            "bus_condition_outside": inspectionList[0].contents[1].status! ? "양호" : "이상", // 외부
            "oil_power_clutch_condition": inspectionList[1].contents[0].status! ? "양호" : "이상", // 엔진오일 점검
            "coolant_washer_condition": inspectionList[2].contents[0].status! ? "양호" : "이상", // 냉각수 점검
            "urea_solution_condition": inspectionList[3].contents[0].status! ? "양호" : "이상", // 요소수 점검
            "fan_belt_condition": inspectionList[4].contents[0].status! ? "양호" : "이상", // 팬 벨트
            "main_light": inspectionList[5].contents[0].status! ? "양호" : "이상", // 라이트(좌, 우)
            "turn_signal_light": inspectionList[5].contents[1].status! ? "양호" : "이상", // 방향지시등 (좌, 우)
            "back_light_brake": inspectionList[5].contents[2].status! ? "양호" : "이상", // 후미등 및 브레이크
            "get_on_door": inspectionList[6].contents[0].status! ? "양호" : "이상", // 전문 (승차문)
            "get_off_door": inspectionList[6].contents[1].status! ? "양호" : "이상", // 중문 (하차문)
            "overall_height": inspectionList[6].contents[2].status! ? "양호" : "이상", // 차고
            "front_tire": inspectionList[7].contents[0].status! ? "양호" : "이상", // 앞바퀴 (상 중 하)
            "back_tire": inspectionList[7].contents[1].status! ? "양호" : "이상", // 뒷바퀴 (상 중 하)
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
    
    func loadVehicleCheckDataRequest(success: ((_ submitCheck: Bool) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/vehicle/checklist/daily/2025-01-19"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadVehicleCheckDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadVehicleCheckDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadVehicleCheckDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadVehicleCheckDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DailyInspection.self, from: data) {
                    print("loadVehicleCheckDataRequest succeeded")
                    success?(decodedData.data.submitCheck)
                    
                } else {
                    print("loadVehicleCheckDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadVehicleCheckDataRequest error: \(error.localizedDescription)")
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
    let references: String
    
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
        case references
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

// MARK: 아침 점호
struct MorningRollCall: Codable {
    let data: MorningRollCallItem
    
}

struct MorningRollCallItem: Codable {
    let submitCheck: Bool
    
    enum CodingKeys: String, CodingKey {
        case submitCheck = "submit_check"
    }
}

// MARK: 운행 일보
struct DrivingHistory: Codable {
    let data: DrivingHistoryItem
}

struct DrivingHistoryItem: Codable {
    let departureKM: String
    let arrivalKM: String
    let passengerNum: String
    
    enum CodingKeys: String, CodingKey {
        case departureKM = "departure_km"
        case arrivalKM = "arrival_km"
        case passengerNum = "passenger_num"
    }
}

// MARK: 일일 점검 Model
struct DailyInspection: Codable {
    let data: DailyInspectionItem
}

struct DailyInspectionItem: Codable {
    let submitCheck: Bool
    
    enum CodingKeys: String, CodingKey {
        case submitCheck = "submit_check"
    }
}
