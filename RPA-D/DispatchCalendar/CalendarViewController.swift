//
//  CalendarViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit
import FSCalendar

enum Tense {
    case past
    case today
    case future
}

final class CalendarViewController: UIViewController {
    
    lazy var calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.backgroundColor = .white
        calendar.scope = .week
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.scrollEnabled = true
        calendar.scrollDirection = .horizontal
        
        calendar.select(Date())
        
        // 날짜 선택 색상 설정
        calendar.appearance.selectionColor = .useRGB(red: 255, green: 238, blue: 238)
        calendar.appearance.titleSelectionColor = .useRGB(red: 223, green: 52, blue: 52)
        calendar.appearance.borderRadius = 8
        
        // 오늘 날짜 설정
        calendar.appearance.titleTodayColor = .useRGB(red: 46, green: 45, blue: 45)
        calendar.appearance.todayColor = .clear
        
        // 헤더의 날짜 포맷 설정
        calendar.appearance.headerDateFormat = ""
        // 헤더 높이 설정
        calendar.headerHeight = 20
        
        // 기본 날짜 설정
        calendar.appearance.titleFont = .useFont(ofSize: 16, weight: .Medium)
        calendar.appearance.titleDefaultColor = .useRGB(red: 46, green: 45, blue: 45)
        calendar.appearance.titlePlaceholderColor = .useRGB(red: 196, green: 195, blue: 195)
        
        // 요일 설정
        calendar.appearance.weekdayTextColor = .useRGB(red: 147, green: 147, blue: 147)
        calendar.appearance.weekdayFont = .useFont(ofSize: 14, weight: .Regular)
        
