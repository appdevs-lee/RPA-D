//
//  PhoneBookListTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/11/24.
//

import UIKit

final class PhoneBookListTableViewCell: UITableViewCell {
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage(self.profileImageNameList[Int.random(in: 0..<4)])
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var phoneNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var callImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("call.arrow")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var profileImageNameList: [String] = ["profile.pink", "profile.yellow", "profile.purple", "profile.blue"]
    
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
extension PhoneBookListTableViewCell {
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
            self.profileImageView,
            self.nameLabel,
            self.phoneNumLabel,
            self.callImageView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // profileImageView
        NSLayoutConstraint.activate([
            self.profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 40),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 8),
            self.nameLabel.topAnchor.constraint(equalTo: self.profileImageView.topAnchor),
        ])
        
        // phoneNumLabel
        NSLayoutConstraint.activate([
            self.phoneNumLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 8),
            self.phoneNumLabel.bottomAnchor.constraint(equalTo: self.profileImageView.bottomAnchor),
        ])
        
        // callImageView
        NSLayoutConstraint.activate([
            self.callImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.callImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.callImageView.widthAnchor.constraint(equalToConstant: 24),
            self.callImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}

// MARK: - Extension for methods added
extension PhoneBookListTableViewCell {
    func setCell(member: MemberDetailItem) {
        self.nameLabel.text = member.name
        self.phoneNumLabel.text = member.phoneNum
        
    }
    
}

