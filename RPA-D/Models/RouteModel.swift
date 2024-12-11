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
    // 노선 즐겨찾기
    private(set) var sendRouteBookmarkDataRequest: DataRequest?
    
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
            case .success(let data):
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
}

struct Route: Codable {
    let data: RouteItem
}

struct RouteItem: Codable {
    let count: Int
    let knowCount: Int
    let next: String?
    let previous: String?
    let routeList: [RouteDetailItem]
    
    enum CodingKeys: String, CodingKey {
        case count
        case knowCount = "know_count"
        case next
        case previous
        case routeList = "regularly_list"
    }
}

struct RouteDetailItem: Codable {
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
