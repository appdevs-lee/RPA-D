//
//  DailyInspectionTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/6/24.
//

import UIKit

final class DailyInspectionTableViewCell: UITableViewCell {
    
    lazy var baseStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleBaseView, self.buttonBaseView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var titleBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("status.todo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var buttonBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var buttonTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var inspectionWayButton: UIButton = {
        let button = UIButton()
        button.setTitle("점검 방법", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var goodButton: UIButton = {
        let button = UIButton()
        button.setTitle("양호", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(goodButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var badButton: UIButton = {
        let button = UIButton()
        button.setTitle("이상", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(badButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var index: Int = 0
    var inspection: Inspection?
    
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
extension DailyInspectionTableViewCell {
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
            self.baseStackView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.statusButton,
        ], to: self.titleBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.buttonTitleLabel,
            self.inspectionWayButton,
            self.goodButton,
            self.badButton,
        ], to: self.buttonBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseStackView
        NSLayoutConstraint.activate([
            self.baseStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.baseStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.baseStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.titleBaseView.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.titleBaseView.topAnchor, constant: 10),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.titleBaseView.bottomAnchor, constant: -10),
        ])
        
        // statusButton
        NSLayoutConstraint.activate([
            self.statusButton.trailingAnchor.constraint(equalTo: self.titleBaseView.trailingAnchor, constant: -20),
            self.statusButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.statusButton.heightAnchor.constraint(equalToConstant: 24),
            self.statusButton.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        // buttonTitleLabel
        NSLayoutConstraint.activate([
            self.buttonTitleLabel.leadingAnchor.constraint(equalTo: self.buttonBaseView.leadingAnchor, constant: 12),
            self.buttonTitleLabel.topAnchor.constraint(equalTo: self.buttonBaseView.topAnchor, constant: 12),
        ])
        
        // inspectionWayButton
        NSLayoutConstraint.activate([
            self.inspectionWayButton.trailingAnchor.constraint(equalTo: self.buttonBaseView.trailingAnchor, constant: -12),
            self.inspectionWayButton.centerYAnchor.constraint(equalTo: self.buttonTitleLabel.centerYAnchor),
        ])
        
        // goodButton
        NSLayoutConstraint.activate([
            self.goodButton.leadingAnchor.constraint(equalTo: self.buttonBaseView.leadingAnchor, constant: 12),
            self.goodButton.topAnchor.constraint(equalTo: self.buttonTitleLabel.bottomAnchor, constant: 8),
            self.goodButton.trailingAnchor.constraint(equalTo: self.badButton.leadingAnchor, constant: -8),
            self.goodButton.bottomAnchor.constraint(equalTo: self.buttonBaseView.bottomAnchor, constant: -12),
            self.goodButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // badButton
        NSLayoutConstraint.activate([
            self.badButton.topAnchor.constraint(equalTo: self.goodButton.topAnchor),
            self.badButton.bottomAnchor.constraint(equalTo: self.goodButton.bottomAnchor),
            self.badButton.trailingAnchor.constraint(equalTo: self.buttonBaseView.trailingAnchor, constant: -12),
            self.badButton.widthAnchor.constraint(equalTo: self.goodButton.widthAnchor, multiplier: 1.0),
            self.badButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
    }
}

// MARK: - Extension for methods added
extension DailyInspectionTableViewCell {
    func setCell(inspection: Inspection, index: Int) {
        self.index = index
        self.inspection = inspection
        
        self.titleLabel.text = inspection.title
        self.buttonTitleLabel.text = inspection.title
        
        self.statusButton.setImage(.useCustomImage(inspection.status == nil ? "status.todo" : inspection.status! ? "status.done.good" : "status.done.bad"), for: .normal)
        
        guard let status = inspection.status else {
            self.goodButton.backgroundColor = .white
            self.goodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
            self.badButton.backgroundColor = .white
            self.badButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            return
        }
        if status {
            // 양호 선택
            self.goodButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.goodButton.setTitleColor(.white, for: .normal)
            
            self.badButton.backgroundColor = .white
            self.badButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        } else {
            // 이상 선택
            self.badButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.badButton.setTitleColor(.white, for: .normal)
            
            self.goodButton.backgroundColor = .white
            self.goodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        }
        
    }
    
}

// MARK: - Extension for methods added
extension DailyInspectionTableViewCell {
    @objc func goodButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("InspectionReloadData"), object: nil, userInfo: ["status": true, "index": self.index])
        
    }
    
    @objc func badButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("InspectionReloadData"), object: nil, userInfo: ["status": false, "index": self.index])
        
    }
}

