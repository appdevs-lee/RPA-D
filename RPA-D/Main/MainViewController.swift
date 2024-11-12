//
//  MainViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    var role: Role
    
    init() {
        switch User.shared.role {
        case "운전원":
            self.role = .driver
            
        case "팀장":
            self.role = .driverLeader
            
        case "관리자":
            self.role = .manager
            
        default:
            self.role = .manager
            
        }
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        self.setUpNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- MainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension MainViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        
    }
    
    func setLayouts() {
        //let safeArea = self.view.safeAreaLayoutGuide
        
        //
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = ""
        
        // FIXME: action 삭제 필수
        switch self.role {
        case .manager:
            let leftBarButtonItem = UIBarButtonItem(title: "노선", style: .plain, target: self, action: nil)
            leftBarButtonItem.setTitleTextAttributes([
                .font:UIFont.useFont(ofSize: 20, weight: .Bold),
                .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
            ], for: .normal)
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            
        default:
            let leftBarButtonItem = UIBarButtonItem(title: "운행", style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
            leftBarButtonItem.setTitleTextAttributes([
                .font:UIFont.useFont(ofSize: 20, weight: .Bold),
                .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
            ], for: .normal)
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            
        }
        
    }
}

// MARK: - Extension for methods added
extension MainViewController {
    
}

// MARK: - Extension for selector methods
extension MainViewController {
    // FIXME: 추후 삭제 필수
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = GetUpCheckViewController()
        
        self.present(vc, animated: true)
    }
}
