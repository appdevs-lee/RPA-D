//
//  RenewalMainViewController.swift
//  RPA-D
//
//  Created by 이주성 on 1/18/25.
//

import UIKit

final class RenewalMainViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var todayDateLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy.MM.dd.EEE요일")
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var mainOptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 241, green: 241, blue: 241)
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var todolistButton: UIButton = {
        let button = UIButton()
        button.setTitle("할 일", for: .normal)
        button.setTitleColor(.useRGB(red: 46, green: 45, blue: 45), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.backgroundColor = .white
        button.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector((todolistButton(_:))), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var scheduleButton: UIButton = {
        let button = UIButton()
        button.setTitle("일정", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Medium)
        button.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector((scheduleButton(_:))), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var taskRateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var taskRateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "업무 진행도"
        label.textColor = .white
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var taskRateButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("taskRate.open"), for: .normal)
        button.addTarget(self, action: #selector(taskRateButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var progressBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .white
        progressView.trackTintColor = .useRGB(red: 255, green: 255, blue: 255, alpha: 0.2)
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
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var progressValueInnerView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var taskRateValueButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 11, weight: .Medium)
        button.backgroundColor = .useRGB(red: 190, green: 44, blue: 44)
        button.layer.cornerRadius = 11
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var statusBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var statusView: StatusView = {
        let view = StatusView()
        view.statusButton.addTarget(self, action: #selector(statusButton(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    lazy var noRoutineDataBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
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
    
    var role: Role = .driver
    
    var taskRateOpenStatus: Bool = false
    var taskRateViewHeightAnchorConstraint: NSLayoutConstraint!
    var progressValueViewLeadingAnchorConstraint: NSLayoutConstraint!
    
    let mainModel = MainModel()
    let dispatchModel = DispatchModel()
    var routine: RoutineItem?
    var goToWorkData: RoutineGoToWork?
    var getOffWorkData: RoutineGetOffWork?
    var isLeftDispatchCheck: Bool = false
    var inspectionCheck: Bool = false
    
    var dispatchList: [RoutineDispatch?] = []
    
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
        self.statusView.setTempData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- RenewalMainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalMainViewController: EssentialViewMethods {
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
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAllData(_:)), name: Notification.Name("ReloadAllData"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openDailyInspection(_:)), name: Notification.Name("OpenDailyInspection"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.mainOptionView,
            self.scrollView,
            self.todayDateLabel,
            self.scheduleTableView,
            self.backgroundView,
            self.dispatchNoteView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.taskRateView,
            self.statusBaseView,
            self.noRoutineDataBaseView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.todolistButton,
            self.scheduleButton,
        ], to: self.mainOptionView)
        
        SupportingMethods.shared.addSubviews([
            self.taskRateTitleLabel,
            self.taskRateButton,
            self.progressBaseView,
        ], to: self.taskRateView)
        
        SupportingMethods.shared.addSubviews([
            self.progressView,
            self.progressValueView,
            self.taskRateValueButton,
        ], to: self.progressBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.progressValueInnerView,
        ], to: self.progressValueView)
        
        SupportingMethods.shared.addSubviews([
            self.statusView,
        ], to: self.statusBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.noRoutineDataStackView,
        ], to: self.noRoutineDataBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // mainOptionView
        NSLayoutConstraint.activate([
            self.mainOptionView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            self.mainOptionView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.mainOptionView.widthAnchor.constraint(equalToConstant: 233),
            self.mainOptionView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // todolistButton
        NSLayoutConstraint.activate([
            self.todolistButton.leadingAnchor.constraint(equalTo: self.mainOptionView.leadingAnchor, constant: 4),
            self.todolistButton.topAnchor.constraint(equalTo: self.mainOptionView.topAnchor, constant: 4),
            self.todolistButton.bottomAnchor.constraint(equalTo: self.mainOptionView.bottomAnchor, constant: -4),
            self.todolistButton.widthAnchor.constraint(equalToConstant: 117),
        ])
        
        // scheduleButton
        NSLayoutConstraint.activate([
            self.scheduleButton.trailingAnchor.constraint(equalTo: self.mainOptionView.trailingAnchor, constant: -4),
            self.scheduleButton.topAnchor.constraint(equalTo: self.mainOptionView.topAnchor, constant: 4),
            self.scheduleButton.bottomAnchor.constraint(equalTo: self.mainOptionView.bottomAnchor, constant: -4),
            self.scheduleButton.widthAnchor.constraint(equalToConstant: 117),
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
        
        // todayDateLabel
        NSLayoutConstraint.activate([
            self.todayDateLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.todayDateLabel.topAnchor.constraint(equalTo: self.mainOptionView.bottomAnchor, constant: 25),
        ])
        
        // scheduleTableView
        NSLayoutConstraint.activate([
            self.scheduleTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scheduleTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scheduleTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.scheduleTableView.topAnchor.constraint(equalTo: self.todayDateLabel.bottomAnchor),
        ])
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.mainOptionView.bottomAnchor, constant: 10),
            self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
        ])
        
        // taskRateView
        self.taskRateViewHeightAnchorConstraint = self.taskRateView.heightAnchor.constraint(equalToConstant: 54)
        NSLayoutConstraint.activate([
            self.taskRateView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.taskRateView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.taskRateView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 10),
            self.taskRateViewHeightAnchorConstraint,
        ])
        
        // taskRateTitleLabel
        NSLayoutConstraint.activate([
            self.taskRateTitleLabel.leadingAnchor.constraint(equalTo: self.taskRateView.leadingAnchor, constant: 16),
            self.taskRateTitleLabel.centerYAnchor.constraint(equalTo: self.taskRateButton.centerYAnchor),
        ])
        
        // taskRateButton
        NSLayoutConstraint.activate([
            self.taskRateButton.trailingAnchor.constraint(equalTo: self.taskRateView.trailingAnchor, constant: -20),
            self.taskRateButton.topAnchor.constraint(equalTo: self.taskRateView.topAnchor, constant: 15),
            self.taskRateButton.heightAnchor.constraint(equalToConstant: 24),
            self.taskRateButton.widthAnchor.constraint(equalToConstant: 36),
        ])
        
        // progressBaseView
        NSLayoutConstraint.activate([
            self.progressBaseView.leadingAnchor.constraint(equalTo: self.taskRateView.leadingAnchor),
            self.progressBaseView.trailingAnchor.constraint(equalTo: self.taskRateView.trailingAnchor),
            self.progressBaseView.topAnchor.constraint(equalTo: self.taskRateButton.bottomAnchor, constant: 6),
            self.progressBaseView.bottomAnchor.constraint(equalTo: self.taskRateView.bottomAnchor),
        ])
        
        // progressView
        NSLayoutConstraint.activate([
            self.progressView.leadingAnchor.constraint(equalTo: self.progressBaseView.leadingAnchor, constant: 24),
            self.progressView.trailingAnchor.constraint(equalTo: self.progressBaseView.trailingAnchor, constant: -24),
            self.progressView.bottomAnchor.constraint(equalTo: self.progressBaseView.bottomAnchor, constant: -45),
            self.progressView.heightAnchor.constraint(equalToConstant: 10),
        ])
        
        // progressValueView
        self.progressValueViewLeadingAnchorConstraint = self.progressValueView.centerXAnchor.constraint(equalTo: self.progressView.leadingAnchor, constant: 0)
        NSLayoutConstraint.activate([
            self.progressValueViewLeadingAnchorConstraint,
            self.progressValueView.centerYAnchor.constraint(equalTo: self.progressView.centerYAnchor),
            self.progressValueView.widthAnchor.constraint(equalToConstant: 12),
            self.progressValueView.heightAnchor.constraint(equalToConstant: 12),
        ])
        
        // taskRateValueButton
        NSLayoutConstraint.activate([
            self.taskRateValueButton.topAnchor.constraint(equalTo: self.progressValueView.bottomAnchor, constant: 7),
            self.taskRateValueButton.centerXAnchor.constraint(equalTo: self.progressValueView.centerXAnchor),
            self.taskRateValueButton.widthAnchor.constraint(equalToConstant: 40),
            self.taskRateValueButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        // progressValueInnerView
        NSLayoutConstraint.activate([
            self.progressValueInnerView.centerYAnchor.constraint(equalTo: self.progressValueView.centerYAnchor),
            self.progressValueInnerView.centerXAnchor.constraint(equalTo: self.progressValueView.centerXAnchor),
            self.progressValueInnerView.widthAnchor.constraint(equalToConstant: 8),
            self.progressValueInnerView.heightAnchor.constraint(equalToConstant: 8),
        ])
        
        // statusBaseView
        NSLayoutConstraint.activate([
            self.statusBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.statusBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.statusBaseView.topAnchor.constraint(equalTo: self.taskRateView.bottomAnchor, constant: 16),
            self.statusBaseView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -28),
            self.statusBaseView.heightAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 40) * 434 / 335)
        ])
        
        // statusView
        NSLayoutConstraint.activate([
            self.statusView.leadingAnchor.constraint(equalTo: self.statusBaseView.leadingAnchor),
            self.statusView.trailingAnchor.constraint(equalTo: self.statusBaseView.trailingAnchor),
            self.statusView.topAnchor.constraint(equalTo: self.statusBaseView.topAnchor),
            self.statusView.bottomAnchor.constraint(equalTo: self.statusBaseView.bottomAnchor),
        ])
        
        // noRoutineDataBaseView
        NSLayoutConstraint.activate([
            self.noRoutineDataBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.noRoutineDataBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.noRoutineDataBaseView.topAnchor.constraint(equalTo: self.baseView.topAnchor),
            self.noRoutineDataBaseView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
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
        
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 46, green: 45, blue: 45),
            .font:UIFont.useFont(ofSize: 20, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = ""
        
        let leftBarButtonItem = UIBarButtonItem(title: "운행", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 20, weight: .Bold),
            .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .useCustomImage("notificationImage").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        
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
                        
                        self.loadVehicleCheckDataRequest { submitCheck in
                            self.statusView.setData(status: item.status, routine: item, inspectionCheck: submitCheck)
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.scheduleTableView.reloadData()
                            SupportingMethods.shared.turnCoverView(.off)
                            
                        }
                        
                    }
                    
                    if item.goToWork.wakeTime == "" {
                        self.statusView.titleLabel.text = "운행 1시간 30분 전입니다\n출근 체크를 완료해 주세요"
                        self.statusView.subTitleLabel.text = "출근 체크 버튼을 눌러 아침 점호를 진행해 주세요"
                        self.statusView.statusImageView.image = .useCustomImage("goToWorkImage")
                        self.statusView.statusButton.setTitle("출근 체크", for: .normal)
                        
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
extension RenewalMainViewController {
    func reloadTaskRateView(taskRateOpenStatus: Bool) {
        if taskRateOpenStatus {
            // 열림
            // FIXME: value 넣어주기
            self.taskRateButton.setImage(.useCustomImage("taskRate.close"), for: .normal)
            self.taskRateViewHeightAnchorConstraint.constant = 118
            
            self.progressBaseView.isHidden = false
            self.calculateTaskRate()
            
        } else {
            // 닫힘
            self.taskRateTitleLabel.text = "업무 진행도"
            self.taskRateButton.setImage(.useCustomImage("taskRate.open"), for: .normal)
            self.taskRateViewHeightAnchorConstraint.constant = 54
            
            self.progressView.setProgress(0, animated: true)
            self.progressValueViewLeadingAnchorConstraint.constant = 0
            self.progressBaseView.isHidden = true
        }
        
    }
    
    func calculateTaskRate() {
        guard let routine = self.routine else { return }
        
        var sumCount = 0
        if routine.goToWork.wakeTime != "" {
            sumCount += 1
            
        }
        
        if self.inspectionCheck == true {
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
        self.taskRateValueButton.setTitle("\(Int(rate * 100))%", for: .normal)
        if Int(rate * 100) == 100 {
            self.taskRateTitleLabel.text = "오늘의 업무가 완료되었습니다."
            
        } else {
            self.taskRateTitleLabel.text = "업무 완료까지 \(100 - Int(rate * 100))% 남았어요."
            
        }
        
        self.progressView.setProgress(Float(rate), animated: true)
        self.progressValueViewLeadingAnchorConstraint.constant = (ReferenceValues.Size.Device.width - 88) * CGFloat(self.progressView.progress)
    }
    
    // MARK: API
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
    
    func sendStationCheckDataRequest(dispatchId: Int, stationId: Int, success: (() -> ())?) {
        self.dispatchModel.sendStationCheckDataRequest(dispatchId: dispatchId, stationId: stationId, arriveTime: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm"), isLastStation: false) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendStationCheckDataRequest API Error: \(message)")
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
    
    func loadVehicleCheckDataRequest(success: ((_ submitCheck: Bool) -> ())?) {
        self.dispatchModel.loadVehicleCheckDataRequest { submitCheck in
            self.inspectionCheck = submitCheck
            success?(submitCheck)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadVehicleCheckDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension RenewalMainViewController {
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = NotificationListViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func todolistButton(_ sender: UIButton) {
        self.todolistButton.backgroundColor = .white
        self.todolistButton.setTitleColor(.useRGB(red: 46, green: 45, blue: 45), for: .normal)
        
        self.scheduleButton.backgroundColor = .clear
        self.scheduleButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        
        self.scrollView.isHidden = false
        self.todayDateLabel.isHidden = true
        self.scheduleTableView.isHidden = true
    }
    
    @objc func scheduleButton(_ sender: UIButton) {
        self.scheduleButton.backgroundColor = .white
        self.scheduleButton.setTitleColor(.useRGB(red: 46, green: 45, blue: 45), for: .normal)
        
        self.todolistButton.backgroundColor = .clear
        self.todolistButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        
        self.scrollView.isHidden = true
        self.todayDateLabel.isHidden = false
        self.scheduleTableView.isHidden = false
        
    }
    
    @objc func taskRateButton(_ sender: UIButton) {
        UIView.transition(with: self.taskRateView, duration: 0.5) {
            self.taskRateOpenStatus.toggle()
            self.reloadTaskRateView(taskRateOpenStatus: self.taskRateOpenStatus)
            
            self.view.layoutIfNeeded()
        }
        
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
//                self.loadDispatchDailyDetailRequest(id: routine.info.dispatchId!, workType: routine.info.workType!) { item in
//                    self.sendStationCheckDataRequest(dispatchId: routine.info.dispatchId!, stationId: item.stations.first!.id) {
//                        self.setData()
//
//                    }
//
//                }
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
            self.loadVehicleCheckDataRequest { submitCheck in
                if submitCheck {
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
                    
                } else {
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
                    
                }
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
extension RenewalMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dispatchList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        let dispatch = self.dispatchList[indexPath.row]
        
        cell.setCell(dispatch: dispatch, currentDispatchId: self.routine?.info.dispatchId)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dispatch = self.dispatchList[indexPath.row]
        
        guard let dispatch = dispatch else { return }
        self.loadDispatchDailyDetailRequest(id: dispatch.dispatchId!, workType: dispatch.workType) { detailItem in
            let vc = DispatchDetailViewController(item: detailItem, departureDate: dispatch.departureDate)
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}


// MARK: - Extension for UIGestureRecognizerDelegate
extension RenewalMainViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
    
}
