//
//  PermissionTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 11/10/24.
//

import UIKit

final class PermissionTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 233, green: 233, blue: 233, alpha: 0.5)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var permissionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 49, green: 49, blue: 49)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 94, green: 94, blue: 94)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
extension PermissionTableViewCell {
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
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.permissionImageView,
            self.titleStackView,
        ], to: self.baseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 9),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -9),
        ])
        
        // permissionImageView
        NSLayoutConstraint.activate([
            self.permissionImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.permissionImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 18),
            self.permissionImageView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -18),
            self.permissionImageView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 40) * 44 / 353),
            self.permissionImageView.heightAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 40) * 44 / 353),
        ])
        
        // titleStackView
        NSLayoutConstraint.activate([
            self.titleStackView.leadingAnchor.constraint(equalTo: self.permissionImageView.trailingAnchor, constant: 20),
            self.titleStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            self.titleStackView.centerYAnchor.constraint(equalTo: self.permissionImageView.centerYAnchor),
        ])
        
    }
}

// MARK: - Extension for methods added
extension PermissionTableViewCell {
    func setCell(permission: Permission) {
        self.permissionImageView.image = .useCustomImage(permission.name)
        
        self.titleLabel.text = permission.title
        self.subTitleLabel.text = permission.subTitle
        
        self.titleLabel.asFontColor(targetString: "[필수]", font: .useFont(ofSize: 14, weight: .Medium), color: .useRGB(red: 223, green: 52, blue: 52))
        
    }
}
