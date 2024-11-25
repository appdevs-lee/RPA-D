//
//  DispatchTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 11/19/24.
//

import UIKit

final class DispatchTableViewCell: UITableViewCell {
    
    lazy var dispatchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.dispatchTitleBaseView, self.dispatchContentBaseView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var dispatchTitleBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchTitleLabelButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("배차", for: .normal)
        button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 245, blue: 245)
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
    
    lazy var dispatchTitleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(dispatchTitleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchContentBaseView: UIView = {
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
    
    var index: Int?
    
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
extension DispatchTableViewCell {
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
            self.dispatchStackView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchTitleLabelButton,
            self.foldAndOpenButton,
            self.dispatchTitleButton,
        ], to: self.dispatchTitleBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.separateView,
        ], to: self.dispatchContentBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // dispatchStackView
        NSLayoutConstraint.activate([
            self.dispatchStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.dispatchStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.dispatchStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            self.dispatchStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
        ])
        
        // dispatchTitleButton
        NSLayoutConstraint.activate([
            self.dispatchTitleButton.leadingAnchor.constraint(equalTo: self.dispatchTitleBaseView.leadingAnchor),
            self.dispatchTitleButton.trailingAnchor.constraint(equalTo: self.dispatchTitleBaseView.trailingAnchor),
            self.dispatchTitleButton.topAnchor.constraint(equalTo: self.dispatchTitleBaseView.topAnchor),
            self.dispatchTitleButton.bottomAnchor.constraint(equalTo: self.dispatchTitleBaseView.bottomAnchor),
        ])
        
        // dispatchTitleBaseView
        NSLayoutConstraint.activate([
            self.dispatchTitleBaseView.heightAnchor.constraint(equalToConstant: 62),
        ])
        
        // dispatchTitleLabelButton
        NSLayoutConstraint.activate([
            self.dispatchTitleLabelButton.leadingAnchor.constraint(equalTo: self.dispatchTitleBaseView.leadingAnchor, constant: 16),
            self.dispatchTitleLabelButton.centerYAnchor.constraint(equalTo: self.dispatchTitleBaseView.centerYAnchor),
            self.dispatchTitleLabelButton.widthAnchor.constraint(equalToConstant: 50),
            self.dispatchTitleLabelButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // foldAndOpenButton
        NSLayoutConstraint.activate([
            self.foldAndOpenButton.centerYAnchor.constraint(equalTo: self.dispatchTitleBaseView.centerYAnchor),
            self.foldAndOpenButton.trailingAnchor.constraint(equalTo: self.dispatchTitleBaseView.trailingAnchor, constant: -26),
            self.foldAndOpenButton.heightAnchor.constraint(equalToConstant: 24),
            self.foldAndOpenButton.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        // dispatchContentBaseView
        NSLayoutConstraint.activate([
            self.dispatchContentBaseView.heightAnchor.constraint(equalToConstant: 294),
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.separateView.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.separateView.heightAnchor.constraint(equalToConstant: 1),
            self.separateView.topAnchor.constraint(equalTo: self.dispatchContentBaseView.topAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchTableViewCell {
    func setCell(index: Int) {
        self.index = index
        
        if self.dispatchContentBaseView.isHidden == true {
            self.foldAndOpenButton.setImage(.useCustomImage("routine.down"), for: .normal)
            self.dispatchTitleBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
        } else {
            self.foldAndOpenButton.setImage(.useCustomImage("routine.up"), for: .normal)
            self.dispatchTitleBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        }
        
    }
}

// MARK: - Extension for methods added
extension DispatchTableViewCell {
    @objc func dispatchTitleButton(_ sender: UIButton) {
        guard let index = self.index else { return }
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil, userInfo: ["index": index])
        
    }
    
}
