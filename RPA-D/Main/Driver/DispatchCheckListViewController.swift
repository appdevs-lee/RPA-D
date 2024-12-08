//
//  DispatchCheckListViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/8/24.
//

import UIKit

final class DispatchCheckListViewController: UIViewController {
    
    lazy var firstDesignView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var secondDesignView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var thirdDesignView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var leftDispatchCheckLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        view.alpha = 0.0
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("dispatchCheck.done")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var coverLabel: UILabel = {
        let label = UILabel()
        label.text = "배차 수락\n완료"
        label.textColor = .white
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow(location: .bottom)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 78, green: 78, blue: 78)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 78, green: 78, blue: 78)
        label.font = .useFont(ofSize: 14, weight: .Regular)
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
        label.textColor = .useRGB(red: 58, green: 58, blue: 58)
        label.font = .useFont(ofSize: 18, weight: .Medium)
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
        label.textColor = .useRGB(red: 58, green: 58, blue: 58)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var referenceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "참조 사항"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 12, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var referenceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 161, green: 161, blue: 161)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var refusalButton: UIButton = {
        let button = UIButton()
        button.setTitle("사유서 작성", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.layer.borderColor = UIColor.useRGB(red: 148, green: 147, blue: 147).cgColor
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(refusalButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("배차 수락", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(checkButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("배차 상세", for: .normal)
        button.setTitleColor(.useRGB(red: 109, green: 109, blue: 109), for: .normal)
        button.setTitleColor(.useRGB(red: 109, green: 109, blue: 109, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Regular)
        button.addTarget(self, action: #selector(dispatchDetailButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let dispatchModel = DispatchModel()
    var dispatchList: [DispatchDailyItem]
    
    init(dispatchList: [DispatchDailyItem]) {
        self.dispatchList = dispatchList
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
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
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- DispatchCheckListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchCheckListViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.8)
        // Pop Slide
        if self.navigationController?.viewControllers.first === self  {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(refusalDone(_:)), name: Notification.Name("DispatchRefusalDone"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.thirdDesignView,
            self.secondDesignView,
            self.firstDesignView,
            self.leftDispatchCheckLabel,
            self.baseView,
            self.coverView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.timeLabel,
            self.dispatchInfoLabel,
            
            self.departureTitleButton,
            self.departureLabel,
            self.arrivalTitleButton,
            self.arrivalLabel,
            
            self.referenceTitleLabel,
            self.referenceLabel,
            
            self.refusalButton,
            self.checkButton,
            
            self.dispatchDetailButton,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.coverImageView,
            self.coverLabel,
        ], to: self.coverView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // firstDesignView
        NSLayoutConstraint.activate([
            self.firstDesignView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 10),
            self.firstDesignView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -10),
            self.firstDesignView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: 8),
            self.firstDesignView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // secondDesignView
        NSLayoutConstraint.activate([
            self.secondDesignView.leadingAnchor.constraint(equalTo: self.firstDesignView.leadingAnchor, constant: 10),
            self.secondDesignView.trailingAnchor.constraint(equalTo: self.firstDesignView.trailingAnchor, constant: -10),
            self.secondDesignView.bottomAnchor.constraint(equalTo: self.firstDesignView.bottomAnchor, constant: 8),
            self.secondDesignView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // thirdDesignView
        NSLayoutConstraint.activate([
            self.thirdDesignView.leadingAnchor.constraint(equalTo: self.secondDesignView.leadingAnchor, constant: 10),
            self.thirdDesignView.trailingAnchor.constraint(equalTo: self.secondDesignView.trailingAnchor, constant: -10),
            self.thirdDesignView.bottomAnchor.constraint(equalTo: self.secondDesignView.bottomAnchor, constant: 8),
            self.thirdDesignView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // leftDispatchCheckLabel
        NSLayoutConstraint.activate([
            self.leftDispatchCheckLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.leftDispatchCheckLabel.bottomAnchor.constraint(equalTo: self.baseView.topAnchor, constant: -24),
        ])
        
        // coverView
        NSLayoutConstraint.activate([
            self.coverView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.coverView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.coverView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.coverView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
        ])
        
        // coverImageView
        NSLayoutConstraint.activate([
            self.coverImageView.leadingAnchor.constraint(equalTo: self.coverView.leadingAnchor, constant: 20),
            self.coverImageView.topAnchor.constraint(equalTo: self.coverView.topAnchor, constant: 18),
            self.coverImageView.widthAnchor.constraint(equalToConstant: 60),
            self.coverImageView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        // coverLabel
        NSLayoutConstraint.activate([
            self.coverLabel.leadingAnchor.constraint(equalTo: self.coverView.leadingAnchor, constant: 25),
            self.coverLabel.topAnchor.constraint(equalTo: self.coverImageView.bottomAnchor, constant: 16),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.baseView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
//            self.baseView.heightAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 40) * 376 / 335)
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.timeLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 24),
        ])
        
        // dispatchInfoLabel
        NSLayoutConstraint.activate([
            self.dispatchInfoLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.dispatchInfoLabel.centerYAnchor.constraint(equalTo: self.timeLabel.centerYAnchor),
        ])
        
        // departureTitleButton
        NSLayoutConstraint.activate([
            self.departureTitleButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.departureTitleButton.centerYAnchor.constraint(equalTo: self.departureLabel.centerYAnchor),
            self.departureTitleButton.heightAnchor.constraint(equalToConstant: 22),
            self.departureTitleButton.widthAnchor.constraint(equalToConstant: 37),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureTitleButton.trailingAnchor, constant: 4),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.departureLabel.topAnchor.constraint(equalTo: self.dispatchInfoLabel.bottomAnchor, constant: 20),
        ])
        
        // arrivalTitleButton
        NSLayoutConstraint.activate([
            self.arrivalTitleButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.arrivalTitleButton.centerYAnchor.constraint(equalTo: self.arrivalLabel.centerYAnchor),
            self.arrivalTitleButton.heightAnchor.constraint(equalToConstant: 22),
            self.arrivalTitleButton.widthAnchor.constraint(equalToConstant: 37),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleButton.trailingAnchor, constant: 4),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.arrivalLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 12),
        ])
        
        // referenceTitleLabel
        NSLayoutConstraint.activate([
            self.referenceTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.referenceTitleLabel.topAnchor.constraint(equalTo: self.arrivalLabel.bottomAnchor, constant: 20),
        ])
        
        // referenceLabel
        NSLayoutConstraint.activate([
            self.referenceLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.referenceLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.referenceLabel.topAnchor.constraint(equalTo: self.referenceTitleLabel.bottomAnchor, constant: 4),
        ])
        
        // refusalButton
        NSLayoutConstraint.activate([
            self.refusalButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.refusalButton.topAnchor.constraint(equalTo: self.referenceLabel.bottomAnchor, constant: 44),
            self.refusalButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // checkButton
        NSLayoutConstraint.activate([
            self.checkButton.leadingAnchor.constraint(equalTo: self.refusalButton.trailingAnchor, constant: 8),
            self.checkButton.topAnchor.constraint(equalTo: self.refusalButton.topAnchor),
            self.checkButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.checkButton.heightAnchor.constraint(equalToConstant: 48),
            self.checkButton.widthAnchor.constraint(equalTo: self.refusalButton.widthAnchor, multiplier: 1.0),
        ])
        
        // dispatchDetailButton
        NSLayoutConstraint.activate([
            self.dispatchDetailButton.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.dispatchDetailButton.topAnchor.constraint(equalTo: self.refusalButton.bottomAnchor, constant: 12),
            self.dispatchDetailButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -28),
            self.dispatchDetailButton.heightAnchor.constraint(equalToConstant: 28),
        ])
        
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setData(completionHandler: (() -> ())? = nil) {
        if self.dispatchList.isEmpty {
            // 해당 뷰 dismiss
            self.dismiss(animated: true)
            
        } else {
            guard let firstDispatch = self.dispatchList.first else { return }
            self.leftDispatchCheckLabel.text = "총 \(self.dispatchList.count)건의 배차 요청이 있습니다"
            
            self.timeLabel.text = "\(firstDispatch.departureDate.split(separator: " ")[1]) -> \(firstDispatch.arrivalDate.split(separator: " ")[1])"
            self.dispatchInfoLabel.text = "\(firstDispatch.workType) 배차 | \(firstDispatch.busNum)"
            
            self.departureLabel.text = firstDispatch.departure
            self.arrivalLabel.text = firstDispatch.arrival
            
            // FIXME: 리스트 API 업데이트 되면, 필드로 넣어줘야 함.
            self.referenceLabel.text = "\(firstDispatch.references == "" ? "없음." : firstDispatch.references)"
            
            completionHandler?()
            
        }
        
    }
    
}

// MARK: - Extension for methods added
extension DispatchCheckListViewController {
    func sendDispatchConnectCheckDataRequest(success: (() -> ())?) {
        guard let item = self.dispatchList.first else { return }
        self.dispatchModel.sendDispatchConnectCheckDataRequest(id: item.id, workType: item.workType, check: "1") {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendDispatchConnectCheckDataRequest API error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
    }

    func loadDispatchDailyDetailRequest(id: Int, workType: String, success: ((DispatchDetailItem) -> ())?) {
        self.dispatchModel.loadDispatchDailyDetailRequest(id: id, workType: workType) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDispatchDailyDetailRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension DispatchCheckListViewController {
    @objc func checkButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.sendDispatchConnectCheckDataRequest {
            SupportingMethods.shared.turnCoverView(.off)
            UIView.transition(with: self.coverView, duration: 1.0) {
                self.coverView.alpha = 1.0
                
            } completion: { isDone in
                self.dispatchList.remove(at: 0)
                self.setData {
                    UIView.transition(with: self.coverView, duration: 1.0) {
                        self.coverView.alpha = 0.0
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    @objc func refusalButton(_ sender: UIButton) {
        guard let item = self.dispatchList.first else { return }
        let vc = RefusalReasonViewController(item: item)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refusalDone(_ notification: Notification) {
        UIView.transition(with: self.coverView, duration: 1.0) {
            self.coverView.alpha = 1.0
            
        } completion: { isDone in
            self.dispatchList.remove(at: 0)
            self.setData {
                UIView.transition(with: self.coverView, duration: 1.0) {
                    self.coverView.alpha = 0.0
                    
                }
                
            }
            
        }
    }
    
    @objc func dispatchDetailButton(_ sender: UIButton) {
        guard let item = self.dispatchList.first else { return }
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchDailyDetailRequest(id: item.id, workType: item.workType) { detailItem in
            let vc = DispatchDetailViewController(item: detailItem, departureDate: item.departureDate)
            
            self.navigationController?.pushViewController(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
        }
        
    }
    
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension DispatchCheckListViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
    
}
