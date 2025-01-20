//
//  ScheduleTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 1/20/25.
//

import UIKit

final class ScheduleTableViewCell: UITableViewCell {
    
    lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var departureTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var detailButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setImage(.useCustomImage("scheduleDetailImage"), for: .normal)
        button.setImage(.useCustomImage("scheduleDetailImage"), for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.titleLabel?.font = .useFont(ofSize: 11, weight: .Regular)
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var moreDispatchInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var mainContentsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.dispatchBaseView, self.progressBaseView])
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var dispatchBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var decoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("scheduleDecoImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var arrivalBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var progressBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .useRGB(red: 223, green: 52, blue: 52)
        progressView.trackTintColor = .useRGB(red: 248, green: 248, blue: 248)
        progressView.layer.cornerRadius = 5
        progressView.layer.masksToBounds = true
        progressView.progress = 0
        
        progressView.progressViewStyle = .bar
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    lazy var progressValueView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.useRGB(red: 223, green: 52, blue: 52).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var taskRateValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 223, green: 52, blue: 52)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var dispatch: RoutineDispatch?
    var progressValueViewLeadingAnchorConstraint: NSLayoutConstraint!
    
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
extension ScheduleTableViewCell {
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
            self.statusImageView,
            self.departureTimeTitleLabel,
            self.detailButton,
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.statusButton,
            self.moreDispatchInfoLabel,
            self.mainContentsStackView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.departureBaseView,
            self.decoImageView,
            self.arrivalBaseView,
        ], to: self.dispatchBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.departureTimeLabel,
            self.departureLabel,
        ], to: self.departureBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.arrivalTimeLabel,
            self.arrivalLabel,
        ], to: self.arrivalBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.progressView,
            self.progressValueView,
            self.taskRateValueLabel,
        ], to: self.progressBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // statusImageView
        NSLayoutConstraint.activate([
            self.statusImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 14),
            self.statusImageView.centerYAnchor.constraint(equalTo: self.departureTimeTitleLabel.centerYAnchor),
            self.statusImageView.widthAnchor.constraint(equalToConstant: 12),
            self.statusImageView.heightAnchor.constraint(equalToConstant: 12),
        ])
        
        // departureTimeTitleLabel
        NSLayoutConstraint.activate([
            self.departureTimeTitleLabel.leadingAnchor.constraint(equalTo: self.statusImageView.trailingAnchor, constant: 10),
            self.departureTimeTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
        ])
        
        // detailButton
        NSLayoutConstraint.activate([
            self.detailButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.detailButton.centerYAnchor.constraint(equalTo: self.departureTimeTitleLabel.centerYAnchor),
            self.detailButton.widthAnchor.constraint(equalToConstant: 69),
            self.detailButton.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.departureTimeTitleLabel.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.departureTimeTitleLabel.bottomAnchor, constant: 8),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
        ])
        
        // statusButton
        NSLayoutConstraint.activate([
            self.statusButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.statusButton.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 16),
            self.statusButton.widthAnchor.constraint(equalToConstant: 61),
            self.statusButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        // moreDispatchInfoLabel
        NSLayoutConstraint.activate([
            self.moreDispatchInfoLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.moreDispatchInfoLabel.centerYAnchor.constraint(equalTo: self.statusButton.centerYAnchor),
        ])
        
        // mainContentsStackView
        NSLayoutConstraint.activate([
            self.mainContentsStackView.leadingAnchor.constraint(equalTo: self.statusButton.leadingAnchor),
            self.mainContentsStackView.trailingAnchor.constraint(equalTo: self.moreDispatchInfoLabel.trailingAnchor),
            self.mainContentsStackView.topAnchor.constraint(equalTo: self.statusButton.bottomAnchor, constant: 12),
            self.mainContentsStackView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -16),
        ])
        
        // departureBaseView
        NSLayoutConstraint.activate([
            self.departureBaseView.leadingAnchor.constraint(equalTo: self.dispatchBaseView.leadingAnchor),
            self.departureBaseView.topAnchor.constraint(equalTo: self.dispatchBaseView.topAnchor),
            self.departureBaseView.bottomAnchor.constraint(equalTo: self.dispatchBaseView.bottomAnchor),
            self.departureBaseView.widthAnchor.constraint(equalToConstant: 102),
            self.departureBaseView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.departureBaseView.leadingAnchor),
            self.departureTimeLabel.topAnchor.constraint(equalTo: self.departureBaseView.topAnchor),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureBaseView.leadingAnchor),
            self.departureLabel.topAnchor.constraint(equalTo: self.departureTimeLabel.bottomAnchor, constant: 4),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.departureBaseView.trailingAnchor),
        ])
        
        // decoImageView
        NSLayoutConstraint.activate([
            self.decoImageView.centerYAnchor.constraint(equalTo: self.departureBaseView.centerYAnchor),
            self.decoImageView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.decoImageView.widthAnchor.constraint(equalToConstant: 50),
            self.decoImageView.heightAnchor.constraint(equalToConstant: 6),
        ])
        
        // arrivalBaseView
        NSLayoutConstraint.activate([
            self.arrivalBaseView.trailingAnchor.constraint(equalTo: self.dispatchBaseView.trailingAnchor),
            self.arrivalBaseView.topAnchor.constraint(equalTo: self.dispatchBaseView.topAnchor),
            self.arrivalBaseView.bottomAnchor.constraint(equalTo: self.dispatchBaseView.bottomAnchor),
            self.arrivalBaseView.widthAnchor.constraint(equalToConstant: 102),
            self.arrivalBaseView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalBaseView.leadingAnchor),
            self.arrivalTimeLabel.trailingAnchor.constraint(equalTo: self.arrivalBaseView.trailingAnchor),
            self.arrivalTimeLabel.topAnchor.constraint(equalTo: self.arrivalBaseView.topAnchor),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalBaseView.leadingAnchor),
            self.arrivalLabel.topAnchor.constraint(equalTo: self.arrivalTimeLabel.bottomAnchor, constant: 4),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.arrivalBaseView.trailingAnchor),
        ])
        
        // progressView
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: self.progressBaseView.leadingAnchor),
            self.progressView.topAnchor.constraint(equalTo: self.progressBaseView.topAnchor),
            self.progressView.trailingAnchor.constraint(equalTo: self.progressBaseView.trailingAnchor),
            self.progressView.heightAnchor.constraint(equalToConstant: 12),
        ])
        
        // progressValueView
        self.progressValueViewLeadingAnchorConstraint = self.progressValueView.centerXAnchor.constraint(equalTo: self.progressView.leadingAnchor, constant: 0)
        NSLayoutConstraint.activate([
            self.progressValueViewLeadingAnchorConstraint,
            self.progressValueView.centerYAnchor.constraint(equalTo: self.progressView.centerYAnchor),
            self.progressValueView.widthAnchor.constraint(equalToConstant: 12),
            self.progressValueView.heightAnchor.constraint(equalToConstant: 12),
        ])
        
        // taskRateValueLabel
        NSLayoutConstraint.activate([
            self.taskRateValueLabel.topAnchor.constraint(equalTo: self.progressValueView.bottomAnchor, constant: 3),
            self.taskRateValueLabel.bottomAnchor.constraint(equalTo: self.progressBaseView.bottomAnchor),
            self.taskRateValueLabel.centerXAnchor.constraint(equalTo: self.progressValueView.centerXAnchor),
        ])
        
    }
}

