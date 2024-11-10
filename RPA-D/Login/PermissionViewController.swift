//
//  PermissionViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/10/24.
//

import UIKit
import CoreLocation

struct Permission {
    let name: String
    let title: String
    let subTitle: String
}

final class PermissionViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "RPA-D\n앱 접근권한 안내"
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 28, weight: .SemiBold)
        label.numberOfLines = 0
        label.asColor(targetString: "RPA-D", color: .useRGB(red: 223, green: 52, blue: 52))
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "고객님의 원활한 RPA-D 서비스 이용을 위해\n다음 접근 권한의 허용이 필요해요."
        label.textColor = .useRGB(red: 94, green: 94, blue: 94)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PermissionTableViewCell.self, forCellReuseIdentifier: "PermissionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var permissionRequestButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255), for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(permissionRequestButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let locationManager = CLLocationManager()
    let permissionList: [Permission] = [
        Permission(name: "Notification", title: "알림", subTitle: "배차 배정 및 운행 관련 알림"),
        Permission(name: "Location", title: "위치", subTitle: "경로 저장 및 안내, 정류장 확인")
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- PermissionViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension PermissionViewController: EssentialViewMethods {
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
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.subTitleLabel,
            self.tableView,
            self.permissionRequestButton,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 52)
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20)
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 28),
            self.tableView.bottomAnchor.constraint(equalTo: self.permissionRequestButton.topAnchor, constant: -44),
        ])
        
        // permissionRequestButton
        NSLayoutConstraint.activate([
            self.permissionRequestButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.permissionRequestButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.permissionRequestButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            self.permissionRequestButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension PermissionViewController {
    
}

// MARK: - Extension for selector methods
extension PermissionViewController {
    @objc func permissionRequestButton(_ sender: UIButton) {
        SupportingMethods.shared.requestNotificationPermission {
            self.locationManager.delegate = self
            
            switch self.locationManager.authorizationStatus {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.requestAlwaysAuthorization()
                
            default:
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        ReferenceValues.isCheckPermission = true
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

// MARK: - Extension for CLLocationManagerDelegate
extension PermissionViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print(".notDetermined")
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
            
        default:
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: Notification.Name("Permission"), object: nil)
                ReferenceValues.isCheckPermission = true
                
            }
        }
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension PermissionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.permissionList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PermissionTableViewCell", for: indexPath) as! PermissionTableViewCell
        let permission = self.permissionList[indexPath.row]
        
        cell.setCell(permission: permission)
        
        return cell
        
    }
    
}
