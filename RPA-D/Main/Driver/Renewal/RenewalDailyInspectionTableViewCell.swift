//
//  RenewalDailyInspectionTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 1/21/25.
//

import UIKit

final class RenewalDailyInspectionTableViewCell: UITableViewCell {
    
    lazy var allStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleBaseView, self.mainStackView])
        stackView.axis = .vertical
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
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.mainTitleLabel, self.contentBaseView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.topBaseView, self.middleBaseView, self.bottomBaseView])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var topBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var topContentTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var topGoodButton: UIButton = {
        let button = UIButton()
        button.setTitle("양호", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(topGoodButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var topBadButton: UIButton = {
        let button = UIButton()
        button.setTitle("이상", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(topBadButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var middleBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var middleContentTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var middleGoodButton: UIButton = {
        let button = UIButton()
        button.setTitle("양호", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(middleGoodButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var middleBadButton: UIButton = {
        let button = UIButton()
        button.setTitle("이상", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(middleBadButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var bottomBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var bottomContentTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomGoodButton: UIButton = {
        let button = UIButton()
        button.setTitle("양호", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(bottomGoodButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var bottomBadButton: UIButton = {
        let button = UIButton()
        button.setTitle("이상", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(bottomBadButton(_:)), for: .touchUpInside)
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
extension RenewalDailyInspectionTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.backgroundColor = .white
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
            self.allStackView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.statusButton,
        ], to: self.titleBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.contentStackView,
        ], to: self.contentBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.topContentTitleLabel,
            self.topGoodButton,
            self.topBadButton,
        ], to: self.topBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.middleContentTitleLabel,
            self.middleGoodButton,
            self.middleBadButton,
        ], to: self.middleBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.bottomContentTitleLabel,
            self.bottomGoodButton,
            self.bottomBadButton,
        ], to: self.bottomBaseView)
    }
    
    // Set layouts
    func setLayouts() {
//        let safeArea = self.safeAreaLayoutGuide
        
        // mainStackView
        NSLayoutConstraint.activate([
            self.allStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.allStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.allStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.allStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // titleBaseView
        NSLayoutConstraint.activate([
            self.titleBaseView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.titleBaseView.leadingAnchor, constant: 20),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.titleBaseView.centerYAnchor),
        ])
        
        // statusButton
        NSLayoutConstraint.activate([
            self.statusButton.trailingAnchor.constraint(equalTo: self.titleBaseView.trailingAnchor, constant: -20),
            self.statusButton.widthAnchor.constraint(equalToConstant: 24),
            self.statusButton.heightAnchor.constraint(equalToConstant: 24),
            self.statusButton.centerYAnchor.constraint(equalTo: self.titleBaseView.centerYAnchor),
        ])
        
        // contentStackView
        NSLayoutConstraint.activate([
            self.contentStackView.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor, constant: 12),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor, constant: -12),
            self.contentStackView.topAnchor.constraint(equalTo: self.contentBaseView.topAnchor, constant: 12),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.contentBaseView.bottomAnchor, constant: -12),
        ])
        
        // topContentTitleLabel
        NSLayoutConstraint.activate([
            self.topContentTitleLabel.leadingAnchor.constraint(equalTo: self.topBaseView.leadingAnchor),
            self.topContentTitleLabel.topAnchor.constraint(equalTo: self.topBaseView.topAnchor),
        ])
        
        // topGoodButton
        NSLayoutConstraint.activate([
            self.topGoodButton.leadingAnchor.constraint(equalTo: self.topBaseView.leadingAnchor),
            self.topGoodButton.topAnchor.constraint(equalTo: self.topContentTitleLabel.bottomAnchor, constant: 8),
            self.topGoodButton.bottomAnchor.constraint(equalTo: self.topBaseView.bottomAnchor),
            self.topGoodButton.heightAnchor.constraint(equalToConstant: 48),
            self.topGoodButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 72) / 2.0)
        ])
        
        // topBadButton
        NSLayoutConstraint.activate([
            self.topBadButton.leadingAnchor.constraint(equalTo: self.topGoodButton.trailingAnchor, constant: 8),
            self.topBadButton.topAnchor.constraint(equalTo: self.topContentTitleLabel.bottomAnchor, constant: 8),
            self.topBadButton.bottomAnchor.constraint(equalTo: self.topBaseView.bottomAnchor),
            self.topBadButton.heightAnchor.constraint(equalToConstant: 48),
            self.topBadButton.widthAnchor.constraint(equalTo: self.topGoodButton.widthAnchor, multiplier: 1.0)
        ])
        
        // middleContentTitleLabel
        NSLayoutConstraint.activate([
            self.middleContentTitleLabel.leadingAnchor.constraint(equalTo: self.middleBaseView.leadingAnchor),
            self.middleContentTitleLabel.topAnchor.constraint(equalTo: self.middleBaseView.topAnchor),
        ])
        
        // middleGoodButton
        NSLayoutConstraint.activate([
            self.middleGoodButton.leadingAnchor.constraint(equalTo: self.middleBaseView.leadingAnchor),
            self.middleGoodButton.topAnchor.constraint(equalTo: self.middleContentTitleLabel.bottomAnchor, constant: 8),
            self.middleGoodButton.bottomAnchor.constraint(equalTo: self.middleBaseView.bottomAnchor),
            self.middleGoodButton.heightAnchor.constraint(equalToConstant: 48),
            self.middleGoodButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 72) / 2.0)
        ])
        
        // middleBadButton
        NSLayoutConstraint.activate([
            self.middleBadButton.leadingAnchor.constraint(equalTo: self.middleGoodButton.trailingAnchor, constant: 8),
            self.middleBadButton.topAnchor.constraint(equalTo: self.middleContentTitleLabel.bottomAnchor, constant: 8),
            self.middleBadButton.bottomAnchor.constraint(equalTo: self.middleBaseView.bottomAnchor),
            self.middleBadButton.heightAnchor.constraint(equalToConstant: 48),
            self.middleBadButton.widthAnchor.constraint(equalTo: self.middleGoodButton.widthAnchor, multiplier: 1.0)
        ])
        
        // bottomContentTitleLabel
        NSLayoutConstraint.activate([
            self.bottomContentTitleLabel.leadingAnchor.constraint(equalTo: self.bottomBaseView.leadingAnchor),
            self.bottomContentTitleLabel.topAnchor.constraint(equalTo: self.bottomBaseView.topAnchor),
        ])
        
        // bottomGoodButton
        NSLayoutConstraint.activate([
            self.bottomGoodButton.leadingAnchor.constraint(equalTo: self.bottomBaseView.leadingAnchor),
            self.bottomGoodButton.topAnchor.constraint(equalTo: self.bottomContentTitleLabel.bottomAnchor, constant: 8),
            self.bottomGoodButton.bottomAnchor.constraint(equalTo: self.bottomBaseView.bottomAnchor),
            self.bottomGoodButton.heightAnchor.constraint(equalToConstant: 48),
            self.bottomGoodButton.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 72) / 2.0)
        ])
        
        // bottomBadButton
        NSLayoutConstraint.activate([
            self.bottomBadButton.leadingAnchor.constraint(equalTo: self.bottomGoodButton.trailingAnchor, constant: 8),
            self.bottomBadButton.topAnchor.constraint(equalTo: self.bottomContentTitleLabel.bottomAnchor, constant: 8),
            self.bottomBadButton.bottomAnchor.constraint(equalTo: self.bottomBaseView.bottomAnchor),
            self.bottomBadButton.heightAnchor.constraint(equalToConstant: 48),
            self.bottomBadButton.widthAnchor.constraint(equalTo: self.bottomGoodButton.widthAnchor, multiplier: 1.0)
        ])
    }
}

