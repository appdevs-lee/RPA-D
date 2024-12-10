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
    
    func loadMemberListRequest(page: Int, success: ((MemberItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/member/list"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "page": page,
            "search": "",
            "separate_role": "",
        ]
        
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
