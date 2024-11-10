//
//  LoginModel.swift
//  RPA-D
//
//  Created by 이주성 on 11/10/24.
//

import Foundation
import Alamofire

final class LoginModel {
    private(set) var loginRequest: DataRequest?
    private(set) var tokenRefreshRequest: DataRequest?
    private(set) var sendFCMTokenRequest: DataRequest?
    
    func loginRequest(id: String, pwd: String, success: ((LoginDetail) -> ())?, loginFailure: ((_ reason: Int) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = ServerSetting.server.URL + "/login"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "user_id": id,
            "password": pwd
        ]
        
        self.loginRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.loginRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loginRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loginRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(DefaultResponse.self, from: data) {
                    if decodedData.result == "true" { // result == true
                        if let decodedData = try? JSONDecoder().decode(Login.self, from: data) {
                            print("loginRequest succeeded")
                            ReferenceValues.accessToken = "Bearer \(decodedData.data.access)"
                            ReferenceValues.refreshToken = decodedData.data.refresh
                            ReferenceValues.role = decodedData.data.authenticatedUser.role
                            ReferenceValues.name = decodedData.data.authenticatedUser.name
                            success?(decodedData.data)
                                                
                        } else {
                            print("loginRequest failure: API 성공, Parsing 실패")
                            failure?("API 성공, Parsing 실패")
                        }
                        
                    } else { // result == false
                        if let decodedData = try? JSONDecoder().decode(LoginFailure.self, from: data) {
                            // parsing failure
                            print("loginRequest succeeded: LoginFailure")
                            loginFailure?(decodedData.data)
                        } else {
                            print("loginRequest failure: \(decodedData.result)")
                            failure?(decodedData.result)
                        }
                    }
                    
                } else { // improper structure
                    print("loginRequest failure: improper structure")
                    failure?("알 수 없는 Response 구조")
                }
                
            case .failure(let error): // error
                print("loginRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func tokenRefreshRequest(success: ((Token) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/token/refresh"
        print(url)
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "refresh": ReferenceValues.refreshToken
        ]
        
        self.tokenRefreshRequest = AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
        self.tokenRefreshRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("tokenRefreshRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("tokenRefreshRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(Refresh.self, from: data) {
                    print("tokenRefreshRequest succeeded")
                    ReferenceValues.accessToken = "Bearer \(decodedData.data.access)"
                    ReferenceValues.refreshToken = decodedData.data.refresh
                    success?(decodedData.data)
                    
                } else {
                    print("tokenRefreshRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                }
                
            case .failure(let error): // error
                print("tokenRefreshRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    func sendFCMTokenRequest(success: ((FCMTokenItem) -> ())?, failure: ((_ message: String) -> ())?) {
        let url = ServerSetting.server.URL + "/notification"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "token": ReferenceValues.fcmToken
        ]
        
        self.sendFCMTokenRequest = AF.request(url, method: .patch, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.sendFCMTokenRequest?.responseData { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("sendFCMTokenRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("sendFCMTokenRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                if let decodedData = try? JSONDecoder().decode(FCMToken.self, from: data) {
                    print("sendFCMTokenRequest succeeded")
                    success?(decodedData.data)
                    
                } else {
                    print("sendFCMTokenRequest failure: API 성공, Parsing 실패")
                    failure?("API 성공, Parsing 실패")
                    
                }
                
            case .failure(let error): // error
                print("sendFCMTokenRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
}

struct DefaultResponse: Codable {
    let result: String
}

struct Login: Codable {
    let result: String
    let data: LoginDetail
}

struct LoginFailure: Codable {
    let result: String
    let data: Int
}

struct LoginDetail: Codable {
    let access: String
    let refresh: String
    let authenticatedUser: UserInfoDetail
}

struct UserInfoDetail: Codable {
    let user_id: String
    let name: String
    let role: String
}


struct Refresh: Codable {
    let result: String
    let data: Token
}

struct Token: Codable {
    let access: String
    let refresh: String
}

struct FailureResponse: Codable {
    let result: String
    let data: Int
}

struct FCMToken: Codable {
    let result: String
    let data: FCMTokenItem
}

struct FCMTokenItem: Codable {
    let token: String
}
