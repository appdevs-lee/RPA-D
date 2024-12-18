//
//  HourlyWorkView.swift
//  RPA-D
//
//  Created by Awesomepia on 11/25/24.
//

import UIKit

enum RoutineType {
    case attendance // 근태
    case dispatch // 배차
}

enum RoutineText: String {
    // 제 시간 안에\n아침 점호 및 일일점검을 진행해 주세요.
    // 제 시간 안에\n운행을 준비해 주세요. 제 시간 안에\n탑승 및 운행을 시작해 주세요. 제 시간 안에\n첫 정류장에 도착해 주세요. 제 시간 안에\n다음 정류장으로 출발해 주세요. 제 시간 안에 운행을 완료해 주세요.
    // 제 시간 안에\n저녁 점호를 완료해 주세요. 수락 대기중인\n배차를 모두 확인해 주세요. 일정이 끝났습니다\n퇴근 버튼을 눌러주세요
    
    case wake = "기상 체크"
    case attendance = "아침 점호 및 일일점검"
    case dispatchReady = "운행을 준비해 주세요"
    case dispatchOn = "탑승 및 운행을 시작해 주세요"
    case arriveFirstStation = "첫 정류장에 도착해 주세요"
    case goNextStation = "다음 정류장으로 출발해 주세요"
    case dispatchOff = "운행을 종료해 주세요."
    case rollCall = "저녁 점호를 진행해 주세요"
    case dispatchCheck = "내일 배차 확인"
    case getOffWork = "퇴근"
    
    var doneString: String {
        switch self {
        case .wake:
            return "기상 체크 완료"
        case .attendance:
            return "아침 점호 및 일일점검 완료"
        case .dispatchReady:
            return "운행 준비 완료"
        case .dispatchOn:
            return "탑승 및 운행 시작 완료"
        case .arriveFirstStation:
            return "첫 정류장 대기장소 도착 완료"
        case .goNextStation:
            return "다음 정류장으로 출발 완료"
        case .dispatchOff:
            return "운행 종료"
        case .rollCall:
            return "저녁 점호 완료"
        case .dispatchCheck:
            return "배차 확인 완료"
        case .getOffWork:
            return "퇴근 완료"
        }
    }
    
    var activateString: String {
        switch self {
        case .wake:
            return "제 시간 안에\n기상 체크를 완료해 주세요"
        case .attendance:
            return "제 시간 안에\n아침 업무를 진행해 주세요"
        case .dispatchReady:
            return "제 시간 안에\n운행을 준비해 주세요"
        case .dispatchOn:
            return "제 시간 안에\n탑승 및 운행을 시작해 주세요."
        case .arriveFirstStation:
            return "제 시간 안에\n첫 정류장에 도착해 주세요"
        case .goNextStation:
            return "제 시간 안에\n운행을 완료해 주세요"
        case .dispatchOff:
            return "운행 종료"
        case .rollCall:
            return "퇴근 전에\n저녁 점호를 완료해 주세요"
        case .dispatchCheck:
            return "수락 대기중인\n배차를 모두 확인해 주세요"
        case .getOffWork:
            return "고생하셨습니다.\n퇴근을 눌러주세요."
        }
    }
    
    var targetString: String {
        switch self {
        case .wake:
            return "기상 체크"
        case .attendance:
            return "아침 업무를 진행"
        case .dispatchReady:
            return "운행을 준비"
        case .dispatchOn:
            return "탑승 및 운행을 시작"
        case .arriveFirstStation:
            return "첫 정류장에 도착"
        case .goNextStation:
            return "운행을 완료"
        case .dispatchOff:
            return "운행 종료"
        case .rollCall:
            return "저녁 점호"
        case .dispatchCheck:
            return "배차를 모두"
        case .getOffWork:
            return "퇴근"
        }
    }
    
}

class HourlyWorkView: UIView {
    
    lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var stickView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 212, green: 212, blue: 212)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.contentBaseView, self.activateContentBaseView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var contentBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var activateContentBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var activateContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var activateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("activateImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HourlyWorkView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.circleView,
            self.timeLabel,
            self.contentStackView,
//            self.contentBaseView,
//            self.activateContentBaseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.stickView,
            self.contentLabel,
        ], to: self.contentBaseView)

        SupportingMethods.shared.addSubviews([
            self.activateContentLabel,
            self.activateImageView,
        ], to: self.activateContentBaseView)
    }
    
    func setLayouts() {
        // circleView
        NSLayoutConstraint.activate([
            self.circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.circleView.centerYAnchor.constraint(equalTo: self.timeLabel.centerYAnchor),
            self.circleView.widthAnchor.constraint(equalToConstant: 8),
            self.circleView.heightAnchor.constraint(equalToConstant: 8),
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.leadingAnchor.constraint(equalTo: self.circleView.trailingAnchor, constant: 8),
            self.timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        
        // stickView
        NSLayoutConstraint.activate([
            self.stickView.topAnchor.constraint(equalTo: self.circleView.bottomAnchor, constant: 8),
            self.stickView.centerXAnchor.constraint(equalTo: self.circleView.centerXAnchor),
            self.stickView.heightAnchor.constraint(equalToConstant: 46),
            self.stickView.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        // contentStackView
        NSLayoutConstraint.activate([
            self.contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.contentStackView.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 2),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        // contentBaseView
        NSLayoutConstraint.activate([
            self.contentBaseView.heightAnchor.constraint(equalToConstant: 46),
        ])
        
        // contentLabel
        NSLayoutConstraint.activate([
            self.contentLabel.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor, constant: 16),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor, constant: 16),
            self.contentLabel.centerYAnchor.constraint(equalTo: self.contentBaseView.centerYAnchor),
        ])
        
        // activateContentBaseView
        NSLayoutConstraint.activate([
            self.activateContentBaseView.heightAnchor.constraint(equalToConstant: 72),
        ])
        
        // activateContentLabel
        NSLayoutConstraint.activate([
            self.activateContentLabel.leadingAnchor.constraint(equalTo: self.activateContentBaseView.leadingAnchor, constant: 16),
            self.activateContentLabel.topAnchor.constraint(equalTo: self.activateContentBaseView.topAnchor, constant: 10),
            self.activateContentLabel.bottomAnchor.constraint(equalTo: self.activateContentBaseView.bottomAnchor, constant: -10),
        ])
        
        // activateImageView
        NSLayoutConstraint.activate([
            self.activateImageView.leadingAnchor.constraint(equalTo: self.activateContentLabel.trailingAnchor, constant: 5),
            self.activateImageView.trailingAnchor.constraint(equalTo: self.activateContentBaseView.trailingAnchor, constant: -16),
            self.activateImageView.centerYAnchor.constraint(equalTo: self.activateContentBaseView.centerYAnchor),
            self.activateImageView.widthAnchor.constraint(equalToConstant: 40),
            self.activateImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setData(time: String, selectRoutine: RoutineText) {
        // 텍스트 및 이미지 설정
        
        self.timeLabel.text = time
        self.contentLabel.text = selectRoutine.rawValue
        // 기상,
        // 운행 준비, 탑승 및 운행을 시작해주세요, 첫 정류장에 도착해주세요, 다음 정류장으로 출발해주세요, 운행을 완료해주세요
        // 저녁 점호 확인, 내일 배차 확인, 퇴근
        
//        self.activateContentLabel.text = ""
        // 제 시간 안에\n아침 점호 및 일일점검을 진행해 주세요.
        // 제 시간 안에\n운행을 준비해 주세요. 제 시간 안에\n탑승 및 운행을 시작해 주세요. 제 시간 안에\n첫 정류장에 도착해 주세요. 제 시간 안에\n다음 정류장으로 출발해 주세요. 제 시간 안에 운행을 완료해 주세요.
        // 제 시간 안에\n저녁 점호를 완료해 주세요. 수락 대기중인\n배차를 모두 확인해 주세요. 일정이 끝났습니다\n퇴근 버튼을 눌러주세요
        
        // FIXME: Status에 따라서 활성화 및 비활성화 및 디자인
//        if false {
//            self.activate(text: "", targetString: "", color: .useRGB(red: 223, green: 52, blue: 52))
//            
//        } else {
//            self.deactivate()
//            
//        }
        
    }
    
}

// MARK: - Extension for methods added
extension HourlyWorkView {
    func on(routineType: RoutineType) {
        switch routineType {
        case .attendance:
            self.circleView.backgroundColor = .useRGB(red: 25, green: 98, blue: 255)
            
        case .dispatch:
            self.circleView.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            
        }
        self.timeLabel.textColor = .useRGB(red: 148, green: 147, blue: 147)
        self.contentLabel.textColor = .useRGB(red: 46, green: 45, blue: 45)
        
    }
    
    func off(selectRoutine: RoutineText) {
        self.deactivate()
        self.circleView.backgroundColor = .useRGB(red: 196, green: 195, blue: 195)
        
        self.timeLabel.text! += " 완료"
        self.timeLabel.textColor = .useRGB(red: 196, green: 195, blue: 195)
        
        self.contentLabel.text = selectRoutine.doneString
        self.contentLabel.textColor = .useRGB(red: 196, green: 195, blue: 195)
        
    }
    
    func activate(selectRoutine: RoutineText, routineType: RoutineType) {
        // 제 시간 안에\n아침 점호 및 일일점검을 진행해 주세요.
        // 제 시간 안에\n운행을 준비해 주세요. 제 시간 안에\n탑승 및 운행을 시작해 주세요. 제 시간 안에\n첫 정류장에 도착해 주세요. 제 시간 안에\n다음 정류장으로 출발해 주세요. 제 시간 안에 운행을 완료해 주세요.
        // 제 시간 안에\n저녁 점호를 완료해 주세요. 수락 대기중인\n배차를 모두 확인해 주세요. 일정이 끝났습니다\n퇴근 버튼을 눌러주세요
        self.activateContentBaseView.isHidden = false
        self.contentBaseView.isHidden = true
        
        self.activateContentLabel.text = selectRoutine.activateString
        switch routineType {
        case .attendance:
            self.circleView.backgroundColor = .useRGB(red: 25, green: 98, blue: 255)
            self.activateContentBaseView.backgroundColor = .useRGB(red: 238, green: 244, blue: 255)
            self.activateContentLabel.asFontColor(targetString: selectRoutine.targetString, font: .useFont(ofSize: 18, weight: .Bold), color: .useRGB(red: 25, green: 98, blue: 255))
            
        case .dispatch:
            self.circleView.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.activateContentBaseView.backgroundColor = .useRGB(red: 255, green: 245, blue: 245)
            self.activateContentLabel.asFontColor(targetString: selectRoutine.targetString, font: .useFont(ofSize: 18, weight: .Bold), color: .useRGB(red: 223, green: 52, blue: 52))
            
        }
        
    }
    
    func deactivate() {
        self.activateContentBaseView.isHidden = true
        self.contentBaseView.isHidden = false
        
    }
    
}

// MARK: - Extension for selector added
extension HourlyWorkView {
    
}
