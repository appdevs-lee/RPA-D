//
//  GoToWorkTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 11/19/24.
//

import UIKit

final class GoToWorkTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 일정"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchCountLabel: UILabel = {
        let label = UILabel()
        label.text = "지정된 배차 건수 : 3건"
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var goToWorkStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.goToWorkTitleBaseView, self.goToWorkContentBaseView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var goToWorkTitleBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var goToWorkTitleLabelButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("출근", for: .normal)
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
    
    lazy var goToWorkTitleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goToWorkTitleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var goToWorkContentBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var wakeWorkView: HourlyWorkView = {
        let view = HourlyWorkView()
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
extension GoToWorkTableViewCell {
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
            self.titleLabel,
            self.dispatchCountLabel,
            self.goToWorkStackView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.goToWorkTitleLabelButton,
            self.foldAndOpenButton,
            self.goToWorkTitleButton,
        ], to: self.goToWorkTitleBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.separateView,
        ], to: self.goToWorkContentBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 46),
        ])
        
        // dispatchCountLabel
        NSLayoutConstraint.activate([
            self.dispatchCountLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.dispatchCountLabel.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])
        
        // goToWorkStackView
        NSLayoutConstraint.activate([
            self.goToWorkStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.goToWorkStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.goToWorkStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
            self.goToWorkStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
        ])
        
        // goToWorkTitleButton
        NSLayoutConstraint.activate([
            self.goToWorkTitleButton.leadingAnchor.constraint(equalTo: self.goToWorkTitleBaseView.leadingAnchor),
            self.goToWorkTitleButton.trailingAnchor.constraint(equalTo: self.goToWorkTitleBaseView.trailingAnchor),
            self.goToWorkTitleButton.topAnchor.constraint(equalTo: self.goToWorkTitleBaseView.topAnchor),
            self.goToWorkTitleButton.bottomAnchor.constraint(equalTo: self.goToWorkTitleBaseView.bottomAnchor),
        ])
        
        // goToWorkTitleBaseView
        NSLayoutConstraint.activate([
            self.goToWorkTitleBaseView.heightAnchor.constraint(equalToConstant: 62),
        ])
        
        // goToWorkTitleLabelButton
        NSLayoutConstraint.activate([
            self.goToWorkTitleLabelButton.leadingAnchor.constraint(equalTo: self.goToWorkTitleBaseView.leadingAnchor, constant: 16),
            self.goToWorkTitleLabelButton.centerYAnchor.constraint(equalTo: self.goToWorkTitleBaseView.centerYAnchor),
            self.goToWorkTitleLabelButton.widthAnchor.constraint(equalToConstant: 50),
            self.goToWorkTitleLabelButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // foldAndOpenButton
        NSLayoutConstraint.activate([
            self.foldAndOpenButton.centerYAnchor.constraint(equalTo: self.goToWorkTitleBaseView.centerYAnchor),
            self.foldAndOpenButton.trailingAnchor.constraint(equalTo: self.goToWorkTitleBaseView.trailingAnchor, constant: -26),
            self.foldAndOpenButton.heightAnchor.constraint(equalToConstant: 24),
            self.foldAndOpenButton.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        // goToWorkContentBaseView
        NSLayoutConstraint.activate([
            self.goToWorkContentBaseView.heightAnchor.constraint(equalToConstant: 176),
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.goToWorkContentBaseView.leadingAnchor, constant: 16),
            self.separateView.trailingAnchor.constraint(equalTo: self.goToWorkContentBaseView.trailingAnchor, constant: -16),
            self.separateView.heightAnchor.constraint(equalToConstant: 1),
            self.separateView.topAnchor.constraint(equalTo: self.goToWorkContentBaseView.topAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension GoToWorkTableViewCell {
    func setCell() {
        
    }
}

// MARK: - Extension for methods added
extension GoToWorkTableViewCell {
    @objc func goToWorkTitleButton(_ sender: UIButton) {
        self.goToWorkContentBaseView.isHidden.toggle()
        NotificationCenter.default.post(name: Notification.Name("WorkReloadData"), object: nil)
        
        if self.goToWorkContentBaseView.isHidden == true {
            self.foldAndOpenButton.setImage(.useCustomImage("routine.down"), for: .normal)
            self.goToWorkTitleBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
        } else {
            self.foldAndOpenButton.setImage(.useCustomImage("routine.up"), for: .normal)
            self.goToWorkTitleBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        }
        
    }
    
}

