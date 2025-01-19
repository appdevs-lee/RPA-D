//
//  StatusView.swift
//  RPA-D
//
//  Created by Awesomepia on 11/26/24.
//
import UIKit

enum RoutineStatus: String {
    case dispatchOn = "탑승 및 운행 시작"
    case morningDispatchDocument = "운행 일보 작성(출발)"
    case arriveFirstStation = "첫 정류장 도착"
    case dispatchReady = "운행 준비"
    case goNextStation = "운행 출발"
    case dispatchRunning = "운행 중"
    case eveningDispatchDocument = "운행 일보 작성(도착)"
    case dispatchOff = "운행 종료"
    case eveningRollCall = "저녁 점호"
    case dispatchCheck = "배차 확인"
    case getOffWork = "퇴근"
    
    var title: String {
        switch self {
        case .dispatchOn:
            return "탑승을 완료한 뒤\n운행을 시작해 주세요"
        case .morningDispatchDocument:
            return "운행 일보를\n작성해 주세요"
        case .arriveFirstStation:
            return "제 시간 안에\n첫 정류장에 도착해 주세요"
        case .dispatchReady:
            return "다음 운행을\n준비해 주세요"
        case .goNextStation:
            return "다음 정류장으로\n출발해 주세요"
        case .dispatchRunning:
            return "현재 배차\n진행중입니다"
        case .dispatchOff:
            return "운행을\n종료해 주세요"
        case .eveningRollCall:
            return "저녁 점호 시간 입니다\n점호를 진행해 주세요"
        case .dispatchCheck:
            return "수락 대기중인\n배차를 확인해 주세요"
        case .getOffWork:
            return "일정이 완료됐습니다\n퇴근 버튼을 눌러 주세요"
        case .eveningDispatchDocument:
            return "운행 일보를\n작성해 주세요"
        }
    }
    
    var subTitle: String {
        switch self {
        case .dispatchOn:
            return "탑승 및 운행 시작 버튼을 눌러 관리자에게 알려 주세요"
        case .morningDispatchDocument:
            return "운행 일보를 끝까지 작성해 주세요"
        case .arriveFirstStation:
            return "도착 버튼을 누르면 관리자에게 알림이 전송 됩니다"
        case .dispatchReady:
            return ""
        case .goNextStation:
            return "다음 정류장으로 안전히 운행해 주세요"
        case .dispatchRunning:
            return "운행모드로 돌아가 운행을 완료해 주세요"
        case .dispatchOff:
            return "운행이 종료됨을 관리자에게 알리고 운행 일보를 작성해 주세요"
        case .eveningRollCall:
            return "저녁 점호를 빠짐없이 작성해 주세요"
        case .dispatchCheck:
            return "배차를 모두 수락해야 합니다"
        case .getOffWork:
            return "퇴근 기록을 위해 버튼을 눌러 주세요"
        case .eveningDispatchDocument:
            return "운행 일보를 끝까지 작성해 주세요"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .dispatchOn:
            return "탑승 및 운행 시작"
        case .morningDispatchDocument:
            return "운행 일보 작성"
        case .arriveFirstStation:
            return "첫 정류장 대기장소 도착"
        case .dispatchReady:
            return "다음 운행 준비"
        case .goNextStation:
            return "다음 정류장으로 출발"
        case .dispatchRunning:
            return "운행 모드"
        case .dispatchOff:
            return "운행 종료"
        case .eveningRollCall:
            return "저녁 점호"
        case .dispatchCheck:
            return "배차 확인"
        case .getOffWork:
            return "퇴근"
        case .eveningDispatchDocument:
            return "운행 일보 작성"
        }
    }
    
    var imageName: String {
        switch self {
        case .dispatchOn:
            return "dispatchOnStatusImage"
        case .morningDispatchDocument:
            return "DispatchDocumentStatusImage"
        case .arriveFirstStation:
            return "arriveFirstStationStatusImage"
        case .dispatchReady:
            return "dispatchReadyStatusImage"
        case .goNextStation:
            return "goNextStationStatusImage"
        case .dispatchRunning:
            return "dispatchRunningStatusImage"
        case .dispatchOff:
            return "dipspatchOffStatusImage"
        case .eveningRollCall:
            return "eveningRollCallStatusImage"
        case .dispatchCheck:
            return "dispatchCheckStatusImage"
        case .getOffWork:
            return "getOffWorkStatusImage"
        case .eveningDispatchDocument:
            return "DispatchDocumentStatusImage"
        }
    }
}

