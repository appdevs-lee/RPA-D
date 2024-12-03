//
//  StationDetailInfoTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/3/24.
//

import UIKit

final class StationDetailInfoTableViewCell: UITableViewCell {
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var stationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.numberOfLines = 2
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
extension StationDetailInfoTableViewCell {
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
            self.timeLabel,
            self.stationLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60),
            self.timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 11),
        ])
        
        // stationLabel
        NSLayoutConstraint.activate([
            self.stationLabel.leadingAnchor.constraint(equalTo: self.timeLabel.leadingAnchor),
            self.stationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.stationLabel.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 4),
            self.stationLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -11),
        ])
    }
}

// MARK: - Extension for methods added
extension StationDetailInfoTableViewCell {
    func setCell(station: StationInfo) {
        self.timeLabel.text = station.targetTime
        self.stationLabel.text = station.stationName
    }
}

