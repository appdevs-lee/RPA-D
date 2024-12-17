//
//  NoticeViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/16/24.
//

import UIKit

final class NoticeViewController: UIViewController {
    
    lazy var noticeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("noticeIcon")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "공지 목록"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var noticeCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: "NoticeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let noticeModel = NoticeModel()
    var noticeList: [NoticeItem] = []
    var page: Int = 1
    var nextRequest: String?
    
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
        print("----------------------------------- NoticeViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension NoticeViewController: EssentialViewMethods {
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
            self.noticeIconImageView,
            self.noticeTitleLabel,
            self.noticeCountLabel,
            self.tableView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // noticeIconImageView
        NSLayoutConstraint.activate([
            self.noticeIconImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.noticeIconImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 24),
            self.noticeIconImageView.widthAnchor.constraint(equalToConstant: 44),
            self.noticeIconImageView.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        // noticeTitleLabel
        NSLayoutConstraint.activate([
            self.noticeTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.noticeTitleLabel.topAnchor.constraint(equalTo: self.noticeIconImageView.bottomAnchor, constant: 11),
        ])
        
        // noticeCountLabel
        NSLayoutConstraint.activate([
            self.noticeCountLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.noticeCountLabel.topAnchor.constraint(equalTo: self.noticeTitleLabel.bottomAnchor, constant: 2),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.noticeCountLabel.bottomAnchor, constant: 24),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
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
        
        self.navigationItem.title = "공지사항"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        self.loadNoticeListDataRequest(page: 1)
        
    }
    
}

// MARK: - Extension for methods added
extension NoticeViewController {
    func loadNoticeListDataRequest(page: Int, success: ((NoticeData) -> ())?) {
        self.noticeModel.loadNoticeListDataRequest(page: page) { data in
            success?(data)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadNoticeListDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadNoticeListDataRequest(page: Int) {
        self.loadNoticeListDataRequest(page: page) { data in
            self.noticeCountLabel.text = "총 \(data.count)건의 공지사항이 있습니다"
            self.page = page
            self.nextRequest = data.next
            
            if page == 1 {
                self.noticeList = []
                self.noticeList = data.results
                
            } else {
                self.noticeList.append(contentsOf: data.results)
                
            }
            
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        
    }
    
}

// MARK: - Extension for selector methods
extension NoticeViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension NoticeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticeList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeTableViewCell", for: indexPath) as! NoticeTableViewCell
        let notice = self.noticeList[indexPath.row]
        
        cell.setCell(notice: notice)
        
        if indexPath.row == self.noticeList.count - 1 && self.nextRequest != nil {
            self.loadNoticeListDataRequest(page: self.page + 1)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notice = self.noticeList[indexPath.row]
        let vc = NoticeDetailViewController(item: notice)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
