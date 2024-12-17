//
//  NoticeTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/16/24.
//

import UIKit

final class NoticeTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("notice.detail.arrow")
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
extension NoticeTableViewCell {
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
            self.dateLabel,
            self.detailImageView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.detailImageView.leadingAnchor, constant: -4),
        ])
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.dateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
            self.dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            self.dateLabel.trailingAnchor.constraint(equalTo: self.detailImageView.leadingAnchor, constant: -4),
        ])
        
        // detailImageView
        NSLayoutConstraint.activate([
            self.detailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.detailImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.detailImageView.heightAnchor.constraint(equalToConstant: 24),
            self.detailImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
}

// MARK: - Extension for methods added
extension NoticeTableViewCell {
    func setCell(notice: NoticeItem) {
        self.titleLabel.text = notice.title
        
        let date = SupportingMethods.shared.convertString(intoDate: notice.date, "yyyy-MM-dd HH:mm")
        self.dateLabel.text = SupportingMethods.shared.calculatePassedTime(date)
        
    }
    
}
