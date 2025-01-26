//
//  ProfileDetailViewController.swift
//  RPA-D
//
//  Created by 이주성 on 1/26/25.
//

import UIKit

final class ProfileDetailViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var basicInfoBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    lazy var companyBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var companyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "입사정보"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "성명"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var nameForCompanyLabel: UILabel = {
        let label = UILabel()
        label.text = "\(User.shared.name)"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var permissionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "권한"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var permissionLabel: UILabel = {
        let label = UILabel()
        label.text = "\(User.shared.role)"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var teamTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "소속팀"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.text = "업데이트 예정"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var joinDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "입사일"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var joinDateLabel: UILabel = {
        let label = UILabel()
        label.text = "업데이트 예정"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var userBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var userTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원정보"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "업데이트 예정"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var phoneNumTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "핸드폰번호"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var phoneNumLabel: UILabel = {
        let label = UILabel()
        label.text = "업데이트 예정"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "****"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("logoutImage"), for: .normal)
        button.addTarget(self, action: #selector(logoutButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
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
        print("----------------------------------- ProfileDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ProfileDetailViewController: EssentialViewMethods {
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
            self.scrollView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.basicInfoBaseView,
            self.companyBaseView,
            self.userBaseView,
            self.logoutButton,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.nameLabel,
            self.positionLabel,
        ], to: self.basicInfoBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.companyTitleLabel,
            self.nameTitleLabel,
            self.nameForCompanyLabel,
            self.permissionTitleLabel,
            self.permissionLabel,
            self.teamTitleLabel,
            self.teamLabel,
            self.joinDateTitleLabel,
            self.joinDateLabel,
        ], to: self.companyBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.userTitleLabel,
            self.emailTitleLabel,
            self.emailLabel,
            self.phoneNumTitleLabel,
            self.phoneNumLabel,
            self.passwordTitleLabel,
            self.passwordLabel,
        ], to: self.userBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
        ])
        
        // basicInfoBaseView
        NSLayoutConstraint.activate([
            self.basicInfoBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.basicInfoBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.basicInfoBaseView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 20),
            self.nameLabel.topAnchor.constraint(equalTo: self.basicInfoBaseView.topAnchor, constant: 24),
        ])
        
        // positionLabel
        NSLayoutConstraint.activate([
            self.positionLabel.leadingAnchor.constraint(equalTo: self.basicInfoBaseView.leadingAnchor, constant: 20),
            self.positionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4),
            self.positionLabel.bottomAnchor.constraint(equalTo: self.basicInfoBaseView.bottomAnchor, constant: -24)
        ])
        
        // companyBaseView
        NSLayoutConstraint.activate([
            self.companyBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.companyBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.companyBaseView.topAnchor.constraint(equalTo: self.basicInfoBaseView.bottomAnchor, constant: 12),
        ])
        
        // companyTitleLabel
        NSLayoutConstraint.activate([
            self.companyTitleLabel.leadingAnchor.constraint(equalTo: self.companyBaseView.leadingAnchor, constant: 20),
            self.companyTitleLabel.topAnchor.constraint(equalTo: self.companyBaseView.topAnchor, constant: 20),
        ])
        
        // nameTitleLabel
        NSLayoutConstraint.activate([
            self.nameTitleLabel.leadingAnchor.constraint(equalTo: self.companyBaseView.leadingAnchor, constant: 20),
            self.nameTitleLabel.centerYAnchor.constraint(equalTo: self.nameForCompanyLabel.centerYAnchor),
        ])
        
        // nameForCompanyLabel
        NSLayoutConstraint.activate([
            self.nameForCompanyLabel.trailingAnchor.constraint(equalTo: self.companyBaseView.trailingAnchor, constant: -20),
            self.nameForCompanyLabel.topAnchor.constraint(equalTo: self.companyTitleLabel.bottomAnchor, constant: 24),
        ])
        
        // permissionTitleLabel
        NSLayoutConstraint.activate([
            self.permissionTitleLabel.leadingAnchor.constraint(equalTo: self.companyBaseView.leadingAnchor, constant: 20),
            self.permissionTitleLabel.centerYAnchor.constraint(equalTo: self.permissionLabel.centerYAnchor),
        ])
        
        // permissionLabel
        NSLayoutConstraint.activate([
            self.permissionLabel.trailingAnchor.constraint(equalTo: self.companyBaseView.trailingAnchor, constant: -20),
            self.permissionLabel.topAnchor.constraint(equalTo: self.nameForCompanyLabel.bottomAnchor, constant: 36),
        ])
        
        // teamTitleLabel
        NSLayoutConstraint.activate([
            self.teamTitleLabel.leadingAnchor.constraint(equalTo: self.companyBaseView.leadingAnchor, constant: 20),
            self.teamTitleLabel.centerYAnchor.constraint(equalTo: self.teamLabel.centerYAnchor),
        ])
        
        // teamLabel
        NSLayoutConstraint.activate([
            self.teamLabel.trailingAnchor.constraint(equalTo: self.companyBaseView.trailingAnchor, constant: -20),
            self.teamLabel.topAnchor.constraint(equalTo: self.permissionLabel.bottomAnchor, constant: 36),
        ])
        
        // joinDateTitleLabel
        NSLayoutConstraint.activate([
            self.joinDateTitleLabel.leadingAnchor.constraint(equalTo: self.companyBaseView.leadingAnchor, constant: 20),
            self.joinDateTitleLabel.centerYAnchor.constraint(equalTo: self.joinDateLabel.centerYAnchor),
        ])
        
        // joinDateLabel
        NSLayoutConstraint.activate([
            self.joinDateLabel.trailingAnchor.constraint(equalTo: self.companyBaseView.trailingAnchor, constant: -20),
            self.joinDateLabel.topAnchor.constraint(equalTo: self.teamLabel.bottomAnchor, constant: 36),
            self.joinDateLabel.bottomAnchor.constraint(equalTo: self.companyBaseView.bottomAnchor, constant: -32),
        ])
        
        // userBaseView
        NSLayoutConstraint.activate([
            self.userBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.userBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.userBaseView.topAnchor.constraint(equalTo: self.companyBaseView.bottomAnchor, constant: 12),
        ])
        
        // userTitleLabel
        NSLayoutConstraint.activate([
            self.userTitleLabel.leadingAnchor.constraint(equalTo: self.userBaseView.leadingAnchor, constant: 20),
            self.userTitleLabel.topAnchor.constraint(equalTo: self.userBaseView.topAnchor, constant: 20),
        ])
        
        // emailTitleLabel
        NSLayoutConstraint.activate([
            self.emailTitleLabel.leadingAnchor.constraint(equalTo: self.userBaseView.leadingAnchor, constant: 20),
            self.emailTitleLabel.centerYAnchor.constraint(equalTo: self.emailLabel.centerYAnchor),
        ])
        
        // emailLabel
        NSLayoutConstraint.activate([
            self.emailLabel.trailingAnchor.constraint(equalTo: self.userBaseView.trailingAnchor, constant: -20),
            self.emailLabel.topAnchor.constraint(equalTo: self.userTitleLabel.bottomAnchor, constant: 24),
        ])
        
        // phoneNumTitleLabel
        NSLayoutConstraint.activate([
            self.phoneNumTitleLabel.leadingAnchor.constraint(equalTo: self.userBaseView.leadingAnchor, constant: 20),
            self.phoneNumTitleLabel.centerYAnchor.constraint(equalTo: self.phoneNumLabel.centerYAnchor),
        ])
        
        // phoneNumLabel
        NSLayoutConstraint.activate([
            self.phoneNumLabel.trailingAnchor.constraint(equalTo: self.userBaseView.trailingAnchor, constant: -20),
            self.phoneNumLabel.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 36),
        ])
        
        // passwordTitleLabel
        NSLayoutConstraint.activate([
            self.passwordTitleLabel.leadingAnchor.constraint(equalTo: self.userBaseView.leadingAnchor, constant: 20),
            self.passwordTitleLabel.centerYAnchor.constraint(equalTo: self.passwordLabel.centerYAnchor),
        ])
        
        // passwordLabel
        NSLayoutConstraint.activate([
            self.passwordLabel.trailingAnchor.constraint(equalTo: self.userBaseView.trailingAnchor, constant: -20),
            self.passwordLabel.topAnchor.constraint(equalTo: self.phoneNumLabel.bottomAnchor, constant: 36),
            self.passwordLabel.bottomAnchor.constraint(equalTo: self.userBaseView.bottomAnchor, constant: -32),
        ])
        
        // logoutButton
        NSLayoutConstraint.activate([
            self.logoutButton.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.logoutButton.topAnchor.constraint(equalTo: self.userBaseView.bottomAnchor, constant: 48),
            self.logoutButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -60),
            self.logoutButton.widthAnchor.constraint(equalToConstant: 96),
            self.logoutButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 46, green: 45, blue: 45),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "내 정보"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension ProfileDetailViewController {
    
}

// MARK: - Extension for selector methods
extension ProfileDetailViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func logoutButton(_ sender: UIButton) {
        SupportingMethods.shared.determineAppState(.logout)
        
    }
    
}
