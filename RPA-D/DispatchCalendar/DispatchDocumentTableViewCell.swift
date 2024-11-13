//
//  DispatchDocumentTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 11/13/24.
//

import UIKit

final class DispatchDocumentTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: DispatchStatus
    lazy var dispatchStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var dispatchStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchStatusBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: DispatchInfo
    lazy var dispatchInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchETCLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTitleButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("출발", for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 117, blue: 42), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 11, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 242, blue: 235)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTitleButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("도착", for: .normal)
        button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 11, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 242, blue: 242)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchButtonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.dispatchDetailButtonView, self.dispatchCheckButtonView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var dispatchDetailButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchDetailButtonTopView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 245, green: 245, blue: 245)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchDetailButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.useRGB(red: 109, green: 109, blue: 109), for: .normal)
        button.setTitleColor(.useRGB(red: 109, green: 109, blue: 109, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchCheckButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchCheckButton: UIButton = {
        let button = UIButton()
        button.setTitle("배차 수락", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchRefusalButton: UIButton = {
        let button = UIButton()
        button.setTitle("사유서 작성", for: .normal)
        button.setTitleColor(.useRGB(red: 109, green: 109, blue: 109), for: .normal)
        button.setTitleColor(.useRGB(red: 109, green: 109, blue: 109, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
extension DispatchDocumentTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.selectionStyle = .none
        self.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
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
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchStatusView,
            self.dispatchInfoView,
            self.dispatchButtonStackView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchStatusImageView,
            self.dispatchStatusLabel,
            self.dispatchStatusBottomView,
        ], to: self.dispatchStatusView)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchDateLabel,
            self.dispatchETCLabel,
            self.departureTitleButton,
            self.departureLabel,
            self.arrivalTitleButton,
            self.arrivalLabel,
        ], to: self.dispatchInfoView)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchDetailButtonTopView,
            self.dispatchDetailButton,
        ], to: self.dispatchDetailButtonView)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchCheckButton,
            self.dispatchRefusalButton,
        ], to: self.dispatchCheckButtonView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // dispatchStatusView
        NSLayoutConstraint.activate([
            self.dispatchStatusView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dispatchStatusView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.dispatchStatusView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 20),
            self.dispatchStatusView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // dispatchStatusImageView
        NSLayoutConstraint.activate([
            self.dispatchStatusImageView.leadingAnchor.constraint(equalTo: self.dispatchStatusView.leadingAnchor),
            self.dispatchStatusImageView.topAnchor.constraint(equalTo: self.dispatchStatusView.topAnchor, constant: 1),
            self.dispatchStatusImageView.widthAnchor.constraint(equalToConstant: 14),
            self.dispatchStatusImageView.heightAnchor.constraint(equalToConstant: 14),
        ])
        
        // dispatchStatusLabel
        NSLayoutConstraint.activate([
            self.dispatchStatusLabel.leadingAnchor.constraint(equalTo: self.dispatchStatusImageView.trailingAnchor, constant: 4),
            self.dispatchStatusLabel.topAnchor.constraint(equalTo: self.dispatchStatusView.topAnchor),
        ])
        
        // dispatchStatusBottomView
        NSLayoutConstraint.activate([
            self.dispatchStatusBottomView.leadingAnchor.constraint(equalTo: self.dispatchStatusView.leadingAnchor),
            self.dispatchStatusBottomView.trailingAnchor.constraint(equalTo: self.dispatchStatusView.trailingAnchor),
            self.dispatchStatusBottomView.bottomAnchor.constraint(equalTo: self.dispatchStatusView.bottomAnchor),
            self.dispatchStatusBottomView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // dispatchInfoView
        NSLayoutConstraint.activate([
            self.dispatchInfoView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dispatchInfoView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.dispatchInfoView.topAnchor.constraint(equalTo: self.dispatchStatusView.bottomAnchor),
        ])
        
        // dispatchDateLabel
        NSLayoutConstraint.activate([
            self.dispatchDateLabel.leadingAnchor.constraint(equalTo: self.dispatchInfoView.leadingAnchor),
            self.dispatchDateLabel.topAnchor.constraint(equalTo: self.dispatchInfoView.topAnchor, constant: 8),
        ])
        
        // dispatchETCLabel
        NSLayoutConstraint.activate([
            self.dispatchETCLabel.trailingAnchor.constraint(equalTo: self.dispatchInfoView.trailingAnchor),
            self.dispatchETCLabel.topAnchor.constraint(equalTo: self.dispatchDateLabel.topAnchor),
        ])
        
        // departureTitleButton
        NSLayoutConstraint.activate([
            self.departureTitleButton.leadingAnchor.constraint(equalTo: self.dispatchInfoView.leadingAnchor),
            self.departureTitleButton.topAnchor.constraint(equalTo: self.dispatchDateLabel.bottomAnchor, constant: 17),
            self.departureTitleButton.heightAnchor.constraint(equalToConstant: 22),
            self.departureTitleButton.widthAnchor.constraint(equalToConstant: 37),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureTitleButton.trailingAnchor, constant: 4),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.dispatchInfoView.trailingAnchor),
            self.departureLabel.centerYAnchor.constraint(equalTo: self.departureTitleButton.centerYAnchor),
        ])
        
        // arrivalTitleButton
        NSLayoutConstraint.activate([
            self.arrivalTitleButton.leadingAnchor.constraint(equalTo: self.dispatchInfoView.leadingAnchor),
            self.arrivalTitleButton.topAnchor.constraint(equalTo: self.departureTitleButton.bottomAnchor, constant: 14),
            self.arrivalTitleButton.bottomAnchor.constraint(equalTo: self.dispatchInfoView.bottomAnchor),
            self.arrivalTitleButton.heightAnchor.constraint(equalToConstant: 22),
            self.arrivalTitleButton.widthAnchor.constraint(equalToConstant: 37),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleButton.trailingAnchor, constant: 4),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.dispatchInfoView.trailingAnchor),
            self.arrivalLabel.centerYAnchor.constraint(equalTo: self.arrivalTitleButton.centerYAnchor),
        ])
        
        // dispatchButtonStackView
        NSLayoutConstraint.activate([
            self.dispatchButtonStackView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dispatchButtonStackView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.dispatchButtonStackView.topAnchor.constraint(equalTo: self.dispatchInfoView.bottomAnchor, constant: 16),
            self.dispatchButtonStackView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
        ])
        
        // dispatchDetailButtonTopView
        NSLayoutConstraint.activate([
            self.dispatchDetailButtonTopView.leadingAnchor.constraint(equalTo: self.dispatchDetailButtonView.leadingAnchor),
            self.dispatchDetailButtonTopView.trailingAnchor.constraint(equalTo: self.dispatchDetailButtonView.trailingAnchor),
            self.dispatchDetailButtonTopView.topAnchor.constraint(equalTo: self.dispatchDetailButtonView.topAnchor),
            self.dispatchDetailButtonTopView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // dispatchDetailButton
        NSLayoutConstraint.activate([
            self.dispatchDetailButton.leadingAnchor.constraint(equalTo: self.dispatchDetailButtonView.leadingAnchor),
            self.dispatchDetailButton.trailingAnchor.constraint(equalTo: self.dispatchDetailButtonView.trailingAnchor),
            self.dispatchDetailButton.bottomAnchor.constraint(equalTo: self.dispatchDetailButtonView.bottomAnchor),
            self.dispatchDetailButton.topAnchor.constraint(equalTo: self.dispatchDetailButtonTopView.bottomAnchor),
            self.dispatchDetailButton.heightAnchor.constraint(equalToConstant: 43),
        ])
        
        // dispatchCheckButton
        NSLayoutConstraint.activate([
            self.dispatchCheckButton.leadingAnchor.constraint(equalTo: self.dispatchCheckButtonView.leadingAnchor),
            self.dispatchCheckButton.trailingAnchor.constraint(equalTo: self.dispatchCheckButtonView.trailingAnchor),
            self.dispatchCheckButton.topAnchor.constraint(equalTo: self.dispatchCheckButtonView.topAnchor, constant: 4),
            self.dispatchCheckButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // dispatchRefusalButton
        NSLayoutConstraint.activate([
            self.dispatchRefusalButton.leadingAnchor.constraint(equalTo: self.dispatchCheckButtonView.leadingAnchor),
            self.dispatchRefusalButton.trailingAnchor.constraint(equalTo: self.dispatchCheckButtonView.trailingAnchor),
            self.dispatchRefusalButton.topAnchor.constraint(equalTo: self.dispatchCheckButton.bottomAnchor, constant: 4),
            self.dispatchRefusalButton.heightAnchor.constraint(equalToConstant: 44),
            self.dispatchRefusalButton.bottomAnchor.constraint(equalTo: self.dispatchCheckButtonView.bottomAnchor, constant: -20),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchDocumentTableViewCell {
    func setCell() {
        // DispatchStatus
        self.dispatchStatusImageView.image = .useCustomImage("dispatchStatus.todo")
        self.dispatchStatusLabel.text = "진행전"
        
        // DispatchInfo
        self.dispatchDateLabel.text = "11.01 06:00 -> 11.01 07:00"
        self.dispatchETCLabel.text = "일반배차 | 5004"
        
        self.departureLabel.text = "성균관대역 2번 출구(고가 도로 밑 롯데어쩌구저쩌구)"
        self.arrivalLabel.text = "화성캠퍼스 H1"
        
        self.dispatchDetailButton.setTitle("상세보기", for: .normal)
    }
}

