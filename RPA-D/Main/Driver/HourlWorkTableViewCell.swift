//
//  HourlWorkTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 11/25/24.
//

import UIKit

final class HourlWorkTableViewCell: UITableViewCell {
    
    lazy var hourlyWorkView: HourlyWorkView = {
        let view = HourlyWorkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
extension HourlWorkTableViewCell {
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
            self.hourlyWorkView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // hourlyWorkView
        NSLayoutConstraint.activate([
            self.hourlyWorkView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.hourlyWorkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.hourlyWorkView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.hourlyWorkView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
        ])
    }
}

// MARK: - Extension for methods added
extension HourlWorkTableViewCell {
    func setCell(time: String, content: String) {
        self.hourlyWorkView.setData(time: time, content: content)
    }
}

