//
//  CalendarViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit
import FSCalendar

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
//        calendar.appearance.titleTodayColor = .useRGB(red: 46, green: 45, blue: 45)
//        calendar.appearance.todayColor = .clear
//        calendar.appearance.todaySelectionColor = .none
//        calendar.appearance.subtitleTodayColor = .black
        
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
        calendar.weekdayHeight = 28
        
        // 헤더 설정
        calendar.appearance.headerTitleFont = .useFont(ofSize: 16, weight: .Bold)
        calendar.appearance.headerTitleColor = .useRGB(red: 66, green: 66, blue: 66)
        // 헤더의 폰트 정렬 설정
        // .center & .left & .justified & .natural & .right
        calendar.appearance.headerTitleAlignment = .center
        // 헤더 양 옆(전달 & 다음 달) 글씨 투명도
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
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
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.calendar,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // calendar
        self.calendarHeightAnchorLayoutConstraint = self.calendar.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([
            self.calendar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.calendar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.calendar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.calendarHeightAnchorLayoutConstraint,
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
}

// MARK: - Extension for methods added
extension CalendarViewController {
    
}

// MARK: - Extension for selector methods
extension CalendarViewController {
    
}

// MARK: - Extension for FSCalendarDelegate
extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
}
