//
//  DispatchOffTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/9/24.
//

import UIKit

final class DispatchOffTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var figureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Medium)
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
extension DispatchOffTableViewCell {
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
            self.titleLabel,
            self.figureLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.figureLabel.centerYAnchor),
        ])
        
        // figureLabel
        NSLayoutConstraint.activate([
            self.figureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.figureLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            self.figureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchOffTableViewCell {
    func setCell(note: (title: String, figure: String)) {
        self.titleLabel.text = note.title
        self.figureLabel.text = note.figure
        
    }
    
}
