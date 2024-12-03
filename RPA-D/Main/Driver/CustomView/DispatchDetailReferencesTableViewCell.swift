//
//  DispatchDetailReferencesTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/3/24.
//

import UIKit

final class DispatchDetailReferencesTableViewCell: UITableViewCell {
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "참조사항"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var referenceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
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
extension DispatchDetailReferencesTableViewCell {
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
            self.separateView,
            self.titleLabel,
            self.referenceLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.separateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.separateView.topAnchor.constraint(equalTo: self.topAnchor),
            self.separateView.heightAnchor.constraint(equalToConstant: 2),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.separateView.bottomAnchor, constant: 26),
        ])
        
        // referenceLabel
        NSLayoutConstraint.activate([
            self.referenceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.referenceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.referenceLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 15),
            self.referenceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 28),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchDetailReferencesTableViewCell {
    func setCell(references: String) {
        self.referenceLabel.text = references == "" ? "없음" : references
        
    }
    
}

