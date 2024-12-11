//
//  MemberModel.swift
//  RPA-D
//
//  Created by Awesomepia on 12/10/24.
//

import Foundation
import Alamofire

final class MemberModel {
    // 전화번호 Get
    private(set) var loadMemberListRequest: DataRequest?
    // 개인 Info 가져오기
    private(set) var loadMyInfoRequest: DataRequest?
    // 알림 가져오기
    private(set) var loadNotificationListRequest: DataRequest?
    // 읽은 알림 처리
    private(set) var sendReadNotificationRequest: DataRequest?
    
    func loadMemberListRequest(page: Int, search: String = "", role: String = "", success: ((MemberItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/member/list"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        var parameters: Parameters = [
            "page": page,
        ]
        
        // 관리자, 운전원, 용역
        if role != "" {
            parameters.updateValue(role, forKey: "separate_role")
            
        }
        
        if search != "" {
            parameters.updateValue(search, forKey: "search")
            
        }
        
        self.loadMemberListRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadMemberListRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadMemberListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadMemberListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Member.self, from: data) {
                    print("loadMemberListRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadMemberListRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadMemberListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadMyInfoRequest(success: ((MyInfoItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/member"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadMyInfoRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadMyInfoRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadMyInfoRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadMyInfoRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(MyInfo.self, from: data) {
                    print("loadMyInfoRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadMyInfoRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadMyInfoRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadNotificationListRequest(page: Int, success: ((NotificationItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/member/notification/list"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "page": page,
        ]
        
        self.loadNotificationListRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadNotificationListRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadNotificationListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadNotificationListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Notifications.self, from: data) {
                    print("loadNotificationListRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("loadNotificationListRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadNotificationListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendReadNotificationRequest(id: Int, success: (() -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/member/notification/read"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "notification_id": id
        ]
        
        self.sendReadNotificationRequest = AF.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.sendReadNotificationRequest?.responseData { (response) in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    print("sendReadNotificationRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendReadNotificationRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("sendReadNotificationRequest succeeded")
                success?()
                
            case .failure(let error):
                print("sendReadNotificationRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}

struct MyInfo: Codable {
    let data: MyInfoItem
}

struct MyInfoItem: Codable {
    let phoneNum: String
    
    enum CodingKeys: String, CodingKey {
        case phoneNum = "phone_num"
    }
}

struct Member: Codable {
    let data: MemberItem
}

struct MemberItem: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let memberList: [MemberDetailItem]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case memberList = "member_list"
    }
}

struct MemberDetailItem: Codable {
    let name: String
    let role: String
    let phoneNum: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case role
        case phoneNum = "phone_num"
    }
}

struct Notifications: Codable {
    let data: NotificationItem
}

struct NotificationItem: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let notificationList: [NotificationDetailItem]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case notificationList = "notification_list"
    }
}

struct NotificationDetailItem: Codable {
    let id: Int
    let title: String
    let content: String
    let isRead: Bool
    let category: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case isRead = "is_read"
        case category
        case date
    }
}
