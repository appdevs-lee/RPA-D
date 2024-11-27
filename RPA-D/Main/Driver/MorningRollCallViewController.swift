//
//  MorningRollCallViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 11/27/24.
//

import UIKit

final class MorningRollCallViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아침 점호를 진행해 주세요"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "점검지 제출 시간이 출근 시간으로 기록됩니다."
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "점호지 도착시간"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = SupportingMethods.shared.convertDate(intoString: Date(), "a HH:mm")
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
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
        print("----------------------------------- MorningRollCallViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension MorningRollCallViewController: EssentialViewMethods {
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
            self.arrivalTimeTitleLabel,
            self.arrivalTimeBaseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.arrivalTimeLabel,
        ], to: self.arrivalTimeBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 52),
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
        ])
        
        // arrivalTimeTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.arrivalTimeTitleLabel.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 24),
        ])
        
        // arrivalTimeBaseView
        NSLayoutConstraint.activate([
            self.arrivalTimeBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.arrivalTimeBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.arrivalTimeBaseView.bottomAnchor.constraint(equalTo: self.arrivalTimeTitleLabel.bottomAnchor, constant: 8),
            self.arrivalTimeBaseView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalTimeBaseView.leadingAnchor, constant: 12),
            self.arrivalTimeLabel.centerYAnchor.constraint(equalTo: self.arrivalTimeBaseView.centerYAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension MorningRollCallViewController {
    
}

// MARK: - Extension for selector methods
extension MorningRollCallViewController {
    
}

