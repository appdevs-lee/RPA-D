//
//  CardViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/11/24.
//

import UIKit

final class CardViewController: UIViewController {
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("dismissImage"), for: .normal)
        button.addTarget(self, action: #selector(dismissButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = User.shared.name
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.text = User.shared.position
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var callImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("card.call")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var callLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.item.phoneNum)"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("card.location")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "수원시 권선구 매송고색로 804번길 190"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.transitionButton, self.shareButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("shareImage"), for: .normal)
        button.addTarget(self, action: #selector(shareButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var transitionButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("transitionImage"), for: .normal)
        button.addTarget(self, action: #selector(transitionButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var eAddressImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("eAddressImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var companyLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.0
        imageView.image = .useCustomImage("company.logo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var companySiteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0.0
        imageView.image = .useCustomImage("company.site")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var item: MyInfoItem
    var isFront: Bool = true
    
    init(item: MyInfoItem) {
        self.item = item
        
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
        print("----------------------------------- CardViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CardViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.75)
        
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
            self.dismissButton,
            self.baseView,
            
            self.buttonStackView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.nameLabel,
            self.positionLabel,
            self.callImageView,
            self.callLabel,
            self.locationImageView,
            self.locationLabel,
            self.eAddressImageView,
            
            self.companyLogoImageView,
            self.companySiteImageView,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // dismissButton
        NSLayoutConstraint.activate([
            self.dismissButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.dismissButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            self.dismissButton.widthAnchor.constraint(equalToConstant: 24),
            self.dismissButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.dismissButton.bottomAnchor, constant: 100),
            self.baseView.heightAnchor.constraint(equalToConstant: 456)
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 36),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.positionLabel.topAnchor, constant: -4),
        ])
        
        // positionLabel
        NSLayoutConstraint.activate([
            self.positionLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 36),
            self.positionLabel.bottomAnchor.constraint(equalTo: self.callImageView.topAnchor, constant: -40),
        ])
        
        // callImageView
        NSLayoutConstraint.activate([
            self.callImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 36),
            self.callImageView.bottomAnchor.constraint(equalTo: self.locationImageView.topAnchor, constant: -8),
            self.callImageView.heightAnchor.constraint(equalToConstant: 16),
            self.callImageView.widthAnchor.constraint(equalToConstant: 16),
        ])
        
        // callLabel
        NSLayoutConstraint.activate([
            self.callLabel.leadingAnchor.constraint(equalTo: self.callImageView.trailingAnchor, constant: 4),
            self.callLabel.centerYAnchor.constraint(equalTo: self.callImageView.centerYAnchor),
        ])
        
        // locationImageView
        NSLayoutConstraint.activate([
            self.locationImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 36),
            self.locationImageView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -42),
            self.locationImageView.heightAnchor.constraint(equalToConstant: 16),
            self.locationImageView.widthAnchor.constraint(equalToConstant: 16),
        ])
        
        // locationLabel
        NSLayoutConstraint.activate([
            self.locationLabel.leadingAnchor.constraint(equalTo: self.locationImageView.trailingAnchor, constant: 4),
            self.locationLabel.centerYAnchor.constraint(equalTo: self.locationImageView.centerYAnchor),
        ])
        
        // eAddressLabel
        NSLayoutConstraint.activate([
            self.eAddressImageView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -25),
            self.eAddressImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 58),
        ])
        
        // buttonStackView
        NSLayoutConstraint.activate([
            self.buttonStackView.topAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: 27),
            self.buttonStackView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
        ])
        
        // shareButton
        NSLayoutConstraint.activate([
            self.shareButton.widthAnchor.constraint(equalToConstant: 28),
            self.shareButton.heightAnchor.constraint(equalToConstant: 28),
        ])
        
        // transitionButton
        NSLayoutConstraint.activate([
            self.transitionButton.widthAnchor.constraint(equalToConstant: 28),
            self.transitionButton.heightAnchor.constraint(equalToConstant: 28),
        ])
        
        // companyLogoImageView
        NSLayoutConstraint.activate([
            self.companyLogoImageView.widthAnchor.constraint(equalToConstant: 176),
            self.companyLogoImageView.heightAnchor.constraint(equalToConstant: 60),
            self.companyLogoImageView.bottomAnchor.constraint(equalTo: self.companySiteImageView.topAnchor, constant: -8),
            self.companyLogoImageView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
        ])
        
        // companySiteImageView
        NSLayoutConstraint.activate([
            self.companySiteImageView.widthAnchor.constraint(equalToConstant: 139),
            self.companySiteImageView.heightAnchor.constraint(equalToConstant: 16),
            self.companySiteImageView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -51),
            self.companySiteImageView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension CardViewController {
    
}

// MARK: - Extension for selector methods
extension CardViewController {
    @objc func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true)
        
    }
    
    @objc func shareButton(_ sender: UIButton) {
        if !self.isFront {
            UIView.transition(with: self.baseView, duration: 1.0, options: .transitionFlipFromLeft) {
                self.baseView.backgroundColor = .white
                
                self.nameLabel.alpha = 1.0
                self.positionLabel.alpha = 1.0
                self.callImageView.alpha = 1.0
                self.callLabel.alpha = 1.0
                self.locationImageView.alpha = 1.0
                self.locationLabel.alpha = 1.0
                self.eAddressImageView.alpha = 1.0
                
                self.companyLogoImageView.alpha = 0.0
                self.companySiteImageView.alpha = 0.0
                
            }
            
            self.isFront = true
            
        }
        
        SupportingMethods.shared.turnCoverView(.on)
        guard let image = self.baseView.transfromToImage() else {
            SupportingMethods.shared.turnCoverView(.off)
            return
            
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        vc.excludedActivityTypes = [.saveToCameraRoll]
        
        self.present(vc, animated: true) {
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        
    }
    
    @objc func transitionButton(_ sender: UIButton) {
        if self.isFront {
            UIView.transition(with: self.baseView, duration: 1.0, options: .transitionFlipFromLeft) {
                self.baseView.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
                
                self.nameLabel.alpha = 0.0
                self.positionLabel.alpha = 0.0
                self.callImageView.alpha = 0.0
                self.callLabel.alpha = 0.0
                self.locationImageView.alpha = 0.0
                self.locationLabel.alpha = 0.0
                self.eAddressImageView.alpha = 0.0
                
                self.companyLogoImageView.alpha = 1.0
                self.companySiteImageView.alpha = 1.0
                
            }
            
            self.isFront = false
            
        } else {
            UIView.transition(with: self.baseView, duration: 1.0, options: .transitionFlipFromLeft) {
                self.baseView.backgroundColor = .white
                
                self.nameLabel.alpha = 1.0
                self.positionLabel.alpha = 1.0
                self.callImageView.alpha = 1.0
                self.callLabel.alpha = 1.0
                self.locationImageView.alpha = 1.0
                self.locationLabel.alpha = 1.0
                self.eAddressImageView.alpha = 1.0
                
                self.companyLogoImageView.alpha = 0.0
                self.companySiteImageView.alpha = 0.0
                
            }
            
            self.isFront = true
            
        }
    }
    
}