class StatusView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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

extension StatusView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.subTitleLabel,
            self.statusImageView,
            self.statusButton,
        ], to: self)
    }
    
    func setLayouts() {
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 29),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 33),
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -48),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
        ])
        
        // statusImageView
        NSLayoutConstraint.activate([
            self.statusImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.statusImageView.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -12),
            self.statusImageView.widthAnchor.constraint(equalToConstant: 138),
            self.statusImageView.heightAnchor.constraint(equalToConstant: 138),
        ])
        
        // statusButton
        NSLayoutConstraint.activate([
            self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32),
            self.statusButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    /*
     1. 아침 점호 및 일일 점검 => 해당 부분도 상단 info 데이터 줘야함.
         a. 이 상태에 대한 임시 적용법 : 첫 배차의 status가 '탑승 및 운행 시작'이고, 일일점검 submit_check가 false면 해당 status임.
     2. 탑승 및 운행 시작 => 여기부터 운행 종료까지 info 값들 줘야함.
     3. 운행 일보 작성(출발)
     4. 첫 정류장 도착
     5. 운행 출발
     6. 운행중
     7. 운행 일보 작성(도착, 인원수)
     8. 운행 종료

     # 첫 배차 제외한 다른 배차 기준
     1. 운행 준비 => 여기부터 운행 종료까지 info 값들 줘야함.
     2. 탑승 및 운행 시작
     3. 운행 일보 작성(출발)
     4. 첫 정류장 도착
     5. 운행 출발
     6. 운행중
     7. 운행 일보 작성(도착, 인원수)
     8. 운행 종료
     
     9. 저녁 점호
     10. 배차 확인
     11. 퇴근        
     */
    func setData(status: String, routine: RoutineItem?, inspectionCheck: Bool = true) {
        self.reloadData(status: status, routine: routine, inspectionCheck: inspectionCheck)
        
    }
    
    // FIXME: 삭제
    func setTempData() {
        
    }
    
}

// MARK: - Extension for methods added
extension StatusView {
    func reloadData(status: String, routine: RoutineItem?, inspectionCheck: Bool = true) {
        guard let routine = routine else { return }
        
        if status == "운행 전" {
            // 첫번째 배차는 아님
            self.titleLabel.text = "현재 지정된 배차가\n없습니다."
            self.subTitleLabel.text = "이후 배차를 확인해 주세요."
            self.statusImageView.image = .useCustomImage(RoutineStatus.dispatchReady.imageName)
            self.statusButton.setTitle(RoutineStatus.dispatchReady.buttonTitle, for: .normal)
            self.statusButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.statusButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        } else if status == "" {
            self.titleLabel.text = "관리자에게\n퇴근 기록을 전송했습니다."
            self.subTitleLabel.text = "오늘도 고생 많으셨습니다!"
            self.statusImageView.image = .useCustomImage(RoutineStatus.getOffWork.imageName)
            self.statusButton.setTitle("퇴근 완료", for: .normal)
            self.statusButton.isEnabled = false
            self.statusButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.statusButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        } else {
            self.statusButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.statusButton.setTitleColor(.white, for: .normal)
            
            switch RoutineStatus(rawValue: status) {
            case .dispatchReady:
                self.titleLabel.text = RoutineStatus.dispatchReady.title
                self.subTitleLabel.text = RoutineStatus.dispatchReady.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.dispatchReady.imageName)
                self.statusButton.setTitle(RoutineStatus.dispatchReady.buttonTitle, for: .normal)
                
            case .dispatchOn:
                if inspectionCheck {
                    // 탑승 및 운행 시작
                    self.titleLabel.text = RoutineStatus.dispatchOn.title
                    self.subTitleLabel.text = RoutineStatus.dispatchOn.subTitle
                    self.statusImageView.image = .useCustomImage(RoutineStatus.dispatchOn.imageName)
                    self.statusButton.setTitle(RoutineStatus.dispatchOn.buttonTitle, for: .normal)
                    
                } else {
                    // 아침 점호 및 일일점검
                    self.titleLabel.text = "아침 업무를 진행해 주세요"
                    self.subTitleLabel.text = "아침 점호 및 일일점검을 완료해야\n출근이 기록됩니다."
                    self.statusImageView.image = .useCustomImage("morninigRollCallStatusImage")
                    self.statusButton.setTitle("아침 점호 및 일일점검", for: .normal)
                    
                }
                
            case .morningDispatchDocument:
                // 운행 일보 작성
                self.titleLabel.text = RoutineStatus.morningDispatchDocument.title
                self.subTitleLabel.text = RoutineStatus.morningDispatchDocument.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.morningDispatchDocument.imageName)
                self.statusButton.setTitle(RoutineStatus.morningDispatchDocument.buttonTitle, for: .normal)
                
            case .arriveFirstStation:
                // 첫 정류장 도착
                self.titleLabel.text = RoutineStatus.arriveFirstStation.title
                self.subTitleLabel.text = RoutineStatus.arriveFirstStation.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.arriveFirstStation.imageName)
                self.statusButton.setTitle(RoutineStatus.arriveFirstStation.buttonTitle, for: .normal)
                