// MARK: - Extension for methods added
extension ScheduleTableViewCell {
    func setCell(dispatch: RoutineDispatch?, currentDispatchId: Int?) {
        self.dispatch = dispatch
        guard let dispatch = dispatch else { return }
        
        self.departureTimeTitleLabel.text = SupportingMethods.shared.convertString(intoCustomString: dispatch.departureDate, "a HH:mm")
        self.moreDispatchInfoLabel.text = "\(dispatch.workType)배차 | \(dispatch.busNum)"
        
        self.departureTimeLabel.text = SupportingMethods.shared.convertString(intoCustomString: dispatch.departureDate, "HH:mm")
        self.departureLabel.text = "\(dispatch.departure)"
        
        self.arrivalTimeLabel.text = SupportingMethods.shared.convertString(intoCustomString: dispatch.arrivalDate, "HH:mm")
        self.arrivalLabel.text = "\(dispatch.arrival)"
        
        self.baseView.layer.shadowOpacity = 0
        self.baseView.layer.borderWidth = 0.0
        self.progressBaseView.isHidden = true
        
        if dispatch.statusInfo.last?.completionTime != "" {
            // 진행완료
            self.statusButton.setTitle("진행완료", for: .normal)
            self.statusButton.backgroundColor = .white
            self.statusButton.layer.borderColor = UIColor.useRGB(red: 219, green: 219, blue: 219).cgColor
            self.statusButton.layer.borderWidth = 1.0
            self.statusButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
            self.statusImageView.image = .useCustomImage("status.done")
            
        } else {
            if let currentDispatchId = currentDispatchId, dispatch.dispatchId! == currentDispatchId {
                // 진행중
                self.statusButton.setTitle("진행중", for: .normal)
                self.statusButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
                self.statusButton.layer.borderWidth = 0.0
                self.statusButton.setTitleColor(.white, for: .normal)
                
                self.baseView.addShadow(offset: CGSize(width: 1.0, height: 1.0))
                self.baseView.layer.borderColor = UIColor.useRGB(red: 223, green: 52, blue: 52).cgColor
                self.baseView.layer.borderWidth = 1.0
                
                self.statusImageView.image = .useCustomImage("status.doing")
                self.progressBaseView.isHidden = false
                self.calculateRate()
                
            } else {
                // 진행 예정
                self.statusButton.setTitle("진행완료", for: .normal)
                self.statusButton.backgroundColor = .useRGB(red: 255, green: 245, blue: 245)
                self.statusButton.layer.borderWidth = 0.0
                self.statusButton.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .normal)
                
                self.statusImageView.image = .useCustomImage("status.todo")
            }
            
        }
        
    }
    
    func calculateRate() {
        guard let dispatch = self.dispatch else { return }
        
        var sumCount = 0
        
        for info in dispatch.statusInfo {
            if info.completionTime != "" {
                sumCount += 1
                
            }
            
        }
        
        let rate = Double(sumCount) / 5
        self.taskRateValueLabel.text = "\(Int(rate * 100))%"
        
        self.progressView.setProgress(Float(rate), animated: true)
        self.progressValueViewLeadingAnchorConstraint.constant = (ReferenceValues.Size.Device.width - 88) * CGFloat(self.progressView.progress)
        
    }
    
}

// MARK: - Extension for selector added
extension ScheduleTableViewCell {
    
}
