//
//  MainViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    lazy var noRoutineDataBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 229, green: 229, blue: 229)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var noRoutineDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noRoutineDataImageView, self.noRoutineDataTitleLabel, self.noRoutineDataSubTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var noRoutineDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("noRoutineDataImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var noRoutineDataTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 일정이 없어요"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var noRoutineDataSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "좋은 하루 되세요!"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var statusView: StatusView = {
        let view = StatusView()
        view.statusButton.addTarget(self, action: #selector(statusButton(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(WorkRateTableViewCell.self, forCellReuseIdentifier: "WorkRateTableViewCell")
        tableView.register(GoToWorkTableViewCell.self, forCellReuseIdentifier: "GoToWorkTableViewCell")
        tableView.register(DispatchTableViewCell.self, forCellReuseIdentifier: "DispatchTableViewCell")
        tableView.register(GetOffWorkTableViewCell.self, forCellReuseIdentifier: "GetOffWorkTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchNoteView: DispatchNoteView = {
        let view = DispatchNoteView()
        view.isHidden = true
        view.sendButton.addTarget(self, action: #selector(dispatchNoteSendButton(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var dispatchIsHiddenStatus: [Bool] = []
    var role: Role = .driver
    
    let mainModel = MainModel()
    let dispatchModel = DispatchModel()
    var routine: RoutineItem?
    var goToWorkData: RoutineGoToWork?
    var dispatchList: [RoutineDispatch?] = []
    var getOffWorkData: RoutineGetOffWork?
    var isLeftDispatchCheck: Bool = false
    
    var dispatchNoteViewBottomAnchorConstraint: NSLayoutConstraint!
    
    init() {
        switch User.shared.role {
        case "운전원":
            self.role = .driver
            
        case "팀장":
            self.role = .driverLeader
            
        default:
            break
        }
        
        super.init(nibName: nil, bundle: nil)
        
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
        self.setUpNavigationItem()
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    deinit {
        print("----------------------------------- MainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension MainViewController: EssentialViewMethods {
    func setViewFoundation() {
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: Notification.Name("ReloadData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(workReloadData(_:)), name: Notification.Name("WorkReloadData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAllData(_:)), name: Notification.Name("ReloadAllData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openDailyInspection(_:)), name: Notification.Name("OpenDailyInspection"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.statusBaseView,
            self.tableView,
            self.noRoutineDataBaseView,
            self.backgroundView,
            self.dispatchNoteView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.statusView,
        ], to: self.statusBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.noRoutineDataStackView,
        ], to: self.noRoutineDataBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // statusBaseView
        NSLayoutConstraint.activate([
            self.statusBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.statusBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.statusBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.statusBaseView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 236 / 375),
        ])
        
        // statusView
        NSLayoutConstraint.activate([
            self.statusView.leadingAnchor.constraint(equalTo: self.statusBaseView.leadingAnchor),
            self.statusView.bottomAnchor.constraint(equalTo: self.statusBaseView.bottomAnchor),
            self.statusView.topAnchor.constraint(equalTo: self.statusBaseView.topAnchor),
            self.statusView.trailingAnchor.constraint(equalTo: self.statusBaseView.trailingAnchor),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.statusBaseView.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // noRoutineDataBaseView
        NSLayoutConstraint.activate([
            self.noRoutineDataBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.noRoutineDataBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.noRoutineDataBaseView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.noRoutineDataBaseView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // noRoutineDataStackView
        NSLayoutConstraint.activate([
            self.noRoutineDataStackView.centerYAnchor.constraint(equalTo: self.noRoutineDataBaseView.centerYAnchor),
            self.noRoutineDataStackView.leadingAnchor.constraint(equalTo: self.noRoutineDataBaseView.leadingAnchor),
            self.noRoutineDataStackView.trailingAnchor.constraint(equalTo: self.noRoutineDataBaseView.trailingAnchor),
        ])
        
        // noRoutineDataImageView
        NSLayoutConstraint.activate([
            self.noRoutineDataImageView.heightAnchor.constraint(equalToConstant: 80),
            self.noRoutineDataImageView.widthAnchor.constraint(equalToConstant: 80),
        ])
        
        // backgroundView
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // dispatchNoteView
        self.dispatchNoteViewBottomAnchorConstraint = self.dispatchNoteView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate([
            self.dispatchNoteView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.dispatchNoteView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.dispatchNoteViewBottomAnchorConstraint,
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = ""
        
        // FIXME: action 삭제 필수
        switch self.role {
        case .manager:
            let leftBarButtonItem = UIBarButtonItem(title: "노선", style: .plain, target: self, action: nil)
            leftBarButtonItem.setTitleTextAttributes([
                .font:UIFont.useFont(ofSize: 20, weight: .Bold),
                .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
            ], for: .normal)
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            
        default:
            let leftBarButtonItem = UIBarButtonItem(title: "운행", style: .plain, target: self, action: nil)
            leftBarButtonItem.setTitleTextAttributes([
                .font:UIFont.useFont(ofSize: 20, weight: .Bold),
                .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
            ], for: .normal)
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            
        }
        
    }
    
    func setData(status: String? = nil) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDailyRoutineDataRequest { item in
            self.continueCheckDispatchCheckData { isLeftDispatchCheck in
                if !isLeftDispatchCheck {
                    print("routine Item: \(item)")
                    self.routine = item
                    
                    if item.tasks.isEmpty {
                        self.noRoutineDataBaseView.isHidden = false
                        
                    } else {
                        self.noRoutineDataBaseView.isHidden = true
                        
                        self.goToWorkData = item.goToWork
                        self.dispatchList = item.tasks
                        self.getOffWorkData = item.getOffWork
                        
                        self.dispatchIsHiddenStatus = Array(repeating: true, count: self.dispatchList.count)
                        self.statusView.setData(status: item.status, routine: item)
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            SupportingMethods.shared.turnCoverView(.off)
                        }
                        
                    }
                    
                    if item.goToWork.wakeTime == "" {
                        let vc = GetUpCheckViewController(routine: item)
                        
                        self.present(vc, animated: false)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func continueCheckDispatchCheckData(completionHandler: ((_ isLeftDispatchCheck: Bool) -> ())? = nil) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchDailyListRequest { dispatchList in
            SupportingMethods.shared.turnCoverView(.off)
            if dispatchList.isEmpty {
                // 배차 수락 건너뛰기.
                // 내일 배차 없음.
                print("내일 배차 없음.")
                self.isLeftDispatchCheck = false
                completionHandler?(false)
                
            } else {
                let checkList = dispatchList.filter({ $0.connectCheck == "" })
                if checkList.isEmpty {
                    // 배차 수락 전부 진행함.
                    print("전부 수락함.")
                    self.isLeftDispatchCheck = false
                    completionHandler?(false)
                    
                } else {
                    // 배차 수락 안 한 건 있음.
                    let vc = CustomizedNavigationController(rootViewController: DispatchCheckListViewController(dispatchList: checkList))
                    
                    self.present(vc, animated: true) {
                        print("수락 안한 배차 개수: \(checkList.count)")
                        self.isLeftDispatchCheck = true
                        completionHandler?(true)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

// MARK: - Extension for methods added
extension MainViewController {
    func loadDailyRoutineDataRequest(success: ((RoutineItem) -> ())?) {
        self.mainModel.loadDailyRoutineDataRequest { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDailyRoutineDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        }

    }
    
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
    
    func updateDrivingHistoryRequest(id: Int, workType: String, departureKM: String, passengerNum: Int = 0, success: (() -> ())?) {
        self.dispatchModel.updateDrivingHistoryRequest(id: id, workType: workType, departureKM: departureKM, passengerNum: passengerNum) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("updateDrivingHistoryRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadMorningRollCallDataRequest(success: ((Bool) -> ())?) {
        self.dispatchModel.loadMorningRollCallDataRequest { item in
            success?(item.submitCheck)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadMorningRollCallDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadDispatchDailyListRequest(success: (([DispatchDailyItem]) -> ())?) {
        let checkHour = String(SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd HH:mm").split(separator: " ")[1].split(separator: ":")[0])
        var date = ""
        if Int(checkHour)! < 04 {
            // 오늘 기준 새벽 4시 전이면, 당일 날짜 체크
            date = SupportingMethods.shared.convertDate(intoString: Date())
            
        } else {
            // 오늘 기준 새벽 4시 이후면, 다음 날 날짜 체크
            date = SupportingMethods.shared.convertDate(intoString: Date(timeIntervalSinceNow: 86400))
            
        }
        
        self.dispatchModel.loadDispatchDailyListRequest(date: date) { dispatchList in
            success?(dispatchList)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDispatchDailyListRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func sendGetOffWorkDataRequest(statusType: String, success: (() -> ())?) {
        self.mainModel.sendGetOffWorkDataRequest(statusType: statusType) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDispatchDailyListRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension MainViewController {
    @objc func reloadData(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        
        self.dispatchIsHiddenStatus[index].toggle()
        self.tableView.reloadData()
//        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
    }
    
    @objc func workReloadData(_ notification: Notification) {
        self.tableView.reloadData()
        
    }
    
    @objc func reloadAllData(_ notification: Notification) {
        self.setData()
        
    }
    
    @objc func openDailyInspection(_ notification: Notification) {
        guard let firstDispatch = self.routine?.tasks.first else { return }
        guard let busId = firstDispatch?.busId else { return }
        let vc = DailyInspectionViewController(busId: busId)
        
        self.present(vc, animated: false)
    }
    
    @objc func statusButton(_ sender: UIButton) {
        guard let routine = self.routine else { return }
        
        switch RoutineStatus(rawValue: routine.status) {
        case .dispatchReady, .dispatchOff:
            // 운행 준비, 운행 종료
            SupportingMethods.shared.turnCoverView(.on)
            self.sendDispatchInfoUpdateRequest(id: routine.info.dispatchId!, workType: routine.info.workType!, type: routine.info.status, time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm")) {
                self.setData()
                
            }
            break
        case .arriveFirstStation:
            // 첫 정류장 도착
            SupportingMethods.shared.turnCoverView(.on)
            self.sendDispatchInfoUpdateRequest(id: routine.info.dispatchId!, workType: routine.info.workType!, type: routine.info.status, time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm")) {
                self.setData()
                
            }
            break
        case .goNextStation:
            // 다음 정류장으로 출발(운행 출발)
            SupportingMethods.shared.turnCoverView(.on)
            self.sendDispatchInfoUpdateRequest(id: routine.info.dispatchId!, workType: routine.info.workType!, type: routine.info.status, time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm")) {
                self.setData()
                self.loadDispatchDailyDetailRequest(id: routine.info.dispatchId!, workType: routine.info.workType!) { detailItem in
                    let vc = DispatchDetailViewController(isRunning: true, item: detailItem, departureDate: routine.info.departureTime)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
            }
            break
        case  .dispatchOn:
            if routine.goToWork.attendanceTime == "" {
                // 아침점호 진행
                SupportingMethods.shared.turnCoverView(.on)
                self.loadMorningRollCallDataRequest { submitCheck in
                    if submitCheck {
                        guard let firstDispatch = self.routine?.tasks.first else { return }
                        guard let busId = firstDispatch?.busId else { return }
                        let vc = DailyInspectionViewController(busId: busId)
                        
                        self.present(vc, animated: false)
                        
                    } else {
                        let vc = MorningRollCallViewController()
                        
                        self.present(vc, animated: true)
                        
                    }
                    
                }
                
            } else {
                let vc = AlertPopViewController(.normalTwoButton(messageTitle: "운행을 시작하시겠습니까?", messageContent: "확인을 누르고, 계기판 KM를 작성해주세요.", leftButtonTitle: "아니오", leftAction: { }, rightButtonTitle: "네", rightAction: {
                    self.sendDispatchInfoUpdateRequest(id: routine.info.dispatchId!, workType: routine.info.workType!, type: routine.info.status, time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm")) {
                        // 운행 일보 작성 화면 표시
                        self.backgroundView.isHidden = false
                        self.dispatchNoteView.isHidden = false
                        self.dispatchNoteView.dashboardTextField.becomeFirstResponder()
                        self.setData()
                        
                    }
                }))
                
                self.present(vc, animated: true)
                
            }
            
            break
        case .morningDispatchDocument:
            // 운행 일보 작성(출발)
            self.backgroundView.isHidden = false
            self.dispatchNoteView.isHidden = false
            self.dispatchNoteView.dashboardTextField.becomeFirstResponder()
            break
            
        case .dispatchRunning:
            // 운행중
            self.loadDispatchDailyDetailRequest(id: routine.info.dispatchId!, workType: routine.info.workType!) { detailItem in
                let vc = DispatchDetailViewController(isRunning: true, item: detailItem, departureDate: routine.info.departureTime)
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            break
            
        case .eveningDispatchDocument:
            // 운행 일보 작성(도착)
            self.loadDispatchDailyDetailRequest(id: routine.info.dispatchId!, workType: routine.info.workType!) { detailItem in
                let vc = DispatchDetailViewController(isRunning: true, item: detailItem, departureDate: routine.info.departureTime)
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            break
            
        case .eveningRollCall:
            // 저녁 점호
            let vc = EveningRollCallViewController()
            
            self.present(vc, animated: true)
            break
            
        case .dispatchCheck:
            // 배차 확인
            SupportingMethods.shared.turnCoverView(.on)
            self.loadDispatchDailyListRequest { dispatchList in
                SupportingMethods.shared.turnCoverView(.off)
                if dispatchList.isEmpty {
                    // 배차 수락 건너뛰기.
                    // 내일 배차 없음.
                    self.sendGetOffWorkDataRequest(statusType: "배차 확인") {
                        self.setData()
                        
                    }
                    
                } else {
                    let checkList = dispatchList.filter({ $0.connectCheck == "" })
                    if checkList.isEmpty {
                        // 배차 수락 전부 진행함.
                        self.sendGetOffWorkDataRequest(statusType: "배차 확인") {
                            self.setData()
                            
                        }
                        
                    } else {
                        // 배차 수락 안 한 건 있음.
                        let vc = CustomizedNavigationController(rootViewController: DispatchCheckListViewController(dispatchList: checkList))
                        
                        self.present(vc, animated: true) {
                            print("수락 안한 배차 개수: \(checkList.count)")
                            
                        }
                        
                    }
                    
                }
                
            }
            break
            
        case .getOffWork:
            // 퇴근
            self.sendGetOffWorkDataRequest(statusType: "퇴근") {
                self.setData()
                
            }
            break
            
        default: break
            
        }
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                self.dispatchNoteViewBottomAnchorConstraint.constant = -keyboardSize.height
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                self.backgroundView.isHidden = true
                self.dispatchNoteView.isHidden = true
                self.dispatchNoteViewBottomAnchorConstraint.constant = 0
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func dispatchNoteSendButton(_ sender: UIButton) {
        self.updateDrivingHistoryRequest(id: self.routine!.info.dispatchId!, workType: self.routine!.info.workType!, departureKM: self.dispatchNoteView.dashboardTextField.text!) {
            self.dispatchNoteView.dashboardTextField.resignFirstResponder()
            self.backgroundView.isHidden = true
            self.dispatchNoteView.isHidden = true
            self.setData()
            
        }
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return self.dispatchList.count
            
        } else {
            return 1
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            // WorkRateTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkRateTableViewCell", for: indexPath) as! WorkRateTableViewCell
            
            cell.setCell(routine: self.routine)
            
            return cell
        } else if indexPath.section == 1 {
            // GoToWorkTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoToWorkTableViewCell", for: indexPath) as! GoToWorkTableViewCell
            
            cell.setCell(routine: self.routine)
            
            return cell
            
        } else if indexPath.section == 3 {
            // GetOffWorkTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "GetOffWorkTableViewCell", for: indexPath) as! GetOffWorkTableViewCell
            
            cell.setCell(routine: self.routine)
            
            return cell
            
        } else {
            // DispatchTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchTableViewCell", for: indexPath) as! DispatchTableViewCell
            let dispatch = self.routine?.tasks[indexPath.row]
            
            cell.dispatchContentBaseView.isHidden = self.dispatchIsHiddenStatus[indexPath.row]
            cell.setCell(index: indexPath.row, dispatch: dispatch)
            
            return cell
            
        }
        
    }
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension MainViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
    
}
