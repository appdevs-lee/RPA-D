//
//  ProblemBasicInfoTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/17/24.
//

import UIKit

final class ProblemBasicInfoTableViewCell: UITableViewCell {
    
    lazy var driverNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var etcLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var callBaseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.useRGB(red: 219, green: 219, blue: 219).cgColor
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var callContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.callImageView, self.callLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var callImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("callImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var callLabel: UILabel = {
        let label = UILabel()
        label.text = "전화 걸기"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var callButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(callButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 249, green: 249, blue: 249)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var phoneNumber: String = ""
    
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
extension ProblemBasicInfoTableViewCell {
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
            self.driverNameLabel,
            self.etcLabel,
            self.callBaseView,
            self.borderView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.callContentStackView,
            self.callButton,
        ], to: self.callBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // routeLabel
        NSLayoutConstraint.activate([
            self.driverNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.driverNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            self.driverNameLabel.heightAnchor.constraint(equalToConstant: 28),
        ])
        
        // groupLabel
        NSLayoutConstraint.activate([
            self.etcLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.etcLabel.centerYAnchor.constraint(equalTo: self.driverNameLabel.centerYAnchor),
        ])
        
        // callBaseView
        NSLayoutConstraint.activate([
            self.callBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.callBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.callBaseView.topAnchor.constraint(equalTo: self.driverNameLabel.bottomAnchor, constant: 18),
            self.callBaseView.bottomAnchor.constraint(equalTo: self.borderView.topAnchor, constant: -24),
            self.callBaseView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // callContentStackView
        NSLayoutConstraint.activate([
            self.callContentStackView.centerYAnchor.constraint(equalTo: self.callBaseView.centerYAnchor),
            self.callContentStackView.centerXAnchor.constraint(equalTo: self.callBaseView.centerXAnchor),
        ])
        
        // callImageView
        NSLayoutConstraint.activate([
            self.callImageView.widthAnchor.constraint(equalToConstant: 20),
            self.callImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // callButton
        NSLayoutConstraint.activate([
            self.callButton.leadingAnchor.constraint(equalTo: self.callBaseView.leadingAnchor),
            self.callButton.trailingAnchor.constraint(equalTo: self.callBaseView.trailingAnchor),
            self.callButton.topAnchor.constraint(equalTo: self.callBaseView.topAnchor),
            self.callButton.bottomAnchor.constraint(equalTo: self.callBaseView.bottomAnchor),
        ])
        
        // borderView
        NSLayoutConstraint.activate([
            self.borderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.borderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.borderView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
    }
}

// MARK: - Extension for methods added
extension ProblemBasicInfoTableViewCell {
    func setCell(item: ProblemDetailItem) {
        self.phoneNumber = item.driverPhone
        
        self.driverNameLabel.text = item.driverName
        self.etcLabel.text = "\(item.group) | \(item.busNum)"
        
    }
    
}

// MARK: - Extension for selector added
extension ProblemBasicInfoTableViewCell {
    @objc func callButton(_ sender: UIButton) {
        if let url = URL(string: "tel://\(self.phoneNumber)") {
            UIApplication.shared.open(url)
            
        }
        
    }
    
}
