//
//  PhoneBookListViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 12/11/24.
//

import UIKit

final class PhoneBookListViewController: UIViewController {
    
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PhoneBookListTableViewCell.self, forCellReuseIdentifier: "PhoneBookListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let memberModel = MemberModel()
    var memberList: [MemberDetailItem] = []
    
    var page: Int = 1
    var nextRequest: String?
    var categoryList: [String] = ["관리자", "운전원", "용역"]
    var selectedIndex: Int = 0
    
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
        print("----------------------------------- PhoneBookListViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension PhoneBookListViewController: EssentialViewMethods {
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
            self.collectionView,
            self.tableView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
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
        
        self.navigationItem.title = "조직도"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        self.loadMemberListByRoleRequest(page: 1, role: "관리자")
        
    }
    
}

// MARK: - Extension for methods added
extension PhoneBookListViewController {
    func loadMemberListRequest(page: Int, search: String = "", role: String = "", success: ((MemberItem) -> ())?) {
        self.memberModel.loadMemberListRequest(page: page, search: search, role: role) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadMemberListRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadMemberListByRoleRequest(page: Int, role: String) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadMemberListRequest(page: page, role: role) { item in
            self.page = page
            self.nextRequest = item.next
            
            if page == 1 {
                self.memberList = []
                self.memberList = item.memberList
                
            } else {
                self.memberList.append(contentsOf: item.memberList)
                
            }
            
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
            
        }
    }
    
}

// MARK: - Extension for selector methods
extension PhoneBookListViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension PhoneBookListViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KindsOfDocumentCollectionViewCell", for: indexPath) as! KindsOfDocumentCollectionViewCell
        let category = self.categoryList[indexPath.row]
        
        cell.setCell(category: category)
        cell.categoryLabel.widthAnchor.constraint(equalToConstant: 44).isActive = true
        cell.categoryLabel.textColor = self.selectedIndex == indexPath.row ? .useRGB(red: 46, green: 45, blue: 45) : .useRGB(red: 196, green: 195, blue: 195)
        cell.categoryLabel.font = self.selectedIndex == indexPath.row ? .useFont(ofSize: 16, weight: .Bold) : .useFont(ofSize: 16, weight: .Medium)
        cell.bottomView.isHidden = self.selectedIndex == indexPath.row ? false : true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        self.collectionView.reloadData()
        
        // 데이터 불러오기
        if self.selectedIndex == 0 {
            // 관리자
            self.loadMemberListByRoleRequest(page: 1, role: "관리자")
            
        } else if self.selectedIndex == 1 {
            // 운전원
            self.loadMemberListByRoleRequest(page: 1, role: "운전원")
            
        } else {
            // 용역
            self.loadMemberListByRoleRequest(page: 1, role: "용역")
            
        }
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension PhoneBookListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memberList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneBookListTableViewCell", for: indexPath) as! PhoneBookListTableViewCell
        let member = self.memberList[indexPath.row]
        
        cell.setCell(member: member)
        
        if indexPath.row == self.memberList.count - 1 && self.nextRequest != nil {
            self.loadMemberListByRoleRequest(page: self.page + 1, role: self.categoryList[self.selectedIndex])
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let phoneBookList: [MemberDetailItem] = SupportingMethods.shared.loadMemberInfoList()
        let member = self.memberList[indexPath.row]
        
        if let url = URL(string: "tel://\(member.phoneNum)") {
            UIApplication.shared.open(url)
            SupportingMethods.shared.saveMemberInfoList(memberList: [member] + phoneBookList)
            
        }
        
    }
}
