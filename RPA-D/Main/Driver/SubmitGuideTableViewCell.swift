//
//  SubmitGuideTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/8/24.
//

import UIKit

final class SubmitGuideTableViewCell: UITableViewCell {
    
    lazy var submitTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "관련 서류를 제출해 주세요"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    lazy var submitSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "건강 이상과 관련된 의사 소견서를 회사에 제출해 주세요."
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 16, weight: .Regular)
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
extension SubmitGuideTableViewCell {
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
            self.submitTitleLabel,
            self.submitSubTitleLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        
        // submitTitleLabel
        NSLayoutConstraint.activate([
            self.submitTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.submitTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 48),
        ])
        
        // submitSubTitleLabel
        NSLayoutConstraint.activate([
            self.submitSubTitleLabel.leadingAnchor.constraint(equalTo: self.submitTitleLabel.leadingAnchor),
            self.submitSubTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.submitSubTitleLabel.topAnchor.constraint(equalTo: self.submitTitleLabel.bottomAnchor, constant: 4),
            self.submitSubTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension SubmitGuideTableViewCell {
    func setCell() {
        
    }
}
