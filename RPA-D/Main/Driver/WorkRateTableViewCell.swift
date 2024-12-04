//
//  WorkRateTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 11/19/24.
//

import UIKit

final class WorkRateTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "업무 진행도"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rateBaseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
//        view.addShadow(offset: CGSize(width: 1.0, height: 1.0), color: .useRGB(red: 194, green: 194, blue: 194, alpha: 0.25))
        view.addShadow(location: .bottom, color: .useRGB(red: 194, green: 194, blue: 194, alpha: 0.25))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var rateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "퇴근까지 0% 남았어요"
        label.textColor = .useRGB(red: 55, green: 55, blue: 55)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("WorkRateImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .useRGB(red: 223, green: 52, blue: 52)
        progressView.trackTintColor = .useRGB(red: 233, green: 232, blue: 233)
        progressView.layer.cornerRadius = 5
        progressView.layer.masksToBounds = true
        progressView.progress = 0
        
        progressView.progressViewStyle = .bar
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    lazy var goToWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "출근"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var getOffWorkLabel: UILabel = {
        let label = UILabel()
        label.text = "퇴근"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var rateImageViewLeadingLayoutConstraint: NSLayoutConstraint!
    
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
extension WorkRateTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
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
            self.rateBaseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.rateTitleLabel,
            self.rateImageView,
            self.progressView,
            self.goToWorkLabel,
            self.getOffWorkLabel,
        ], to: self.rateBaseView)
    }
    
    // Set layouts
    func setLayouts() {
//        let safeArea = self.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 46),
        ])
        
        // rateBaseView
        NSLayoutConstraint.activate([
            self.rateBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.rateBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.rateBaseView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
            self.rateBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            self.rateBaseView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 130 / 375),
        ])
        
        // rateTitleLabel
        NSLayoutConstraint.activate([
            self.rateTitleLabel.leadingAnchor.constraint(equalTo: self.rateBaseView.leadingAnchor, constant: 20),
            self.rateTitleLabel.topAnchor.constraint(equalTo: self.rateBaseView.topAnchor, constant: 20),
            self.rateTitleLabel.trailingAnchor.constraint(equalTo: self.rateBaseView.trailingAnchor, constant: -20)
        ])
        
        // rateImageView
        self.rateImageViewLeadingLayoutConstraint = self.rateImageView.leadingAnchor.constraint(equalTo: self.progressView.leadingAnchor, constant: (ReferenceValues.Size.Device.width - 84) * CGFloat(self.progressView.progress) - 32)
        NSLayoutConstraint.activate([
            self.rateImageViewLeadingLayoutConstraint,
            self.rateImageView.topAnchor.constraint(equalTo: self.rateTitleLabel.bottomAnchor, constant: 10),
            self.rateImageView.bottomAnchor.constraint(equalTo: self.progressView.topAnchor),
            self.rateImageView.widthAnchor.constraint(equalToConstant: 52),
            self.rateImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // progressView
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: self.rateBaseView.leadingAnchor, constant: 22),
            self.progressView.trailingAnchor.constraint(equalTo: self.rateBaseView.trailingAnchor, constant: -22),
            self.progressView.heightAnchor.constraint(equalToConstant: 10),
        ])
        
        // goToWorkLabel
        NSLayoutConstraint.activate([
            self.goToWorkLabel.leadingAnchor.constraint(equalTo: self.progressView.leadingAnchor),
            self.goToWorkLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 3),
        ])
        
        // getOffWorkLabel
        NSLayoutConstraint.activate([
            self.getOffWorkLabel.trailingAnchor.constraint(equalTo: self.progressView.trailingAnchor),
            self.getOffWorkLabel.topAnchor.constraint(equalTo: self.progressView.bottomAnchor, constant: 3),
        ])
    }
}

// MARK: - Extension for methods added
extension WorkRateTableViewCell {
    func setCell(routine: RoutineItem?) {
        guard let routine = routine else { return }
        
        var sumCount = 0
        if routine.goToWork.wakeTime != "" {
            sumCount += 1
            
        }
        
        if routine.goToWork.attendanceTime != "" {
            sumCount += 1
            
        }
        
        if !routine.tasks.isEmpty {
            for task in routine.tasks {
                for info in task!.statusInfo {
                    if info.completionTime != "" {
                        sumCount += 1
                        
                    }
                    
                }
                
            }
            
        }
        
        if routine.getOffWork.rollCallTime != "" {
            sumCount += 1
            
        }
        
        if routine.getOffWork.tomorrowDispatchCheckTime != "" {
            sumCount += 1
            
        }
        
        if routine.getOffWork.getOffTime != "" {
            sumCount += 1
            
        }
        
        let rate = Double(sumCount) / Double((routine.tasks.count * 5 + 5))
        self.rateTitleLabel.text = "퇴근까지 \(Int(rate * 100))% 남았어요"
        self.progressView.progress = Float(rate)
        self.rateImageViewLeadingLayoutConstraint.constant = (ReferenceValues.Size.Device.width - 84) * CGFloat(self.progressView.progress) - 32
        
    }
    
}

