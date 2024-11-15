//
//  CustomizedTabBarController.swift
//  UniversalBora
//
//  Created by Awesomepia on 6/20/24.
//

import UIKit

class CustomizedTabBarController: UITabBarController {
    
    // 이전에 선택했던 탭
    var previousSelectedIndex: Int = 0
    
    // 현재 선택한 탭
    var currentSelectedIndex: Int = 0 {
        didSet {
            self.previousSelectedIndex = oldValue
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Tabbar Desgin
        self.setUpTabbar()
        
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.selectedViewController?.preferredStatusBarStyle ?? .default
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return (self.selectedViewController?.supportedInterfaceOrientations ?? .portrait) == .landscape ? .landscape : .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return (self.selectedViewController?.preferredInterfaceOrientationForPresentation ?? .portrait) == .landscapeRight ? .landscapeRight : .portrait
    }
    
    deinit {
            print("----------------------------------- CustomizedTabBarController disposed -----------------------------------")
    }
}

// MARK: Extension for methods add
extension CustomizedTabBarController {
    func setUpTabbar() {
        self.delegate = self
        self.tabBar.backgroundColor = .white
        self.tabBar.layer.borderWidth = 0
        
        // Set ViewControllers in Tabbar
        let mainVC = MainViewController()
        let calendarVC = CalendarViewController()
        let officeVC = OfficeViewController()
        let profileVC = ProfileViewController()
        
        self.viewControllers = [
            self.createTabBarItem(tabBarTitle: "운행", tabBarImage: "Main", selectedImage: "selectedMain", viewController: mainVC),
            self.createTabBarItem(tabBarTitle: "배차 달력", tabBarImage: "Calendar", selectedImage: "selectedCalendar", viewController: calendarVC),
            self.createTabBarItem(tabBarTitle: "사무", tabBarImage: "Office", selectedImage: "selectedOffice", viewController: officeVC),
            self.createTabBarItem(tabBarTitle: "프로필", tabBarImage: "Profile", selectedImage: "selectedProfile", viewController: profileVC),
        ]
    }
    
    func createTabBarItem(tabBarTitle: String, tabBarImage: String, selectedImage: String, viewController: UIViewController) -> UINavigationController {
        let naviVC = CustomizedNavigationController(rootViewController: viewController)
        naviVC.tabBarItem.title = tabBarTitle
        naviVC.tabBarItem.setTitleTextAttributes([
            .foregroundColor: UIColor.useRGB(red: 196, green: 195, blue: 195),
            .font: UIFont.useFont(ofSize: 14, weight: .Medium)
        ], for: .normal)
        naviVC.tabBarItem.setTitleTextAttributes([
            .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45),
        ], for: .selected)
        naviVC.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        naviVC.tabBarItem.image = UIImage(named: tabBarImage)?.withRenderingMode(.alwaysOriginal)
        
        return naviVC
    }
    
}

extension CustomizedTabBarController {
    @objc func changeTextLanguage(_ notification: Notification) {
        for _ in self.tabBar.items! {
//            item.title = SupportingMethods.shared.getText("tabbar.home")
        }
    }
}

// MARK: Extension for UITabBarControllerDelegate
extension CustomizedTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.currentSelectedIndex = tabBarController.selectedIndex
        
        if tabBarController.selectedIndex == 0 {
            print("운행")
            
        }
        
        if tabBarController.selectedIndex == 1 {
            print("배차 달력")
            
        }
        
        if tabBarController.selectedIndex == 2 {
            print("사무")
            
        }
        
        if tabBarController.selectedIndex == 3 {
            print("프로필")
            
        }
        
    }
    
}
