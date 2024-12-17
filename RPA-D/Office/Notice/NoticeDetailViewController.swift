//
//  NoticeDetailViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/16/24.
//

import UIKit

final class NoticeDetailViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.item.title
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let date = SupportingMethods.shared.convertString(intoDate: self.item.date, "yyyy-MM-dd HH:mm")
        label.text = SupportingMethods.shared.calculatePassedTime(date)
        
        return label
    }()
    
//    lazy var scrollView: UIScrollView = {
//        let view = UIScrollView()
//        view.backgroundColor = .white
//        view.translatesAutoresizingMaskIntoConstraints = false
//        
//        return view
//    }()
//    
//    lazy var contentLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
//        label.font = .useFont(ofSize: 15, weight: .Regular)
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        
//        return label
//    }()
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textColor = .useRGB(red: 101, green: 100, blue: 100)
        textView.font = .useFont(ofSize: 15, weight: .Regular)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let noticeModel = NoticeModel()
    var item: NoticeItem
    
    init(item: NoticeItem) {
        self.item = item
        
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
    
    deinit {
        print("----------------------------------- NoticeDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension NoticeDetailViewController: EssentialViewMethods {
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
            self.titleLabel,
            self.dateLabel,
            self.contentTextView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
        ])
        
        // dateLabel
        NSLayoutConstraint.activate([
            self.dateLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.dateLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 2),
        ])
        
        // contentTextView
        NSLayoutConstraint.activate([
            self.contentTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.contentTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.contentTextView.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 36),
            self.contentTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
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
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 46, green: 45, blue: 45),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "공지 상세"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        self.loadNoticeDetailDataRequest(id: self.item.id) { data in
            self.contentTextView.text = data.content
            
        }
        
    }
}

// MARK: - Extension for methods added
extension NoticeDetailViewController {
    func loadNoticeDetailDataRequest(id: Int, success: ((NoticeDetailData) -> ())?) {
        self.noticeModel.loadNoticeDetailDataRequest(id: id) { data in
            success?(data)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadNoticeDetailDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension NoticeDetailViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
