//
//  CalendarViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- CalendarViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CalendarViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        
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
}

// MARK: - Extension for methods added
extension CalendarViewController {
    
}

// MARK: - Extension for selector methods
extension CalendarViewController {
    
}
