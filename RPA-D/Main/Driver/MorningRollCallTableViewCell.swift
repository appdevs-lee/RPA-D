//
//  MorningRollCallTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/4/24.
//

import UIKit

final class MorningRollCallTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var goodButton: UIButton = {
        let button = UIButton()
        button.setTitle("양호", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(goodButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var badButton: UIButton = {
        let button = UIButton()
        button.setTitle("이상", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(badButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var index: Int = 0
    
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
extension MorningRollCallTableViewCell {
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
            self.titleLabel,
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.goodButton,
            self.badButton,
        ], to: self.baseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.baseView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // goodButton
        NSLayoutConstraint.activate([
            self.goodButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 4),
            self.goodButton.trailingAnchor.constraint(equalTo: self.badButton.leadingAnchor, constant: -4),
            self.goodButton.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 4),
            self.goodButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -4),
        ])
        
        // badButton
        NSLayoutConstraint.activate([
            self.badButton.leadingAnchor.constraint(equalTo: self.goodButton.trailingAnchor, constant: 4),
            self.badButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -4),
            self.badButton.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 4),
            self.badButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -4),
            self.badButton.widthAnchor.constraint(equalTo: self.goodButton.widthAnchor, multiplier: 1.0)
        ])
    }
}

// MARK: - Extension for methods added
extension MorningRollCallTableViewCell {
    func setCell(rollCall: (title: String, status: Bool), index: Int) {
        self.index = index
        self.titleLabel.text = rollCall.title
        
        if rollCall.status {
            // 양호
            self.goodButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.goodButton.setTitleColor(.white, for: .normal)
            self.badButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.badButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        } else {
            // 이상
            self.goodButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.goodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            self.badButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.badButton.setTitleColor(.white, for: .normal)
            
        }
        
    }
}

// MARK: - Extension for selector added
extension MorningRollCallTableViewCell {
    @objc func goodButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("CheckRollCall"), object: nil, userInfo: ["status": true, "index": self.index])
    }
    
    @objc func badButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("CheckRollCall"), object: nil, userInfo: ["status": false, "index": self.index])
        
    }
}

