//
//  RouteModel.swift
//  RPA-D
//
//  Created by Awesomepia on 12/11/24.
//

import Foundation
import Alamofire

final class RouteModel {
    // 노선 리스트 전부 불러오기
    private(set) var loadRouteListDataRequest: DataRequest?
    // 노선 상세 조회
    private(set) var loadRouteDetailDataRequest: DataRequest?
    // 노선 숙지
    private(set) var sendRouteKnowDataRequest: DataRequest?
    // 노선 숙지 취소
    private(set) var deleteRouteKnowDataRequest: DataRequest?
    // 노선 즐겨찾기 등록
    private(set) var sendRouteBookmarkDataRequest: DataRequest?
    // 노선 즐겨찾기 삭제
    private(set) var deleteRouteBookmarkDataRequest: DataRequest?
    
    func loadRouteListDataRequest(page: Int, search: String = "", group: String = "", know: Bool? = nil, favorite: Bool? = nil, success: ((RouteItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/regularly"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        var parameters: Parameters = [
            "page": page,
            "search": search,
            "group": group,
        ]
        
        if let know = know {
            parameters.updateValue(String(know), forKey: "know")
        }
        
        if let favorite = favorite {
            parameters.updateValue(String(favorite), forKey: "favorite")
        }
        
        self.loadRouteListDataRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadRouteListDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadRouteListDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadRouteListDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Route.self, from: data) {
                    print("loadRouteListDataRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadRouteListDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadRouteListDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadRouteDetailDataRequest(id: Int, success: ((RouteDetailItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/regularly/\(id)"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadRouteDetailDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadRouteDetailDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadRouteDetailDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadRouteDetailDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(RouteDetail.self, from: data) {
                    print("loadRouteDetailDataRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadRouteDetailDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadRouteDetailDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendRouteBookmarkDataRequest(id: Int, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/regularly/favorite"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "regularly_id": "\(id)"
        ]
        
        self.sendRouteBookmarkDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendRouteBookmarkDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendRouteBookmarkDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendRouteBookmarkDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendRouteBookmarkDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendRouteBookmarkDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }

    func deleteRouteBookmarkDataRequest(id: Int, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/regularly/favorite"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "id": "\(id)"
        ]
        
        self.deleteRouteBookmarkDataRequest = AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.deleteRouteBookmarkDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("deleteRouteBookmarkDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("deleteRouteBookmarkDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("deleteRouteBookmarkDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("deleteRouteBookmarkDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendRouteKnowDataRequest(id: Int, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/regularly/know"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "regularly_id": "\(id)"
        ]
        
        self.sendRouteKnowDataRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendRouteKnowDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendRouteKnowDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendRouteKnowDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendRouteKnowDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendRouteKnowDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }

    func deleteRouteKnowDataRequest(id: Int, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/dispatch/regularly/know"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "regularly_id": "\(id)"
        ]
        
        self.deleteRouteKnowDataRequest = AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.deleteRouteKnowDataRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("deleteRouteKnowDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("deleteRouteKnowDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("deleteRouteKnowDataRequest succeeded")
                success?()
                
            case .failure(let error):
                print("deleteRouteKnowDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}

struct Route: Codable {
    let data: RouteItem
}

struct RouteItem: Codable {
    let count: Int
    let knowCount: Int
    let next: String?
    let previous: String?
    let routeList: [RouteListItem]
    
    enum CodingKeys: String, CodingKey {
        case count
        case knowCount = "know_count"
        case next
        case previous
        case routeList = "regularly_list"
    }
}

struct RouteListItem: Codable {
    let id: Int
    let workType: String
    
    let know: String
    let favorite: String
    
    let references: String
    
    let departure: String
    let arrival: String
    let departureTime: String
    let arrivalTime: String
    
    let group: String
    let route: String
    
    let maplink: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case workType = "work_type"
        case know
        case favorite
        case references
        case departure
        case arrival
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case group
        case route
        case maplink
    }
}

class RouteDetail: Codable {
    let data: RouteDetailItem
    
}

class RouteDetailItem: Codable {
    let group: String
    let route: String
    let departure: String
    let arrival: String
    var know: String
    var favorite: String
    let references: String
    let maplink: String
    let departureTime: String
    let arrivalTime: String
    let stations: [StationInfo]
    
    enum CodingKeys: String, CodingKey {
        case group
        case route
        case departure
        case arrival
        case know
        case favorite
        case references
        case maplink
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case stations
    }
}