// MARK: - Extension for methods added
extension RenewalDailyInspectionTableViewCell {
    func setCell(inspection: VehicleInspection, index: Int) {
        self.index = index
        
        self.titleLabel.text = inspection.title
        self.mainTitleLabel.text = inspection.title
        
        switch inspection.contents.count {
        case 1:
            self.topBaseView.isHidden = false
            self.middleBaseView.isHidden = true
            self.bottomBaseView.isHidden = true
            
            self.mainTitleLabel.isHidden = true
            self.topContentTitleLabel.text = inspection.contents[0].title
            self.topContentTitleLabel.font = .useFont(ofSize: 16, weight: .Bold)
            
            self.topGoodButton.setTitle(inspection.goodTitle, for: .normal)
            self.topBadButton.setTitle(inspection.badTitle, for: .normal)
            
            self.setTopButtons(inspection: inspection)
            
        case 2:
            self.topBaseView.isHidden = false
            self.middleBaseView.isHidden = false
            self.bottomBaseView.isHidden = true
            
            self.mainTitleLabel.isHidden = false
            self.topContentTitleLabel.text = inspection.contents[0].title
            self.topContentTitleLabel.font = .useFont(ofSize: 16, weight: .Medium)
            
            self.topGoodButton.setTitle(inspection.goodTitle, for: .normal)
            self.topBadButton.setTitle(inspection.badTitle, for: .normal)
            
            self.middleContentTitleLabel.text = inspection.contents[1].title
            self.middleContentTitleLabel.font = .useFont(ofSize: 16, weight: .Medium)
            
            self.middleGoodButton.setTitle(inspection.goodTitle, for: .normal)
            self.middleBadButton.setTitle(inspection.badTitle, for: .normal)
            
            self.setTopButtons(inspection: inspection)
            self.setMiddleButtons(inspection: inspection)
            
        case 3:
            self.topBaseView.isHidden = false
            self.middleBaseView.isHidden = false
            self.bottomBaseView.isHidden = false
            
            self.mainTitleLabel.isHidden = false
            self.topContentTitleLabel.text = inspection.contents[0].title
            self.topContentTitleLabel.font = .useFont(ofSize: 16, weight: .Medium)
            
            self.topGoodButton.setTitle(inspection.goodTitle, for: .normal)
            self.topBadButton.setTitle(inspection.badTitle, for: .normal)
            
            self.middleContentTitleLabel.text = inspection.contents[1].title
            self.middleContentTitleLabel.font = .useFont(ofSize: 16, weight: .Medium)
            
            self.middleGoodButton.setTitle(inspection.goodTitle, for: .normal)
            self.middleBadButton.setTitle(inspection.badTitle, for: .normal)
            
            self.bottomContentTitleLabel.text = inspection.contents[2].title
            self.bottomContentTitleLabel.font = .useFont(ofSize: 16, weight: .Medium)
            
            self.bottomGoodButton.setTitle(inspection.goodTitle, for: .normal)
            self.bottomBadButton.setTitle(inspection.badTitle, for: .normal)
            
            self.setTopButtons(inspection: inspection)
            self.setMiddleButtons(inspection: inspection)
            self.setBottomButtons(inspection: inspection)
            
        default: break
        }
        
        self.statusButton.setImage(.useCustomImage(inspection.contents.filter({ $0.status == nil }).isEmpty ? "status.done.good" : "status.todo"), for: .normal)
        
    }
    
