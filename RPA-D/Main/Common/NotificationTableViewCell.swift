//
//  NotificationTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/10/24.
//

import UIKit

final class NotificationTableViewCell: UITableViewCell {
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.contentLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var newView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        view.layer.cornerRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitleColor(.useRGB(red: 101, green: 100, blue: 100), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 11, weight: .Medium)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 241, green: 241, blue: 241)
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
extension NotificationTableViewCell {
    // Set view foundation
    func setCellFoundation() {
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
            self.labelStackView,
            self.newView,
            self.categoryButton,
            self.timeLabel,
            self.bottomView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.labelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.labelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
        ])
        
        // newView
        NSLayoutConstraint.activate([
            self.newView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 2),
            self.newView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            self.newView.heightAnchor.constraint(equalToConstant: 6),
            self.newView.widthAnchor.constraint(equalToConstant: 6),
        ])
        
        // categoryButton
        NSLayoutConstraint.activate([
            self.categoryButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.categoryButton.topAnchor.constraint(equalTo: self.labelStackView.bottomAnchor, constant: 4),
            self.categoryButton.widthAnchor.constraint(equalToConstant: 37),
            self.categoryButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.timeLabel.centerYAnchor.constraint(equalTo: self.categoryButton.centerYAnchor),
        ])
        
        // bottomView
        NSLayoutConstraint.activate([
            self.bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomView.topAnchor.constraint(equalTo: self.categoryButton.bottomAnchor, constant: 16),
            self.bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

// MARK: - Extension for methods added
extension NotificationTableViewCell {
    func setCell(notification: NotificationDetailItem) {
        self.titleLabel.text = notification.title
        self.contentLabel.text = notification.content
        self.categoryButton.setTitle(notification.category, for: .normal)
        
        let date = SupportingMethods.shared.convertString(intoDate: notification.date, "yyyy-MM-dd HH:mm:ss")
        self.timeLabel.text = SupportingMethods.shared.calculatePassedTime(date)
        
        if notification.isRead {
            self.newView.isHidden = true
            
        } else {
            self.newView.isHidden = false
            
        }
        
    }
}

