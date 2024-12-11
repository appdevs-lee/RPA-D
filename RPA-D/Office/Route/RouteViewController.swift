//
//  RouteViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/11/24.
//

import UIKit

final class RouteViewController: UIViewController {
    
    lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var searchPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "노선 검색하고 숙지율 올리기"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(searchButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var routeKnowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var routeKnowTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "노선 숙지"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "\(SupportingMethods.shared.convertDate(intoString: Date())) 기준"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var circularProgress: CircularProgress = {
        let view = CircularProgress()
        view.backgroundColor = .clear
        view.progressLineWidth = 12
        view.progressLineColor = .useRGB(red: 223, green: 52, blue: 52)
        view.trackLineWidth = 12
        view.trackColor = .useRGB(red: 219, green: 219, blue: 219)
        view.setProgress(value: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var countStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.rateLabel, self.routeKnowCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "50%"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var routeKnowCountLabel: UILabel = {
        let label = UILabel()
        label.text = "25/50"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        print("----------------------------------- RouteViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RouteViewController: EssentialViewMethods {
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
            self.searchView,
            self.searchPlaceholderLabel,
            self.searchButton,
            self.baseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.routeKnowView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.routeKnowTitleLabel,
            self.dateLabel,
            self.circularProgress,
            self.countStackView,
        ], to: self.routeKnowView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // searchView
        NSLayoutConstraint.activate([
            self.searchView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.searchView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.searchView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            self.searchView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // searchPlaceholderLabel
        NSLayoutConstraint.activate([
            self.searchPlaceholderLabel.leadingAnchor.constraint(equalTo: self.searchView.leadingAnchor, constant: 16),
            self.searchPlaceholderLabel.trailingAnchor.constraint(equalTo: self.searchView.trailingAnchor, constant: -16),
            self.searchPlaceholderLabel.topAnchor.constraint(equalTo: self.searchView.topAnchor, constant: 14),
            self.searchPlaceholderLabel.bottomAnchor.constraint(equalTo: self.searchView.bottomAnchor, constant: -14),
        ])
        
        // searchButton
        NSLayoutConstraint.activate([
            self.searchButton.leadingAnchor.constraint(equalTo: self.searchView.leadingAnchor),
            self.searchButton.trailingAnchor.constraint(equalTo: self.searchView.trailingAnchor),
            self.searchButton.topAnchor.constraint(equalTo: self.searchView.topAnchor),
            self.searchButton.bottomAnchor.constraint(equalTo: self.searchView.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.searchView.bottomAnchor, constant: 24),
            self.baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // routeKnowView
        NSLayoutConstraint.activate([
            self.routeKnowView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.routeKnowView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.routeKnowView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 24),
        ])
        
        // routeKnowTitleLabel
        NSLayoutConstraint.activate([
            self.routeKnowTitleLabel.leadingAnchor.constraint(equalTo: self.routeKnowView.leadingAnchor, constant: 20),
            self.routeKnowTitleLabel.topAnchor.constraint(equalTo: self.routeKnowView.topAnchor, constant: 31),
        ])
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.routeKnowView.leadingAnchor, constant: 20),
            self.dateLabel.topAnchor.constraint(equalTo: self.routeKnowTitleLabel.bottomAnchor, constant: 4),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.routeKnowView.bottomAnchor, constant: -31),
        ])
        
        // circularProgress
        NSLayoutConstraint.activate([
            self.circularProgress.trailingAnchor.constraint(equalTo: self.routeKnowView.trailingAnchor, constant: -20),
            self.circularProgress.centerYAnchor.constraint(equalTo: self.routeKnowView.centerYAnchor),
            self.circularProgress.widthAnchor.constraint(equalToConstant: 90),
            self.circularProgress.heightAnchor.constraint(equalToConstant: 90),
        ])
        
        // countStackView
        NSLayoutConstraint.activate([
            self.countStackView.centerYAnchor.constraint(equalTo: self.circularProgress.centerYAnchor),
            self.countStackView.centerXAnchor.constraint(equalTo: self.circularProgress.centerXAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "노선"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton.white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}

// MARK: - Extension for methods added
extension RouteViewController {
    
}

// MARK: - Extension for selector methods
extension RouteViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func searchButton(_ sender: UIButton) {
        
    }
    
}