            case .goNextStation:
                // 운행 출발
                self.titleLabel.text = RoutineStatus.goNextStation.title
                self.subTitleLabel.text = RoutineStatus.goNextStation.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.goNextStation.imageName)
                self.statusButton.setTitle(RoutineStatus.goNextStation.buttonTitle, for: .normal)
                
            case .dispatchRunning:
                // 운행중
                self.titleLabel.text = RoutineStatus.dispatchRunning.title
                self.subTitleLabel.text = RoutineStatus.dispatchRunning.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.dispatchRunning.imageName)
                self.statusButton.setTitle(RoutineStatus.dispatchRunning.buttonTitle, for: .normal)
                
            case .eveningDispatchDocument:
                // 운행 일보 작성
                self.titleLabel.text = RoutineStatus.eveningDispatchDocument.title
                self.subTitleLabel.text = RoutineStatus.eveningDispatchDocument.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.eveningDispatchDocument.imageName)
                self.statusButton.setTitle(RoutineStatus.morningDispatchDocument.buttonTitle, for: .normal)
                
            case .dispatchOff:
                // 운행종료
                self.titleLabel.text = RoutineStatus.dispatchOff.title
                self.subTitleLabel.text = RoutineStatus.dispatchOff.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.dispatchOff.imageName)
                self.statusButton.setTitle(RoutineStatus.dispatchOff.buttonTitle, for: .normal)
                
            case .eveningRollCall:
                // 저녁점호
                self.titleLabel.text = RoutineStatus.eveningRollCall.title
                self.subTitleLabel.text = RoutineStatus.eveningRollCall.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.eveningRollCall.imageName)
                self.statusButton.setTitle(RoutineStatus.eveningRollCall.buttonTitle, for: .normal)
                
            case .dispatchCheck:
                // 배차 확인
                self.titleLabel.text = RoutineStatus.dispatchCheck.title
                self.subTitleLabel.text = RoutineStatus.dispatchCheck.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.dispatchCheck.imageName)
                self.statusButton.setTitle(RoutineStatus.dispatchCheck.buttonTitle, for: .normal)
                
            case .getOffWork:
                // 퇴근
                self.titleLabel.text = RoutineStatus.getOffWork.title
                self.subTitleLabel.text = RoutineStatus.getOffWork.subTitle
                self.statusImageView.image = .useCustomImage(RoutineStatus.getOffWork.imageName)
                self.statusButton.setTitle(RoutineStatus.getOffWork.buttonTitle, for: .normal)
                
            default: break
                
            }
            
        }
        
    }
    
}

// MARK: - Extension for selector added
extension StatusView {
    
}
