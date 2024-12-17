//
//  NoticeModel.swift
//  RPA-D
//
//  Created by 이주성 on 12/16/24.
//

import Foundation
import Alamofire

final class NoticeModel {
    private(set) var loadNoticeListDataRequest: DataRequest?
    private(set) var loadNoticeDetailDataRequest: DataRequest?
    
    func loadNoticeListDataRequest(page: Int, success: ((NoticeData) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/notice"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "page": page,
        ]
        
        self.loadNoticeListDataRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadNoticeListDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadNoticeListDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadNoticeListDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(NoticeData.self, from: data) {
                    print("loadNoticeListDataRequest succeeded")
                    success?(decodedData)
                    
                } else {
                    print("loadNoticeListDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadNoticeListDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func loadNoticeDetailDataRequest(id: Int, success: ((NoticeDetailData) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/notice/\(id)"
        
        let headers: HTTPHeaders = [
            "accept":"application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        self.loadNoticeDetailDataRequest = AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
        
        self.loadNoticeDetailDataRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadNoticeDetailDataRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadNoticeDetailDataRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(NoticeDetailData.self, from: data) {
                    print("loadNoticeDetailDataRequest succeeded")
                    success?(decodedData)
                    
                } else {
                    print("loadNoticeDetailDataRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error):
                print("loadNoticeDetailDataRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}

struct NoticeData: Codable {
    let count: Int
    let next: String?
    let results: [NoticeItem]
}

struct NoticeItem: Codable {
    let id: Int
    let title: String
    let date: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case date = "pub_date"
        case creator
    }
}

struct NoticeDetailData: Codable {
    let id: Int
    let title: String
    let content: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case date = "pub_date"
    }
}
