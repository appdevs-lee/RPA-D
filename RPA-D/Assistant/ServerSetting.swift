//
//  ServerSetting.swift
//  Universal
//
//  Created by Awesomepia on 2023/03/29.
//

import Foundation

struct ServerSetting {
    static let server: Server = .RELEASE
    
    // MARK: RELEASE v1.0.0(1) - 2024/11/10
    
    enum Server: String {
        case DEV
        
        case QA
        
        case RELEASE
        
        var URL: String {
            switch self {
            case .DEV:
                return "http://34.121.50.23:8000"
                
            case .QA:
                return ""
                
            case .RELEASE:
                return "http://api.kingbuserp.link"
            }
        }
        
    }
}
