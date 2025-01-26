//
//  ProfileTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 1/26/25.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 241, green: 241, blue: 241).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("profile.next")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
extension ProfileTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.backgroundColor = .clear
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
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.iconImageView,
            self.titleLabel,
            self.arrowImageView,
        ], to: self.baseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
        ])
        
        // iconImageView
        NSLayoutConstraint.activate([
            self.iconImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.iconImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 16),
            self.iconImageView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -16),
            self.iconImageView.widthAnchor.constraint(equalToConstant: 20),
            self.iconImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 4),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.iconImageView.centerYAnchor),
        ])
        
        // arrowImageView
        NSLayoutConstraint.activate([
            self.arrowImageView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.arrowImageView.centerYAnchor.constraint(equalTo: self.iconImageView.centerYAnchor),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

// MARK: - Extension for methods added
extension ProfileTableViewCell {
    func setCell(menu: String, index: Int) {
        self.titleLabel.text = menu
        
        switch index {
        case 0:
            self.iconImageView.image = .useCustomImage("monthlyReport")
            
        case 1:
            self.iconImageView.image = .useCustomImage("appInfo")
            
        case 2:
            self.iconImageView.image = .useCustomImage("notification.setting")
            
        default: break
        }
        
    }
    
}
