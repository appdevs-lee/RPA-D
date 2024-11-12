//
//  GetUpCheckViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 11/12/24.
//

import UIKit

final class GetUpCheckViewController: UIViewController {
    
    lazy var timerBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("TimerBackground")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "30:00"
        label.textColor = .white
        label.font = .useFont(ofSize: 60, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기상 버튼을 눌러주세요"
        label.textColor = .white
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "기상 버튼을 클릭해야 기상 시간이 기록됩니다"
        label.textColor = .useRGB(red: 196, green: 195, blue: 195)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var getUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("기상", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 20, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 38
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        print("----------------------------------- GetUpCheckViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension GetUpCheckViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .black
        
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
            self.timerBackgroundImageView,
            self.timerLabel,
            self.titleLabel,
            self.contentLabel,
            self.getUpButton,
        ], to: self.view)
        
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // timerBackgroundImageView
        NSLayoutConstraint.activate([
            self.timerBackgroundImageView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width),
            self.timerBackgroundImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.timerBackgroundImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.timerBackgroundImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 108),
        ])
        
        // timerLabel
        NSLayoutConstraint.activate([
            self.timerLabel.centerXAnchor.constraint(equalTo: self.timerBackgroundImageView.centerXAnchor),
            self.timerLabel.centerYAnchor.constraint(equalTo: self.timerBackgroundImageView.centerYAnchor),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 72),
            self.titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -72),
            self.titleLabel.topAnchor.constraint(equalTo: self.timerBackgroundImageView.bottomAnchor, constant: -35),
        ])
        
        // contentLabel
        NSLayoutConstraint.activate([
            self.contentLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            self.contentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40),
            self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8)
        ])
        
        // getUpButton
        NSLayoutConstraint.activate([
            self.getUpButton.heightAnchor.constraint(equalToConstant: 76),
            self.getUpButton.widthAnchor.constraint(equalToConstant: 76),
            self.getUpButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.getUpButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension GetUpCheckViewController {
    
}

// MARK: - Extension for selector methods
extension GetUpCheckViewController {
    
}

