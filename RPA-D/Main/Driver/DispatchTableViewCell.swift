//
//  DispatchTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 11/19/24.
//

import UIKit

final class DispatchTableViewCell: UITableViewCell {
    
    lazy var dispatchStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.dispatchTitleBaseView, self.dispatchContentBaseView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var dispatchTitleBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchTitleLabelButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("배차", for: .normal)
        button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 245, blue: 245)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var foldAndOpenButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("routine.down"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchTitleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(dispatchTitleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchContentBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 237, green: 237, blue: 237)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var sequenceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    /*
     case dispatchReady = "운행을 준비해 주세요"
     case dispatchOn = "탑승 및 운행을 시작해 주세요"
     case arriveFirstStation = "첫 정류장에 도착해 주세요"
     case goNextStation = "다음 정류장으로 출발해 주세요"
     case dispatchOff = "운행을 종료해 주세요."
     */
    
    // 운행 준비
    lazy var dispatchReadyView: HourlyWorkView = {
        let view = HourlyWorkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // 탑승 및 운행 시작
    lazy var dispatchOnView: HourlyWorkView = {
        let view = HourlyWorkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // 첫 정류장 도착
    lazy var arriveFirstStationView: HourlyWorkView = {
        let view = HourlyWorkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // 다음 정류장으로 출발
    lazy var goNextStationView: HourlyWorkView = {
        let view = HourlyWorkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // 운행 종료
    lazy var dispatchOffView: HourlyWorkView = {
        let view = HourlyWorkView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var index: Int?
    
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
extension DispatchTableViewCell {
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
            self.dispatchStackView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchTitleLabelButton,
            self.foldAndOpenButton,
            self.dispatchTitleButton,
        ], to: self.dispatchTitleBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.separateView,
            self.sequenceLabel,
            self.timeLabel,
            self.dispatchInfoView,
            self.dispatchReadyView,
            self.dispatchOnView,
            self.arriveFirstStationView,
            self.goNextStationView,
            self.dispatchOffView,
        ], to: self.dispatchContentBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.departureDateLabel,
            self.departureLabel,
            self.arrivalDateLabel,
            self.arrivalLabel,
        ], to: self.dispatchInfoView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // dispatchStackView
        NSLayoutConstraint.activate([
            self.dispatchStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.dispatchStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.dispatchStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            self.dispatchStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
        ])
        
        // dispatchTitleButton
        NSLayoutConstraint.activate([
            self.dispatchTitleButton.leadingAnchor.constraint(equalTo: self.dispatchTitleBaseView.leadingAnchor),
            self.dispatchTitleButton.trailingAnchor.constraint(equalTo: self.dispatchTitleBaseView.trailingAnchor),
            self.dispatchTitleButton.topAnchor.constraint(equalTo: self.dispatchTitleBaseView.topAnchor),
            self.dispatchTitleButton.bottomAnchor.constraint(equalTo: self.dispatchTitleBaseView.bottomAnchor),
        ])
        
        // dispatchTitleBaseView
        NSLayoutConstraint.activate([
            self.dispatchTitleBaseView.heightAnchor.constraint(equalToConstant: 62),
        ])
        
        // dispatchTitleLabelButton
        NSLayoutConstraint.activate([
            self.dispatchTitleLabelButton.leadingAnchor.constraint(equalTo: self.dispatchTitleBaseView.leadingAnchor, constant: 16),
            self.dispatchTitleLabelButton.centerYAnchor.constraint(equalTo: self.dispatchTitleBaseView.centerYAnchor),
            self.dispatchTitleLabelButton.widthAnchor.constraint(equalToConstant: 50),
            self.dispatchTitleLabelButton.heightAnchor.constraint(equalToConstant: 30),
        ])
        
        // foldAndOpenButton
        NSLayoutConstraint.activate([
            self.foldAndOpenButton.centerYAnchor.constraint(equalTo: self.dispatchTitleBaseView.centerYAnchor),
            self.foldAndOpenButton.trailingAnchor.constraint(equalTo: self.dispatchTitleBaseView.trailingAnchor, constant: -26),
            self.foldAndOpenButton.heightAnchor.constraint(equalToConstant: 24),
            self.foldAndOpenButton.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        // dispatchContentBaseView
        NSLayoutConstraint.activate([
//            self.dispatchContentBaseView.heightAnchor.constraint(equalToConstant: 294),
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.separateView.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.separateView.heightAnchor.constraint(equalToConstant: 1),
            self.separateView.topAnchor.constraint(equalTo: self.dispatchContentBaseView.topAnchor),
        ])
        
        // sequenceLabel
        NSLayoutConstraint.activate([
            self.sequenceLabel.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.sequenceLabel.topAnchor.constraint(equalTo: self.dispatchContentBaseView.topAnchor, constant: 16),
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.timeLabel.centerYAnchor.constraint(equalTo: self.sequenceLabel.centerYAnchor),
        ])
        
        // dispatchInfoView
        NSLayoutConstraint.activate([
            self.dispatchInfoView.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.dispatchInfoView.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.dispatchInfoView.topAnchor.constraint(equalTo: self.sequenceLabel.bottomAnchor, constant: 16),
        ])
        
        // departureDateLabel
        NSLayoutConstraint.activate([
            self.departureDateLabel.leadingAnchor.constraint(equalTo: self.dispatchInfoView.leadingAnchor, constant: 16),
            self.departureDateLabel.trailingAnchor.constraint(equalTo: self.dispatchInfoView.trailingAnchor, constant: -16),
            self.departureDateLabel.topAnchor.constraint(equalTo: self.dispatchInfoView.topAnchor, constant: 12),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.dispatchInfoView.leadingAnchor, constant: 16),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.dispatchInfoView.trailingAnchor, constant: -16),
            self.departureLabel.topAnchor.constraint(equalTo: self.departureDateLabel.bottomAnchor, constant: 4),
        ])
        
        // arrivalDateLabel
        NSLayoutConstraint.activate([
            self.arrivalDateLabel.leadingAnchor.constraint(equalTo: self.dispatchInfoView.leadingAnchor, constant: 16),
            self.arrivalDateLabel.trailingAnchor.constraint(equalTo: self.dispatchInfoView.trailingAnchor, constant: -16),
            self.arrivalDateLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 8),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.dispatchInfoView.leadingAnchor, constant: 16),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.dispatchInfoView.trailingAnchor, constant: -16),
            self.arrivalLabel.topAnchor.constraint(equalTo: self.arrivalDateLabel.bottomAnchor, constant: 4),
            self.arrivalLabel.bottomAnchor.constraint(equalTo: self.dispatchInfoView.bottomAnchor, constant: -12),
        ])
        
        // dispatchReadyView
        NSLayoutConstraint.activate([
            self.dispatchReadyView.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.dispatchReadyView.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.dispatchReadyView.topAnchor.constraint(equalTo: self.dispatchInfoView.bottomAnchor, constant: 16),
        ])
        
        // dispatchOnView
        NSLayoutConstraint.activate([
            self.dispatchOnView.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.dispatchOnView.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.dispatchOnView.topAnchor.constraint(equalTo: self.dispatchReadyView.bottomAnchor, constant: 16),
        ])
        
        // arriveFirstStationView
        NSLayoutConstraint.activate([
            self.arriveFirstStationView.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.arriveFirstStationView.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.arriveFirstStationView.topAnchor.constraint(equalTo: self.dispatchOnView.bottomAnchor, constant: 16),
        ])
        
        // goNextStationView
        NSLayoutConstraint.activate([
            self.goNextStationView.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.goNextStationView.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.goNextStationView.topAnchor.constraint(equalTo: self.arriveFirstStationView.bottomAnchor, constant: 16),
        ])
        
        // dispatchOffView
        NSLayoutConstraint.activate([
            self.dispatchOffView.leadingAnchor.constraint(equalTo: self.dispatchContentBaseView.leadingAnchor, constant: 16),
            self.dispatchOffView.trailingAnchor.constraint(equalTo: self.dispatchContentBaseView.trailingAnchor, constant: -16),
            self.dispatchOffView.topAnchor.constraint(equalTo: self.goNextStationView.bottomAnchor, constant: 16),
            self.dispatchOffView.bottomAnchor.constraint(equalTo: self.dispatchContentBaseView.bottomAnchor, constant: -16),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchTableViewCell {
    func setCell(index: Int, dispatch: RoutineDispatch?) {
        self.index = index
        self.sequenceLabel.text = "\(index + 1)번째 배차"
        
        if self.dispatchContentBaseView.isHidden == true {
            self.foldAndOpenButton.setImage(.useCustomImage("routine.down"), for: .normal)
            self.dispatchTitleBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            
        } else {
            self.foldAndOpenButton.setImage(.useCustomImage("routine.up"), for: .normal)
            self.dispatchTitleBaseView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            
        }
        
        guard let dispatch = dispatch else { return }
        self.timeLabel.text = "\(dispatch.departureDate.split(separator: " ")[1]) -> \(dispatch.arrivalDate.split(separator: " ")[1])"
        
        self.departureDateLabel.text = "\(SupportingMethods.shared.convertString(intoCustomString: dispatch.departureDate, "MM/dd HH:mm")) 출발"
        self.departureLabel.text = dispatch.departure
        
        self.arrivalDateLabel.text = "\(SupportingMethods.shared.convertString(intoCustomString: dispatch.arrivalDate, "MM/dd HH:mm")) 도착"
        self.arrivalLabel.text = dispatch.arrival
        
        let departureDate = SupportingMethods.shared.convertString(intoDate: dispatch.departureDate, "yyyy-MM-dd HH:mm")
        let arrivalDate = SupportingMethods.shared.convertString(intoDate: dispatch.arrivalDate, "yyyy-MM-dd HH:mm")
        
        self.dispatchReadyView.setData(time: SupportingMethods.shared.calculateDateAsTimeInterval(date: departureDate, second: .anHourAndAHalfAgo), selectRoutine: .dispatchReady)
        self.dispatchOnView.setData(time: SupportingMethods.shared.calculateDateAsTimeInterval(date: departureDate, second: .aHourAgo), selectRoutine: .dispatchOn)
        self.arriveFirstStationView.setData(time: SupportingMethods.shared.calculateDateAsTimeInterval(date: departureDate, second: .twentyMintesAgo), selectRoutine: .arriveFirstStation)
        self.goNextStationView.setData(time: SupportingMethods.shared.convertDate(intoString: departureDate, "a HH:mm"), selectRoutine: .goNextStation)
        self.dispatchOffView.setData(time: SupportingMethods.shared.convertDate(intoString: arrivalDate, "a HH:mm"), selectRoutine: .dispatchOff)
        
        self.dispatchReadyView.on(routineType: .dispatch)
        self.dispatchOnView.on(routineType: .dispatch)
        self.arriveFirstStationView.on(routineType: .dispatch)
        self.goNextStationView.on(routineType: .dispatch)
        self.dispatchOffView.on(routineType: .dispatch)
        
        // 운행 전(현재), 운행 준비, 탑승 및 운행 시작, 첫 정류장 도착, 운행 출발, 운행 중, 운행 종료, 운행 완료
        if dispatch.status == "운행 전" {
            
        } else if dispatch.status == "운행 준비" {
            self.dispatchReadyView.activate(selectRoutine: .dispatchReady, routineType: .dispatch)
            
        } else if dispatch.status == "탑승 및 운행 시작" {
            self.dispatchReadyView.off(selectRoutine: .dispatchReady)
            self.dispatchOnView.activate(selectRoutine: .dispatchReady, routineType: .dispatch)
            
        } else if dispatch.status == "첫 정류장 도착" {
            self.dispatchReadyView.off(selectRoutine: .dispatchReady)
            self.dispatchOnView.off(selectRoutine: .dispatchOn)
            self.arriveFirstStationView.activate(selectRoutine: .arriveFirstStation, routineType: .dispatch)
            
        } else if dispatch.status == "운행 출발" {
            self.dispatchReadyView.off(selectRoutine: .dispatchReady)
            self.dispatchOnView.off(selectRoutine: .dispatchOn)
            self.arriveFirstStationView.off(selectRoutine: .arriveFirstStation)
            self.goNextStationView.activate(selectRoutine: .goNextStation, routineType: .dispatch)
            
        } else if dispatch.status == "운행 중" {
            self.dispatchReadyView.off(selectRoutine: .dispatchReady)
            self.dispatchOnView.off(selectRoutine: .dispatchOn)
            self.arriveFirstStationView.off(selectRoutine: .arriveFirstStation)
            self.goNextStationView.activate(selectRoutine: .goNextStation, routineType: .dispatch)
            
        } else if dispatch.status == "운행 종료" {
            self.dispatchReadyView.off(selectRoutine: .dispatchReady)
            self.dispatchOnView.off(selectRoutine: .dispatchOn)
            self.arriveFirstStationView.off(selectRoutine: .arriveFirstStation)
            self.goNextStationView.off(selectRoutine: .goNextStation)
            self.dispatchOffView.off(selectRoutine: .dispatchOff)
        }
        
    }
}

// MARK: - Extension for methods added
extension DispatchTableViewCell {
    @objc func dispatchTitleButton(_ sender: UIButton) {
        guard let index = self.index else { return }
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: nil, userInfo: ["index": index])
        
    }
    
}
