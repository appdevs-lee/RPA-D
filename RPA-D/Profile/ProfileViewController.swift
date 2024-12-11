//
//  ProfileViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    lazy var profileBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.positionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(User.shared.name)"
        label.textColor = .white
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.text = "\(User.shared.position)/성화투어"
        label.textColor = .white
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var salaryBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var salaryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 급여"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var thisMonthSalaryButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("thisMonthSalaryCheckImage"), for: .normal)
        button.addTarget(self, action: #selector(thisMonthSalaryButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var salaryButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.salaryListButton, self.lastMonthSalaryButton])
        stackView.axis = .horizontal
        stackView.spacing = 1.0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var salaryListButton: UIButton = {
        let button = UIButton()
        button.setTitle("급여 내역", for: .normal)
        button.setTitleColor(.useRGB(red: 101, green: 100, blue: 100), for: .normal)
        button.setTitleColor(.useRGB(red: 101, green: 100, blue: 100, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.addTarget(self, action: #selector(salaryListButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var lastMonthSalaryButton: UIButton = {
        let button = UIButton()
        button.setTitle("지난달 급여", for: .normal)
        button.setTitleColor(.useRGB(red: 101, green: 100, blue: 100), for: .normal)
        button.setTitleColor(.useRGB(red: 101, green: 100, blue: 100, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Medium)
        button.addTarget(self, action: #selector(lastMonthSalaryButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var lateView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var lateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지각"
        label.textColor = .useRGB(red: 223, green: 52, blue: 52)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var lateCountLabel: UILabel = {
        let label = UILabel()
        label.text = "집계 중..."
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var complaintsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var complaintsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "민원"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var complaintsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "집계 중..."
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var reasonsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var reasonsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사유서"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var reasonsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "집계 중..."
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let memberModel = MemberModel()
    
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
        print("----------------------------------- ProfileViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ProfileViewController: EssentialViewMethods {
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
            self.profileBaseView,
            self.profileStackView,
            self.salaryBaseView,
            
            self.lateView,
            self.complaintsView,
            self.reasonsView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.salaryTitleLabel,
            self.thisMonthSalaryButton,
            self.separateView,
            self.salaryButtonStackView,
        ], to: self.salaryBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.lateTitleLabel,
            self.lateCountLabel,
        ], to: self.lateView)
        
        SupportingMethods.shared.addSubviews([
            self.complaintsTitleLabel,
            self.complaintsCountLabel,
        ], to: self.complaintsView)
        
        SupportingMethods.shared.addSubviews([
            self.reasonsTitleLabel,
            self.reasonsCountLabel,
        ], to: self.reasonsView)

    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // profileBaseView
        NSLayoutConstraint.activate([
            self.profileBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.profileBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.profileBaseView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.profileBaseView.heightAnchor.constraint(equalToConstant: 278),
        ])
        
        // profileStackView
        NSLayoutConstraint.activate([
            self.profileStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.profileStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.profileStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
        ])
        
        // salaryBaseView
        NSLayoutConstraint.activate([
            self.salaryBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.salaryBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.salaryBaseView.topAnchor.constraint(equalTo: self.profileStackView.bottomAnchor, constant: 56),
//            self.salaryBaseView.heightAnchor.constraint(equalToConstant: 106)
        ])
        
        // salaryTitleLabel
        NSLayoutConstraint.activate([
            self.salaryTitleLabel.leadingAnchor.constraint(equalTo: self.salaryBaseView.leadingAnchor, constant: 16),
            self.salaryTitleLabel.topAnchor.constraint(equalTo: self.salaryBaseView.topAnchor, constant: 16),
        ])
        
        // thisMonthSalaryButton
        NSLayoutConstraint.activate([
            self.thisMonthSalaryButton.trailingAnchor.constraint(equalTo: self.salaryBaseView.trailingAnchor, constant: -16),
            self.thisMonthSalaryButton.centerYAnchor.constraint(equalTo: self.salaryTitleLabel.centerYAnchor),
            self.thisMonthSalaryButton.heightAnchor.constraint(equalToConstant: 20),
            self.thisMonthSalaryButton.widthAnchor.constraint(equalToConstant: 72),
        ])
        
        // sparateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.salaryBaseView.leadingAnchor, constant: 20),
            self.separateView.trailingAnchor.constraint(equalTo: self.salaryBaseView.trailingAnchor, constant: -20),
            self.separateView.topAnchor.constraint(equalTo: self.salaryTitleLabel.bottomAnchor, constant: 8),
            self.separateView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // salaryButtonStackView
        NSLayoutConstraint.activate([
            self.salaryButtonStackView.leadingAnchor.constraint(equalTo: self.salaryBaseView.leadingAnchor, constant: 16),
            self.salaryButtonStackView.trailingAnchor.constraint(equalTo: self.salaryBaseView.trailingAnchor, constant: -16),
            self.salaryButtonStackView.topAnchor.constraint(equalTo: self.separateView.bottomAnchor, constant: 16),
            self.salaryButtonStackView.bottomAnchor.constraint(equalTo: self.salaryBaseView.bottomAnchor, constant: -16)
        ])
        
        // salaryListButton
        NSLayoutConstraint.activate([
            self.salaryListButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 73) / 2),
            self.salaryListButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // lastMonthSalaryButton
        NSLayoutConstraint.activate([
            self.lastMonthSalaryButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 73) / 2),
            self.lastMonthSalaryButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // lateView
        NSLayoutConstraint.activate([
            self.lateView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.lateView.topAnchor.constraint(equalTo: self.salaryBaseView.bottomAnchor, constant: 20),
            self.lateView.heightAnchor.constraint(equalToConstant: 80),
            self.lateView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 64) / 3),
        ])
        
        // lateTitleLabel
        NSLayoutConstraint.activate([
            self.lateTitleLabel.leadingAnchor.constraint(equalTo: self.lateView.leadingAnchor, constant: 12),
            self.lateTitleLabel.topAnchor.constraint(equalTo: self.lateView.topAnchor, constant: 8),
        ])
        
        // lateCountLabel
        NSLayoutConstraint.activate([
            self.lateCountLabel.trailingAnchor.constraint(equalTo: self.lateView.trailingAnchor, constant: -20),
            self.lateCountLabel.bottomAnchor.constraint(equalTo: self.lateView.bottomAnchor, constant: -8),
        ])
        
        // complaintsView
        NSLayoutConstraint.activate([
            self.complaintsView.leadingAnchor.constraint(equalTo: self.lateView.trailingAnchor, constant: 12),
            self.complaintsView.topAnchor.constraint(equalTo: self.salaryBaseView.bottomAnchor, constant: 20),
            self.complaintsView.heightAnchor.constraint(equalToConstant: 80),
            self.complaintsView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 64) / 3)
        ])
        
        // complaintsTitleLabel
        NSLayoutConstraint.activate([
            self.complaintsTitleLabel.leadingAnchor.constraint(equalTo: self.complaintsView.leadingAnchor, constant: 12),
            self.complaintsTitleLabel.topAnchor.constraint(equalTo: self.complaintsView.topAnchor, constant: 8),
        ])
        
        // complaintsCountLabel
        NSLayoutConstraint.activate([
            self.complaintsCountLabel.trailingAnchor.constraint(equalTo: self.complaintsView.trailingAnchor, constant: -20),
            self.complaintsCountLabel.bottomAnchor.constraint(equalTo: self.complaintsView.bottomAnchor, constant: -8),
        ])
        
        // reasonsView
        NSLayoutConstraint.activate([
            self.reasonsView.leadingAnchor.constraint(equalTo: self.complaintsView.trailingAnchor, constant: 12),
            self.reasonsView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.reasonsView.topAnchor.constraint(equalTo: self.salaryBaseView.bottomAnchor, constant: 20),
            self.reasonsView.heightAnchor.constraint(equalToConstant: 80),
            self.reasonsView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 64) / 3),
        ])
        
        // reasonsTitleLabel
        NSLayoutConstraint.activate([
            self.reasonsTitleLabel.leadingAnchor.constraint(equalTo: self.reasonsView.leadingAnchor, constant: 12),
            self.reasonsTitleLabel.topAnchor.constraint(equalTo: self.reasonsView.topAnchor, constant: 8),
        ])
        
        // reasonsCountLabel
        NSLayoutConstraint.activate([
            self.reasonsCountLabel.trailingAnchor.constraint(equalTo: self.reasonsView.trailingAnchor, constant: -20),
            self.reasonsCountLabel.bottomAnchor.constraint(equalTo: self.reasonsView.bottomAnchor, constant: -8),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        
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
        
        let leftBarButtonItem = UIBarButtonItem(title: "마이", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 20, weight: .Bold),
            .foregroundColor: UIColor.white
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .useCustomImage("myCardImage").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        
    }
}

// MARK: - Extension for methods added
extension ProfileViewController {
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
}

// MARK: - Extension for selector methods
extension ProfileViewController {
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.loadMyInfoRequest { item in
            let vc = CardViewController(item: item)
            
            self.present(vc, animated: true)
        }
        
    }
    
    @objc func thisMonthSalaryButton(_ sender: UIButton) {
        
    }
    
    @objc func salaryListButton(_ sender: UIButton) {
        
    }
    
    @objc func lastMonthSalaryButton(_ sender: UIButton) {
        
    }
    
}
