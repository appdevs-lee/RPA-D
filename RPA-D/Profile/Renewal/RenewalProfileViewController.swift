//
//  RenewalProfileViewController.swift
//  RPA-D
//
//  Created by 이주성 on 1/26/25.
//

import UIKit

final class RenewalProfileViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("profileImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(User.shared.name)"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.text = "\(User.shared.position)/성화투어"
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var salaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("예상 급여", for: .normal)
        button.setTitleColor(.useRGB(red: 101, green: 100, blue: 100), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Regular)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(thisMonthSalaryButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var myCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("내 명함", for: .normal)
        button.setTitleColor(.useRGB(red: 101, green: 100, blue: 100), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Regular)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(cardButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("profile.next")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var profileDetailButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(profileDetailButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let memberModel = MemberModel()
    let profileModel = ProfileModel()
    
    var profileMenuList: [String] = ["월간 분석", "앱 정보", "알림 설정"]
    
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
        print("----------------------------------- RenewalProfileViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalProfileViewController: EssentialViewMethods {
    func setViewFoundation() {
        // Pop Slide
        if self.navigationController?.viewControllers.first === self  {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
        
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
            self.baseView,
            self.tableView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.profileImageView,
            self.nameLabel,
            self.positionLabel,
            self.arrowImageView,
            self.profileDetailButton,
            self.lineView,
            self.salaryButton,
            self.myCardButton,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 28),
        ])
        
        // profileImageView
        NSLayoutConstraint.activate([
            self.profileImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.profileImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 20),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 48),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 8),
            self.nameLabel.topAnchor.constraint(equalTo: self.profileImageView.topAnchor),
        ])
        
        // positionLabel
        NSLayoutConstraint.activate([
            self.positionLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 8),
            self.positionLabel.bottomAnchor.constraint(equalTo: self.profileImageView.bottomAnchor),
        ])
        
        // arrowImageView
        NSLayoutConstraint.activate([
            self.arrowImageView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.arrowImageView.centerYAnchor.constraint(equalTo: self.profileImageView.centerYAnchor),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // profileDetailButton
        NSLayoutConstraint.activate([
            self.profileDetailButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.profileDetailButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.profileDetailButton.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.profileDetailButton.bottomAnchor.constraint(equalTo: self.lineView.topAnchor),
        ])
        
        // lineView
        NSLayoutConstraint.activate([
            self.lineView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.lineView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.lineView.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 12),
            self.lineView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // salaryButton
        NSLayoutConstraint.activate([
            self.salaryButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.salaryButton.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 12),
            self.salaryButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -20),
            self.salaryButton.heightAnchor.constraint(equalToConstant: 44),
            self.salaryButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 92) / 2.0)
        ])
        
        // myCardButton
        NSLayoutConstraint.activate([
            self.myCardButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.myCardButton.leadingAnchor.constraint(equalTo: self.salaryButton.trailingAnchor, constant: 12),
            self.myCardButton.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 12),
            self.myCardButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -20),
            self.myCardButton.heightAnchor.constraint(equalToConstant: 44),
            self.myCardButton.widthAnchor.constraint(equalTo: self.salaryButton.widthAnchor, multiplier: 1.0),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: 22),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 46, green: 45, blue: 45),
            .font:UIFont.useFont(ofSize: 20, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = ""
        
        let leftBarButtonItem = UIBarButtonItem(title: "마이", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 20, weight: .Bold),
            .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
}

// MARK: - Extension for methods added
extension RenewalProfileViewController {
    func loadMyInfoRequest(success: ((MyInfoItem) -> ())?) {
        self.memberModel.loadMyInfoRequest { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendDispatchInfoUpdateRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadSalaryStatementRequest(date: Date, success: ((String) -> ())?) {
        self.profileModel.loadSalaryStatementRequest(date: date) { html in
            success?(html)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadSalaryStatementRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension RenewalProfileViewController {
    @objc func cardButton(_ sender: UIButton) {
        self.loadMyInfoRequest { item in
            let vc = CardViewController(item: item)
            
            self.present(vc, animated: true)
        }
        
    }
    
    @objc func thisMonthSalaryButton(_ sender: UIButton) {
        let date = SupportingMethods.shared.calculateDate(byValue: -1, component: .month, date: Date())
        
        switch Role(rawValue: User.shared.role) {
        case .driver:
            SupportingMethods.shared.turnCoverView(.on)
            self.loadSalaryStatementRequest(date: date) { html in
                let vc = SalaryViewController(html: html)
                
                self.navigationController?.pushViewController(vc, animated: true)
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        default:
            SupportingMethods.shared.showAlertNoti(title: "현재 기사 분들만 급여 확인이 가능합니다.")
            
        }
        
    }
    
    @objc func profileDetailButton(_ sender: UIButton) {
        let vc = ProfileDetailViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func logoutButton(_ sender: UIButton) {
        SupportingMethods.shared.determineAppState(.logout)
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension RenewalProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.profileMenuList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        let menu = self.profileMenuList[indexPath.row]
        
        cell.setCell(menu: menu, index: indexPath.row)
        
        return cell
        
    }
    
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension RenewalProfileViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
    
}
