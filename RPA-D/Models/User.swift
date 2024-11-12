//
//  User.swift
//  RPA-D
//
//  Created by Awesomepia on 11/12/24.
//

import Foundation

enum Role: String {
    case driver = "운전원"
    case driverLeader = "팀장"
    case manager = "관리자"
}

final class User {
    static let shared = User()
    
    var name: String = ""
    var role: String = "" // 역할: 운전원, 팀장, 관리자
    var position: String = "" // 직급: 임원 부장 차장 과장 대리 계장 주임 사원 인턴/소장 수석팀장 팀장 승무원
}
