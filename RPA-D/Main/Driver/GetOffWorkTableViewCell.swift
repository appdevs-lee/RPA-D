//
//  GetOffWorkTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 11/19/24.
//

import UIKit

final class GetOffWorkTableViewCell: UITableViewCell {
    
    lazy var getOffWorkStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.getOffWorkTitleBaseView, self.getOffWorkContentBaseView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var getOffWorkTitleBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var getOffWorkTitleLabelButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("퇴근", for: .normal)
        button.setTitleColor(.useRGB(red: 25, green: 98, blue: 255), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.backgroundColor = .useRGB(red: 233, green: 240, blue: 255)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var foldAndOpenButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("routine.down"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var getOffWorkTitleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(getOffWorkTitleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var getOffWorkContentBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 237, green: 237, blue: 237)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setCellFoundation()
        self.initializeViews()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// MARK: Extension for essential methods
extension GetOffWorkTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
    }
    
    // Initialize views
    func initializeViews() {
        
    }
    
    // Set gestures
    func setGestures() {
        
    }
    
    // Set notificationCenters
    func setNotificationCenters() {
        
    }
    
    // Set subviews
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.getOffWorkStackView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.getOffWorkTitleLabelButton,
            self.foldAndOpenButton,
            self.getOffWorkTitleButton,
        ], to: self.getOffWorkTitleBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.separateView,
        ], to: self.getOffWorkContentBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // getOffWorkStackView
        NSLayoutConstraint.activate([
            self.getOffWorkStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.getOffWorkStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.getOffWorkStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            self.getOffWorkStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -53),
        ])
        
        // getOffWorkTitleButton
        NSLayoutConstraint.activate([
            self.getOffWorkTitleButton.leadingAnchor.constraint(equalTo: self.getOffWorkTitleBaseView.leadingAnchor),
            self.getOffWorkTitleButton.trailingAnchor.constraint(equalTo: self.getOffWorkTitleBaseView.trailingAnchor),
            self.getOffWorkTitleButton.topAnchor.constraint(equalTo: self.getOffWorkTitleBaseView.topAnchor),
            self.getOffWorkTitleButton.bottomAnchor.constraint(equalTo: self.getOffWorkTitleBaseView.bottomAnchor),
        ])
        
        // goToWorkTitleBaseView
        NSLayoutConstraint.activate([
            self.getOffWorkTitleBaseView.heightAnchor.constraint(equalToConstant: 62),
        ])
        
        // getOffWorkTitleLabelButton
        NSLayoutConstraint.activate([
            self.getOffWorkTitleLabelButton.leadingAnchor.constraint(equalTo: self.getOffWorkTitleBaseView.leadingAnchor, constant: 16),
            self.getOffWorkTitleLabelButton.centerYAnchor.constraint(equalTo: self.getOffWorkTitleBaseView.centerYAnchor),
            self.getOffWorkTitleLabelButton.widthAnchor.constraint(equalToConstant: 50),
            self.getOffWorkTitleLabelButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // foldAndOpenButton
        NSLayoutConstraint.activate([
            self.foldAndOpenButton.centerYAnchor.constraint(equalTo: self.getOffWorkTitleBaseView.centerYAnchor),
            self.foldAndOpenButton.trailingAnchor.constraint(equalTo: self.getOffWorkTitleBaseView.trailingAnchor, constant: -26),
            self.foldAndOpenButton.heightAnchor.constraint(equalToConstant: 24),
            self.foldAndOpenButton.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        // goToWorkContentBaseView
        NSLayoutConstraint.activate([
            self.getOffWorkContentBaseView.heightAnchor.constraint(equalToConstant: 294),
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.getOffWorkContentBaseView.leadingAnchor, constant: 16),
            self.separateView.trailingAnchor.constraint(equalTo: self.getOffWorkContentBaseView.trailingAnchor, constant: -16),
            self.separateView.heightAnchor.constraint(equalToConstant: 1),
            self.separateView.topAnchor.constraint(equalTo: self.getOffWorkContentBaseView.topAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension GetOffWorkTableViewCell {
    func setCell() {
        if self.getOffWorkContentBaseView.isHidden == true {
            self.foldAndOpenButton.setImage(.useCustomImage("routine.down"), for: .normal)
            self.getOffWorkTitleBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
        } else {
            self.foldAndOpenButton.setImage(.useCustomImage("routine.up"), for: .normal)
            self.getOffWorkTitleBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        }
        
    }
}

// MARK: - Extension for methods added
extension GetOffWorkTableViewCell {
    @objc func getOffWorkTitleButton(_ sender: UIButton) {
        self.getOffWorkContentBaseView.isHidden.toggle()
        NotificationCenter.default.post(name: Notification.Name("WorkReloadData"), object: nil)
        
    }
    
}

