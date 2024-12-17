//
//  RouteBasicInfoTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/17/24.
//

import UIKit

final class RouteBasicInfoTableViewCell: UITableViewCell {
    
    lazy var routeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var groupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 249, green: 249, blue: 249)
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
extension RouteBasicInfoTableViewCell {
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
            self.routeLabel,
            self.groupLabel,
            self.borderView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // routeLabel
        NSLayoutConstraint.activate([
            self.routeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.routeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            self.routeLabel.bottomAnchor.constraint(equalTo: self.borderView.topAnchor, constant: -24),
            self.routeLabel.heightAnchor.constraint(equalToConstant: 26),
        ])
        
        // groupLabel
        NSLayoutConstraint.activate([
            self.groupLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.groupLabel.centerYAnchor.constraint(equalTo: self.routeLabel.centerYAnchor),
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
extension RouteBasicInfoTableViewCell {
    func setCell(item: RouteDetailItem) {
        self.routeLabel.text = item.route
        self.groupLabel.text = item.group
        
    }
    
}
