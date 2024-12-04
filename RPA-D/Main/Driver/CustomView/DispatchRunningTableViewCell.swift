//
//  DispatchRunningTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/4/24.
//

import UIKit

final class DispatchRunningTableViewCell: UITableViewCell {
    
    lazy var targetTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 223, green: 52, blue: 52)
        label.font = .useFont(ofSize: 56, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var stationGuideLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Regular)
        label.textAlignment = .center
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
extension DispatchRunningTableViewCell {
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
            self.targetTimeLabel,
            self.stationGuideLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // targetTimeLabel
        NSLayoutConstraint.activate([
            self.targetTimeLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.targetTimeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.targetTimeLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        // stationGuideLabel
        NSLayoutConstraint.activate([
            self.stationGuideLabel.topAnchor.constraint(equalTo: self.targetTimeLabel.bottomAnchor, constant: 4),
            self.stationGuideLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.stationGuideLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.stationGuideLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.stationGuideLabel.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchRunningTableViewCell {
    func setCell(station: StationInfo, status: Bool) {
        self.targetTimeLabel.text = "\(station.targetTime)"
        self.stationGuideLabel.text = "\(station.stationName)로 이동중입니다"
        self.stationGuideLabel.asFontColor(targetString: "\(station.stationName)", font: .useFont(ofSize: 20, weight: .Medium), color: .useRGB(red: 223, green: 52, blue: 52))
        
        if status {
            // 현재 가는 중인 정류장
            self.stationGuideLabel.isHidden = false
            self.targetTimeLabel.textColor = .useRGB(red: 223, green: 52, blue: 52)
            self.targetTimeLabel.font = .useFont(ofSize: 56, weight: .Bold)
            
        } else {
            // 과거 혹은 그 다음 정류장
            self.stationGuideLabel.isHidden = true
            self.targetTimeLabel.text = "\(station.stationName) \(station.targetTime)"
            self.targetTimeLabel.textColor = .useRGB(red: 196, green: 195, blue: 195)
            self.targetTimeLabel.font = .useFont(ofSize: 16, weight: .Regular)
            
        }
    }
    
}

