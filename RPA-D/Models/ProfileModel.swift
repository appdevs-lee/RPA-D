//
//  ProfileModel.swift
//  RPA-D
//
//  Created by Awesomepia on 12/11/24.
//

import Foundation
import Alamofire

final class ProfileModel {
    private(set) var loadSalaryStatementRequest: DataRequest?
    private(set) var signSalaryStatementRequest: DataRequest?
    
    // MARK: - 급여명세서 불러오는 API
    func loadSalaryStatementRequest(date: Date, success: ((String) -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = ServerSetting.server.URL + "/salary/detail"
        
        let headers: HTTPHeaders = [
            "access": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "date": SupportingMethods.shared.convertDate(intoString: date, "yyyy-MM")
        ]
        
        self.loadSalaryStatementRequest = AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.loadSalaryStatementRequest?.responseString { response in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("loadDispatchGroupListRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("loadDispatchGroupListRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                success?(data)
                
            case .failure(let error): // error
                print("loadDispatchGroupListRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
    
    // MARK: - 급여명세서 사인 API
    func signSalaryStatementRequest(date: String, success: (() -> ())?, failure: ((_ errorMessage: String) -> ())?) {
        let url = ServerSetting.server.URL + "/salary/detail"
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": ReferenceValues.accessToken
        ]
        
        let parameters: Parameters = [
            "date": date
        ]
        
        self.signSalaryStatementRequest = AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
        
        self.signSalaryStatementRequest?.responseData { (response) in
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else {
                    print("signSalaryStatementRequest failure: statusCode nil")
                    failure?("statusCodeNil")
                    
                    return
                }
                
                guard statusCode >= 200 && statusCode < 300 else {
                    print("signSalaryStatementRequest failure: statusCode(\(statusCode))")
                    failure?("statusCodeError")
                    
                    return
                }
                
                print("signSalaryStatementRequest succeeded")
                success?()
                
            case .failure(let error):
                print("signSalaryStatementRequest error: \(error.localizedDescription)")
                failure?(error.localizedDescription)
            }
        }
    }
}

