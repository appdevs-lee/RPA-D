//
//  NetworkMonitor.swift
//  InjeFestival
//
//  Created by Awesomepia on 9/20/24.
//

import Foundation
import Network

final class NetworkMonitor{
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    /// 연결타입
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init(){
        self.monitor = NWPathMonitor()
    }
    
    func startMonitoring(){
        print("startMonitoring 호출")
        self.monitor.start(queue: .global())
        self.monitor.pathUpdateHandler = { [weak self] path in
            self?.getConenctionType(path)
            
            if path.status == .satisfied {
                print(" ===== Network is connected ===== ")
                self?.isConnected = true
                
            } else {
                print(" ===== Network is disconnected ===== ")
                self?.isConnected = false
                
                DispatchQueue.main.async {
                    let vc = AlertPopViewController(.normalTwoButton(messageTitle: "네트워크 연결이 원활하지 않습니다", messageContent: "연결 상태를 확인한 후, 다시 시도해 주세요", leftButtonTitle: "앱 종료", leftAction: {
                        SupportingMethods.shared.determineAppState(.terminate)
                        
                    }, rightButtonTitle: "재접속", rightAction: {
                        SupportingMethods.shared.determineAppState(.networkError)
                        
                    }))
                    
                    if let topVC = SupportingMethods.shared.getTopVC(ReferenceValues.keyWindow.rootViewController) {
                        if let presentingVC = topVC.presentingViewController, let _ = topVC as? AlertPopViewController {
                            presentingVC.dismiss(animated: false) {
                                presentingVC.present(vc, animated: true)
                            }
                            
                        } else {
                            topVC.present(vc, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func stopMonitoring(){
        print("stopMonitoring 호출")
        self.monitor.cancel()
    }
    
    
    private func getConenctionType(_ path:NWPath) {
        print("getConenctionType 호출")
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
            print("wifi에 연결")

        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
            print("cellular에 연결")

        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
            print("wiredEthernet에 연결")

        }else {
            connectionType = .unknown
            print("unknown ..")
        }
    }
}
