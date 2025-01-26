//
//  StationDetailInfoTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/3/24.
//

import UIKit

final class StationDetailInfoTableViewCell: UITableViewCell {
    
    lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var stationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("detail.station")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
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
            self.topLineView,
            self.stationImageView,
            self.bottomLineView,
            self.timeLabel,
            self.stationLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // topLineView
        NSLayoutConstraint.activate([
            self.topLineView.topAnchor.constraint(equalTo: self.topAnchor),
            self.topLineView.bottomAnchor.constraint(equalTo: self.stationImageView.topAnchor),
            self.topLineView.centerXAnchor.constraint(equalTo: self.stationImageView.centerXAnchor),
            self.topLineView.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        // bottomLineView
        NSLayoutConstraint.activate([
            self.bottomLineView.topAnchor.constraint(equalTo: self.stationImageView.bottomAnchor),
            self.bottomLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.bottomLineView.centerXAnchor.constraint(equalTo: self.stationImageView.centerXAnchor),
            self.bottomLineView.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        // stationImageView
        NSLayoutConstraint.activate([
            self.stationImageView.heightAnchor.constraint(equalToConstant: 16),
            self.stationImageView.widthAnchor.constraint(equalToConstant: 16),
            self.stationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.stationImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.leadingAnchor.constraint(equalTo: self.stationImageView.trailingAnchor, constant: 20),
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
    func setCell(station: StationInfo, index: Int, lastIndex: Int) {
        self.index = index
        
        self.timeLabel.text = station.targetTime
        self.stationLabel.text = station.stationName
        
        if self.index == 0 {
            self.topLineView.isHidden = true
            self.bottomLineView.isHidden = false
            
            self.stationImageView.image = .useCustomImage("detail.location.marker")
            
        } else if index == lastIndex {
            self.topLineView.isHidden = false
            self.bottomLineView.isHidden = true
            
            self.stationImageView.image = .useCustomImage("detail.location.marker")
            
        } else {
            self.topLineView.isHidden = false
            self.bottomLineView.isHidden = false
            
            self.stationImageView.image = .useCustomImage("detail.station")
        }
        
    }
}

