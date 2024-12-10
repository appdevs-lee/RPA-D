//
//  NotificationListViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 12/10/24.
//

import UIKit

final class NotificationListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: "NotificationTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let memberModel = MemberModel()
    var notificationList: [NotificationDetailItem] = []
    var item: NotificationItem?
    var nextRequest: String?
    var page: Int = 1
    
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
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- NotificationListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension NotificationListViewController: EssentialViewMethods {
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
        SupportingMethods.shared.addSubviews([
            self.tableView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
        
        self.navigationItem.title = "알림"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
        
    }
    
    func setData() {
        self.loadNotificationListRequest(page: 1)
        
    }
}

// MARK: - Extension for methods added
extension NotificationListViewController {
    func loadNotificationListRequest(page: Int, success: ((NotificationItem) -> ())?) {
        self.memberModel.loadNotificationListRequest(page: page) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadNotificationListRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadNotificationListRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadNotificationListRequest(page: page) { item in
            self.page = page
            self.nextRequest = item.next
            
            self.notificationList.append(contentsOf: item.notificationList)
            
            if !item.notificationList.isEmpty {
                self.tableView.reloadData()
                
            }
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        
    }
    
    func sendReadNotificationRequest(id: Int, success: (() -> ())?) {
        self.memberModel.sendReadNotificationRequest(id: id) {
            success?()
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendReadNotificationRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension NotificationListViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

// MARK: - Extension for selector methods
extension NotificationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notificationList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        let notification = self.notificationList[indexPath.row]
        
        cell.setCell(notification: notification)
        
        if indexPath.row == self.notificationList.count - 1 && self.nextRequest != nil {
            self.loadNotificationListRequest(page: self.page + 1)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification = self.notificationList[indexPath.row]
        
        SupportingMethods.shared.turnCoverView(.on)
        self.sendReadNotificationRequest(id: notification.id) {
            self.navigationController?.popViewController(animated: true)
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        
    }
    
}

