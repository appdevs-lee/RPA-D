//
//  MainViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    lazy var statusBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.useRGB(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: <#T##CGFloat#>, weight: <#T##UIFont.PretendardFontType#>)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var role: Role = .driver
    
    init() {
        switch User.shared.role {
        case "운전원":
            self.role = .driver
            
        case "팀장":
            self.role = .driverLeader
            
        default:
            break
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
        SupportingMethods.shared.addSubviews([
            self.statusBaseView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // statusBaseView
        NSLayoutConstraint.activate([
            self.statusBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.statusBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.statusBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.statusBaseView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 236 / 375),
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