    func setTopButtons(inspection: VehicleInspection) {
        guard let status = inspection.contents[0].status else {
            self.topGoodButton.backgroundColor = .white
            self.topGoodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
            self.topBadButton.backgroundColor = .white
            self.topBadButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            return
        }
        if status {
            self.topGoodButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.topGoodButton.setTitleColor(.white, for: .normal)
            
            self.topBadButton.backgroundColor = .white
            self.topBadButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        } else {
            self.topBadButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.topBadButton.setTitleColor(.white, for: .normal)
            
            self.topGoodButton.backgroundColor = .white
            self.topGoodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        }
        
    }
    
    func setMiddleButtons(inspection: VehicleInspection) {
        guard let status = inspection.contents[1].status else {
            self.middleGoodButton.backgroundColor = .white
            self.middleGoodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
            self.middleBadButton.backgroundColor = .white
            self.middleBadButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            return
        }
        if status {
            self.middleGoodButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.middleGoodButton.setTitleColor(.white, for: .normal)
            
            self.middleBadButton.backgroundColor = .white
            self.middleBadButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        } else {
            self.middleBadButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.middleBadButton.setTitleColor(.white, for: .normal)
            
            self.middleGoodButton.backgroundColor = .white
            self.middleGoodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        }
        
    }
    
    func setBottomButtons(inspection: VehicleInspection) {
        guard let status = inspection.contents[2].status else {
            self.bottomGoodButton.backgroundColor = .white
            self.bottomGoodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
            self.bottomBadButton.backgroundColor = .white
            self.bottomBadButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            return
        }
        if status {
            self.bottomGoodButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.bottomGoodButton.setTitleColor(.white, for: .normal)
            
            self.bottomBadButton.backgroundColor = .white
            self.bottomBadButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        } else {
            self.bottomBadButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.bottomBadButton.setTitleColor(.white, for: .normal)
            
            self.bottomGoodButton.backgroundColor = .white
            self.bottomGoodButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        }
        
    }
    
}

// MARK: - Extension for selector added
extension RenewalDailyInspectionTableViewCell {
    @objc func topGoodButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("InspectionReloadData"), object: nil, userInfo: ["status": true, "index": self.index, "contentsIndex": 0])
        
    }
    
    @objc func topBadButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("InspectionReloadData"), object: nil, userInfo: ["status": false, "index": self.index, "contentsIndex": 0])
        
    }
    
    @objc func middleGoodButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("InspectionReloadData"), object: nil, userInfo: ["status": true, "index": self.index, "contentsIndex": 1])
        
    }
    
    @objc func middleBadButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("InspectionReloadData"), object: nil, userInfo: ["status": false, "index": self.index, "contentsIndex": 1])
        
    }
    
    @objc func bottomGoodButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("InspectionReloadData"), object: nil, userInfo: ["status": true, "index": self.index, "contentsIndex": 2])
        
    }
    
    @objc func bottomBadButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("InspectionReloadData"), object: nil, userInfo: ["status": false, "index": self.index, "contentsIndex": 2])
        
    }
}