        // 헤더 설정
        calendar.appearance.headerTitleFont = .useFont(ofSize: 16, weight: .Bold)
        calendar.appearance.headerTitleColor = .useRGB(red: 66, green: 66, blue: 66)
        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendar.appearance.headerTitleAlignment = .center
        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        // 이벤트 색상 설정
        calendar.appearance.eventDefaultColor = .useRGB(red: 223, green: 52, blue: 52)
        calendar.appearance.eventSelectionColor = .useRGB(red: 223, green: 52, blue: 52)
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
    lazy var changeScopeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var changeScopeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.changeScopeImageView, self.changeScopeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var changeScopeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("calendar.month")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var changeScopeLabel: UILabel = {
        let label = UILabel()
        label.text = "전체보기"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var changeScopeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(changeScopeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var movePreviousButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("move.previous"), for: .normal)
        button.addTarget(self, action: #selector(movePreviousButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var moveNextButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("move.next"), for: .normal)
        button.addTarget(self, action: #selector(moveNextButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var dispatchBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(KindsOfDocumentCollectionViewCell.self, forCellWithReuseIdentifier: "KindsOfDocumentCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var collectionViewBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 241, green: 241, blue: 241)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var documentCountBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var documentCountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "배차 건수"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var documentCountLabel: UILabel = {
        let label = UILabel()
        label.text = "4건"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchDocumentTableViewCell.self, forCellReuseIdentifier: "DispatchDocumentTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var noDocumentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noDocumentImageView, self.noDocumentTitleLabel, self.noDocumentSubTitleLabel])
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var noDocumentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("noDocumentImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var noDocumentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지정된 배차가 없어요"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var noDocumentSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "다른 날짜를 확인해 보세요"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var categoryList: [String] = ["지정된 배차", "운행일보"]
    var selectedIndex: Int = 0
    var tense: Tense = .today
    var events: [String] = []
    
    // DATA
    let dispatchModel = DispatchModel()
    var dispatchDailyList: [DispatchDailyItem] = []
    
    var calendarHeightAnchorLayoutConstraint: NSLayoutConstraint!
    
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
    
    deinit {
        print("----------------------------------- CalendarViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension CalendarViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let scopeUpGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(changeCalendarScope(_:)))
        scopeUpGesture.direction = .up
        self.calendar.addGestureRecognizer(scopeUpGesture)
        
        let scopeDownGesture: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(changeCalendarScope(_:)))
        scopeDownGesture.direction = .down
        self.calendar.addGestureRecognizer(scopeDownGesture)
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.calendar,
            self.movePreviousButton,
            self.moveNextButton,
            self.changeScopeView,
            self.dispatchBaseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.changeScopeStackView,
            self.changeScopeButton,
        ], to: self.changeScopeView)
        
        SupportingMethods.shared.addSubviews([
            self.collectionView,
            self.collectionViewBottomView,
            self.documentCountBaseView,
            self.tableView,
            self.noDocumentStackView,
        ], to: self.dispatchBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.documentCountTitleLabel,
            self.documentCountLabel,
        ], to: self.documentCountBaseView)
        
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // calendar
        self.calendarHeightAnchorLayoutConstraint = self.calendar.heightAnchor.constraint(equalToConstant: 400)
        NSLayoutConstraint.activate([
            self.calendar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.calendar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.calendar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.calendarHeightAnchorLayoutConstraint,
        ])
        
        // changeScopeView
        NSLayoutConstraint.activate([
            self.changeScopeView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.changeScopeView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.changeScopeView.topAnchor.constraint(equalTo: self.calendar.bottomAnchor),
            self.changeScopeView.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // changeScopeStackView
        NSLayoutConstraint.activate([
            self.changeScopeStackView.centerYAnchor.constraint(equalTo: self.changeScopeView.centerYAnchor),
            self.changeScopeStackView.centerXAnchor.constraint(equalTo: self.changeScopeView.centerXAnchor),
        ])
        
        // changeScopeImageView
        NSLayoutConstraint.activate([
            self.changeScopeImageView.heightAnchor.constraint(equalToConstant: 24),
            self.changeScopeImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        // changeScopeButton
        NSLayoutConstraint.activate([
            self.changeScopeButton.leadingAnchor.constraint(equalTo: self.changeScopeView.leadingAnchor),
            self.changeScopeButton.trailingAnchor.constraint(equalTo: self.changeScopeView.trailingAnchor),
            self.changeScopeButton.topAnchor.constraint(equalTo: self.changeScopeView.topAnchor),
            self.changeScopeButton.bottomAnchor.constraint(equalTo: self.changeScopeView.bottomAnchor),
        ])
        
        // movePreviousButton
        NSLayoutConstraint.activate([
            self.movePreviousButton.trailingAnchor.constraint(equalTo: self.calendar.calendarHeaderView.leadingAnchor, constant: -4),
            self.movePreviousButton.centerYAnchor.constraint(equalTo: self.calendar.calendarHeaderView.centerYAnchor),
            self.movePreviousButton.widthAnchor.constraint(equalToConstant: 24),
            self.movePreviousButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // moveNextButton
        NSLayoutConstraint.activate([
            self.moveNextButton.leadingAnchor.constraint(equalTo: self.calendar.calendarHeaderView.trailingAnchor, constant: 4),
            self.moveNextButton.centerYAnchor.constraint(equalTo: self.calendar.calendarHeaderView.centerYAnchor),
            self.moveNextButton.widthAnchor.constraint(equalToConstant: 24),
            self.moveNextButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // dispatchBaseView
        NSLayoutConstraint.activate([
            self.dispatchBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.dispatchBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.dispatchBaseView.topAnchor.constraint(equalTo: self.changeScopeView.bottomAnchor),
            self.dispatchBaseView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.dispatchBaseView.leadingAnchor, constant: 12),
            self.collectionView.trailingAnchor.constraint(equalTo: self.dispatchBaseView.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.dispatchBaseView.topAnchor, constant: 12),
            self.collectionView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        // collectionViewBottomView
        NSLayoutConstraint.activate([
            self.collectionViewBottomView.leadingAnchor.constraint(equalTo: self.dispatchBaseView.leadingAnchor),
            self.collectionViewBottomView.trailingAnchor.constraint(equalTo: self.dispatchBaseView.trailingAnchor),
            self.collectionViewBottomView.bottomAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            self.collectionViewBottomView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // documentCountBaseView
        NSLayoutConstraint.activate([
            self.documentCountBaseView.leadingAnchor.constraint(equalTo: self.dispatchBaseView.leadingAnchor),
            self.documentCountBaseView.trailingAnchor.constraint(equalTo: self.dispatchBaseView.trailingAnchor),
            self.documentCountBaseView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            self.documentCountBaseView.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // documentCountTitleLabel
        NSLayoutConstraint.activate([
            self.documentCountTitleLabel.leadingAnchor.constraint(equalTo: self.documentCountBaseView.leadingAnchor, constant: 20),
            self.documentCountTitleLabel.centerYAnchor.constraint(equalTo: self.documentCountBaseView.centerYAnchor),
        ])
        
        // documentCountLabel
        NSLayoutConstraint.activate([
            self.documentCountLabel.trailingAnchor.constraint(equalTo: self.documentCountBaseView.trailingAnchor, constant: -20),
            self.documentCountLabel.centerYAnchor.constraint(equalTo: self.documentCountBaseView.centerYAnchor),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.dispatchBaseView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.dispatchBaseView.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.documentCountBaseView.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.dispatchBaseView.bottomAnchor, constant: -10),
        ])
        
        // noDocumentStackView
        NSLayoutConstraint.activate([
            self.noDocumentStackView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor),
            self.noDocumentStackView.leadingAnchor.constraint(equalTo: self.dispatchBaseView.leadingAnchor),
            self.noDocumentStackView.trailingAnchor.constraint(equalTo: self.dispatchBaseView.trailingAnchor),
        ])
        
        // noDocumentImageView
        NSLayoutConstraint.activate([
            self.noDocumentImageView.heightAnchor.constraint(equalToConstant: 80),
            self.noDocumentImageView.widthAnchor.constraint(equalToConstant: 80),
        ])
        
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
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
        
        let leftBarButtonItem = UIBarButtonItem(title: "배차 달력", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 20, weight: .Bold),
            .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    func setData() {
        let currentMonth = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM")
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchMonthlyRequest(date: currentMonth) { countList in
            for index in 0..<countList.count {
                if countList[index] != 0 {
                    let date: String = index < 9 ? currentMonth + "-0\(index + 1)" : currentMonth + "-\(index + 1)"
                    self.events.append(date)
                    
                }
                
            }
            
            DispatchQueue.main.async {
                self.calendar.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
            self.reloadData(date: SupportingMethods.shared.convertDate(intoString: Date()))
            
        }
    }
    
}

// MARK: - Extension for methods added
extension CalendarViewController {
    func setCurrentPage(isPrevious: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrevious ? -1 : 1
            
        let currentPage = cal.date(byAdding: dateComponents, to: self.calendar.currentPage)
        self.calendar.setCurrentPage(currentPage!, animated: true)
    }
    
    func reloadData(date: String) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchDailyListRequest(date: date) { item in
            self.dispatchDailyList = item
            self.documentCountLabel.text = "\(item.count)건"
            
            if item.isEmpty {
                self.noDocumentStackView.isHidden = false
                
            } else {
                self.noDocumentStackView.isHidden = true
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
        
    }
    
    // MARK: API
    func loadDispatchDailyListRequest(date: String, success: (([DispatchDailyItem]) -> ())?) {
        self.dispatchModel.loadDispatchDailyListRequest(date: date) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDispatchDailyListRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadDispatchMonthlyRequest(date: String, success: (([Int]) -> ())?) {
        self.dispatchModel.loadDispatchMonthlyRequest(date: date) { dailyDispatchCount in
            success?(dailyDispatchCount)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDispatchMonthlyRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension CalendarViewController {
    @objc func changeCalendarScope(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .up {
            self.calendar.setScope(.week, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.month")
            self.changeScopeLabel.text = "전체보기"
            self.calendar.appearance.headerDateFormat = ""
            
        } else if gesture.direction == .down {
            self.calendar.setScope(.month, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.week")
            self.changeScopeLabel.text = "접기"
            self.calendar.appearance.headerDateFormat = "MM월"
            
        }
        
    }
    
    @objc func changeScopeButton(_ sender: UIButton) {
        if self.calendar.scope == .week {
            self.calendar.setScope(.month, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.week")
            self.changeScopeLabel.text = "접기"
            self.calendar.appearance.headerDateFormat = "MM월"
            
        } else {
            self.calendar.setScope(.week, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.month")
            self.changeScopeLabel.text = "전체보기"
            self.calendar.appearance.headerDateFormat = ""
            
        }
        
    }
    
    @objc func movePreviousButton(_ sender: UIButton) {
        self.setCurrentPage(isPrevious: true)
        
    }
    
    @objc func moveNextButton(_ sender: UIButton) {
        self.setCurrentPage(isPrevious: true)
        
    }
    
}

// MARK: - Extension for FSCalendarDelegate
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        UIView.transition(with: self.calendar, duration: 1.5) {
            self.calendarHeightAnchorLayoutConstraint.constant = bounds.height
            if calendar.scope == .month {
                self.noDocumentStackView.alpha = 0.0
                
            } else {
                self.noDocumentStackView.alpha = 1.0
                
            }
            
            self.view.layoutIfNeeded()
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if calendar.scope == .month {
            self.calendar.setScope(.week, animated: true)
            self.changeScopeImageView.image = .useCustomImage("calendar.month")
            self.changeScopeLabel.text = "전체보기"
            self.calendar.appearance.headerDateFormat = ""
            
        }
        
        let status = SupportingMethods.shared.isLaterThanTargetDate(date, targetDate: Date())
        
        if status {
            // 미래
            self.tense = .future
            self.categoryList = ["대기중인 배차"]
            
        } else {
            // 과거 및 현재
            let selectedDate = SupportingMethods.shared.convertDate(intoString: date, "yyyy-MM-dd")
            let todayDate = SupportingMethods.shared.convertDate(intoString: Date(), "yyyy-MM-dd")
            if selectedDate == todayDate {
                // 오늘
                self.tense = .today
                self.categoryList = ["지정된 배차", "운행일보"]
                
            } else {
                // 과거
                self.tense = .past
                self.categoryList = ["운행일보"]
                
            }
            
        }
        
        self.selectedIndex = 0
        self.collectionView.reloadData()
        self.reloadData(date: SupportingMethods.shared.convertDate(intoString: date))
        
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentMonth = SupportingMethods.shared.convertDate(intoString: calendar.currentPage, "yyyy-MM")
        
        self.events = []
        
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchMonthlyRequest(date: currentMonth) { countList in
            for index in 0..<countList.count {
                if countList[index] != 0 {
                    let date: String = index < 9 ? currentMonth + "-0\(index + 1)" : currentMonth + "-\(index + 1)"
                    self.events.append(date)
                    
                }
                
            }
            
            DispatchQueue.main.async {
                self.calendar.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = SupportingMethods.shared.convertDate(intoString: date)
        if self.events.contains(dateString){
            return 1
            
        }
        
        return 0
        
    }
    
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension CalendarViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KindsOfDocumentCollectionViewCell", for: indexPath) as! KindsOfDocumentCollectionViewCell
        let category = self.categoryList[indexPath.row]
        
        cell.setCell(category: category)
        cell.categoryLabel.textColor = self.selectedIndex == indexPath.row ? .useRGB(red: 46, green: 45, blue: 45) : .useRGB(red: 196, green: 195, blue: 195)
        cell.categoryLabel.font = self.selectedIndex == indexPath.row ? .useFont(ofSize: 16, weight: .Bold) : .useFont(ofSize: 16, weight: .Medium)
        cell.bottomView.isHidden = self.selectedIndex == indexPath.row ? false : true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        self.collectionView.reloadData()
    }
    
}


// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dispatchDailyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDocumentTableViewCell", for: indexPath) as! DispatchDocumentTableViewCell
        let item = self.dispatchDailyList[indexPath.row]
        
        cell.setCell(tense: self.tense, item: item)
        
        return cell
    }
    
}
