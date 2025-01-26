//
//  DispatchDetailIBaseInfoTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/3/24.
//

import UIKit
import CoreLocation

final class DispatchDetailIBaseInfoTableViewCell: UITableViewCell {
    
    lazy var todayDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var busNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var topBorderView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 235, green: 235, blue: 235)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("운행 예정", for: .normal)
        button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .normal)
        button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .disabled)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 240, blue: 240)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var estimatedDistanceLabelForFuture: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 223, green: 52, blue: 52)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var moreInfoBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var estimatedDistanceLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.estimatedDistanceTitleLabel, self.estimatedDistanceLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var estimatedDistanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "예상 운행"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var estimatedDistanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var centerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("estimatedToRealDistanceImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var realDistanceLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.realDistanceTitleLabel, self.realDistanceLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var realDistanceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "실제 운행"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var realDistanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 223, green: 52, blue: 52)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
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
extension DispatchDetailIBaseInfoTableViewCell {
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
            self.todayDateLabel,
            self.busNumLabel,
            self.topBorderView,
            self.statusButton,
            self.estimatedDistanceLabelForFuture,
            self.moreInfoBaseView,
            self.separateView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.estimatedDistanceLabelStackView,
            self.centerImageView,
            self.realDistanceLabelStackView,
        ], to: self.moreInfoBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // todayDateLabel
        NSLayoutConstraint.activate([
            self.todayDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.todayDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
        ])
        
        // busNumLabel
        NSLayoutConstraint.activate([
            self.busNumLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.busNumLabel.centerYAnchor.constraint(equalTo: self.todayDateLabel.centerYAnchor),
        ])
        
        // topBorderView
        NSLayoutConstraint.activate([
            self.topBorderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.topBorderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.topBorderView.topAnchor.constraint(equalTo: self.todayDateLabel.bottomAnchor, constant: 20),
            self.topBorderView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // statusButton
        NSLayoutConstraint.activate([
            self.statusButton.leadingAnchor.constraint(equalTo: self.topBorderView.leadingAnchor),
            self.statusButton.topAnchor.constraint(equalTo: self.topBorderView.bottomAnchor, constant: 12),
            self.statusButton.heightAnchor.constraint(equalToConstant: 26),
            self.statusButton.widthAnchor.constraint(equalToConstant: 61),
        ])
        
        // estimatedDistanceLabelForFuture
        NSLayoutConstraint.activate([
            self.estimatedDistanceLabelForFuture.trailingAnchor.constraint(equalTo: self.topBorderView.trailingAnchor, constant: -12),
            self.estimatedDistanceLabelForFuture.centerYAnchor.constraint(equalTo: self.statusButton.centerYAnchor),
        ])
        
        // moreInfoBaseView
        NSLayoutConstraint.activate([
            self.moreInfoBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.moreInfoBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.moreInfoBaseView.topAnchor.constraint(equalTo: self.todayDateLabel.bottomAnchor, constant: 20),
            self.moreInfoBaseView.heightAnchor.constraint(equalToConstant: 66)
        ])
        
        // estimatedDistanceLabelStackView
        NSLayoutConstraint.activate([
            self.estimatedDistanceLabelStackView.leadingAnchor.constraint(equalTo: self.moreInfoBaseView.leadingAnchor, constant: 12),
            self.estimatedDistanceLabelStackView.topAnchor.constraint(equalTo: self.moreInfoBaseView.topAnchor, constant: 12),
            self.estimatedDistanceLabelStackView.bottomAnchor.constraint(equalTo: self.moreInfoBaseView.bottomAnchor, constant: -12),
            self.estimatedDistanceLabelStackView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 84) / 2.0)
        ])
        
        // centerImageView
        NSLayoutConstraint.activate([
            self.centerImageView.leadingAnchor.constraint(equalTo: self.estimatedDistanceLabelStackView.trailingAnchor),
            self.centerImageView.trailingAnchor.constraint(equalTo: self.realDistanceLabelStackView.leadingAnchor),
            self.centerImageView.centerYAnchor.constraint(equalTo: self.moreInfoBaseView.centerYAnchor),
            self.centerImageView.heightAnchor.constraint(equalToConstant: 20),
            self.centerImageView.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        // realDistanceLabelStackView
        NSLayoutConstraint.activate([
            self.realDistanceLabelStackView.trailingAnchor.constraint(equalTo: self.moreInfoBaseView.trailingAnchor, constant: -12),
            self.realDistanceLabelStackView.topAnchor.constraint(equalTo: self.moreInfoBaseView.topAnchor, constant: 12),
            self.realDistanceLabelStackView.bottomAnchor.constraint(equalTo: self.moreInfoBaseView.bottomAnchor, constant: -12),
            self.realDistanceLabelStackView.widthAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 84) / 2.0)
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.separateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.separateView.topAnchor.constraint(equalTo: self.moreInfoBaseView.bottomAnchor, constant: 24),
            self.separateView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.separateView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchDetailIBaseInfoTableViewCell {
    func setCell(date: String, item: DispatchDetailItem, estimatedDistance: Int, realDistance: Int, isFuture: Bool) {
        let date = SupportingMethods.shared.convertString(intoCustomString: date, "yyyy.MM.dd | EEE요일")
        self.todayDateLabel.text = date
        self.busNumLabel.text = "\(item.workType)배차 | \(item.busNum)"
        
        self.estimatedDistanceLabel.text = "\(estimatedDistance)km"
        self.estimatedDistanceLabelForFuture.text = "총 \(estimatedDistance)km"
        self.realDistanceLabel.text = realDistance <= 0 ? "운행일보 미작성" : "\(realDistance)km"
        
        if isFuture {
            self.moreInfoBaseView.isHidden = true
            self.topBorderView.isHidden = false
            
        } else {
            self.moreInfoBaseView.isHidden = false
            self.topBorderView.isHidden = true
            
        }
        
    }
    
}

