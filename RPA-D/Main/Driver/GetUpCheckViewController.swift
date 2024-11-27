//
//  GetUpCheckViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 11/12/24.
//

import UIKit

final class GetUpCheckViewController: UIViewController {
    
    lazy var timerBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("TimerBackground")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if !self.routine.tasks.isEmpty {
            guard let firstDispatch = self.routine.tasks.first else {
                label.text = "하루를 시작합니다."
                return label
            }
            let date = SupportingMethods.shared.convertString(intoDate: firstDispatch!.departureDate, "yyyy-MM-dd HH:mm")
            label.text = "점호지 도착 시간\n\(SupportingMethods.shared.calculateDateAsTimeInterval(date: date, second: .aHourAgo))"
            
        } else {
            label.text = "금일 배차가 없습니다!"
            
        }
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기상 버튼을 눌러주세요"
        label.textColor = .white
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "기상 버튼을 클릭해야 기상 시간이 기록됩니다"
        label.textColor = .useRGB(red: 196, green: 195, blue: 195)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var getUpButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 20, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 38
        button.addTarget(self, action: #selector(getUpButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if !self.routine.tasks.isEmpty {
            button.setTitle("기상", for: .normal)
            
        } else {
            button.setTitle("홈", for: .normal)
            
        }
        
        return button
    }()
    
    let dispatchModel = DispatchModel()
    var routine: RoutineItem
    
    init(routine: RoutineItem) {
        self.routine = routine
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- GetUpCheckViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension GetUpCheckViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .black
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.timerBackgroundImageView,
            self.timerLabel,
            self.titleLabel,
            self.contentLabel,
            self.getUpButton,
        ], to: self.view)
        
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // timerBackgroundImageView
        NSLayoutConstraint.activate([
            self.timerBackgroundImageView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width),
            self.timerBackgroundImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.timerBackgroundImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.timerBackgroundImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 108),
        ])
        
        // timerLabel
        NSLayoutConstraint.activate([
            self.timerLabel.centerXAnchor.constraint(equalTo: self.timerBackgroundImageView.centerXAnchor),
            self.timerLabel.centerYAnchor.constraint(equalTo: self.timerBackgroundImageView.centerYAnchor),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 72),
            self.titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -72),
            self.titleLabel.topAnchor.constraint(equalTo: self.timerBackgroundImageView.bottomAnchor, constant: -35),
        ])
        
        // contentLabel
        NSLayoutConstraint.activate([
            self.contentLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            self.contentLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -40),
            self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8)
        ])
        
        // getUpButton
        NSLayoutConstraint.activate([
            self.getUpButton.heightAnchor.constraint(equalToConstant: 76),
            self.getUpButton.widthAnchor.constraint(equalToConstant: 76),
            self.getUpButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.getUpButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension GetUpCheckViewController {
    func sendDispatchInfoUpdateRequest(id: Int, workType: String, type: String, time: String, success: (() -> ())?) {
        self.dispatchModel.sendDispatchInfoUpdateRequest(id: id, workType: workType, type: type, time: time) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendDispatchInfoUpdateRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension GetUpCheckViewController {
    @objc func getUpButton(_ sender: UIButton) {
        if !self.routine.tasks.isEmpty {
            // 기상
            guard let firstDispatch = self.routine.tasks.first else { return }
            guard let dispatchId = firstDispatch?.dispatchId else { return }
            guard let workType = firstDispatch?.workType else { return }
            
            let time = SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm")
            self.sendDispatchInfoUpdateRequest(id: dispatchId, workType: workType, type: "운행 준비", time: time) {
                self.dismiss(animated: true) {
                    SupportingMethods.shared.showAlertNoti(title: "기상이 완료되었습니다!\n아침 점호를 진행해주세요!")
                    NotificationCenter.default.post(name: Notification.Name("ReloadAllData"), object: nil)
                    
                }
                
            }
            
        } else {
            // 홈
            self.dismiss(animated: true)
            
        }
        
    }
}

