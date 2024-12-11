//
//  RouteViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/11/24.
//

import UIKit

final class RouteViewController: UIViewController {
    
    lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var searchPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "노선 검색하고 숙지율 올리기"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(searchButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var routeKnowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.routeKnowTitleLabel, self.dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var routeKnowTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "노선 숙지"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "\(SupportingMethods.shared.convertDate(intoString: Date())) 기준"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var circularProgress: CircularProgress = {
        let view = CircularProgress()
        view.backgroundColor = .clear
        view.progressLineWidth = 12
        view.progressLineColor = .useRGB(red: 223, green: 52, blue: 52)
        view.trackLineWidth = 12
        view.trackColor = .useRGB(red: 219, green: 219, blue: 219)
        view.setProgress(value: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var countStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.rateLabel, self.routeKnowCountLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "50%"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var routeKnowCountLabel: UILabel = {
        let label = UILabel()
        label.text = "25/50"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RouteTableViewCell.self, forCellReuseIdentifier: "RouteTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var noRouteDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noRouteDataImageView, self.noRouteDataTitleLabel, self.noRouteDataSubTitleLabel])
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var noRouteDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("noRouteDataImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var noRouteDataTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var noRouteDataSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var categoryList: [String] = ["숙지된 노선", "즐겨찾는 노선"]
    var selectedIndex: Int = 0
    
    let routeModel = RouteModel()
    var page: Int = 1
    var nextRequest: String?
    
    var routeList: [RouteDetailItem] = []
    
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
        print("----------------------------------- RouteViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RouteViewController: EssentialViewMethods {
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
            self.searchView,
            self.searchPlaceholderLabel,
            self.searchButton,
            self.baseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.routeKnowView,
            self.collectionView,
            self.tableView,
            self.noRouteDataStackView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.labelStackView,
            self.circularProgress,
            self.countStackView,
        ], to: self.routeKnowView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // searchView
        NSLayoutConstraint.activate([
            self.searchView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.searchView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.searchView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            self.searchView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // searchPlaceholderLabel
        NSLayoutConstraint.activate([
            self.searchPlaceholderLabel.leadingAnchor.constraint(equalTo: self.searchView.leadingAnchor, constant: 16),
            self.searchPlaceholderLabel.trailingAnchor.constraint(equalTo: self.searchView.trailingAnchor, constant: -16),
            self.searchPlaceholderLabel.topAnchor.constraint(equalTo: self.searchView.topAnchor, constant: 14),
            self.searchPlaceholderLabel.bottomAnchor.constraint(equalTo: self.searchView.bottomAnchor, constant: -14),
        ])
        
        // searchButton
        NSLayoutConstraint.activate([
            self.searchButton.leadingAnchor.constraint(equalTo: self.searchView.leadingAnchor),
            self.searchButton.trailingAnchor.constraint(equalTo: self.searchView.trailingAnchor),
            self.searchButton.topAnchor.constraint(equalTo: self.searchView.topAnchor),
            self.searchButton.bottomAnchor.constraint(equalTo: self.searchView.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.searchView.bottomAnchor, constant: 24),
            self.baseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // routeKnowView
        NSLayoutConstraint.activate([
            self.routeKnowView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.routeKnowView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.routeKnowView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 24),
        ])
        
        // labelStackView
        NSLayoutConstraint.activate([
            self.labelStackView.leadingAnchor.constraint(equalTo: self.routeKnowView.leadingAnchor, constant: 20),
            self.labelStackView.centerYAnchor.constraint(equalTo: self.routeKnowView.centerYAnchor),
        ])
        
        // circularProgress
        NSLayoutConstraint.activate([
            self.circularProgress.trailingAnchor.constraint(equalTo: self.routeKnowView.trailingAnchor, constant: -20),
            self.circularProgress.topAnchor.constraint(equalTo: self.routeKnowView.topAnchor, constant: 12),
            self.circularProgress.bottomAnchor.constraint(equalTo: self.routeKnowView.bottomAnchor, constant: -12),
            self.circularProgress.widthAnchor.constraint(equalToConstant: 90),
            self.circularProgress.heightAnchor.constraint(equalToConstant: 90),
        ])
        
        // countStackView
        NSLayoutConstraint.activate([
            self.countStackView.centerYAnchor.constraint(equalTo: self.circularProgress.centerYAnchor),
            self.countStackView.centerXAnchor.constraint(equalTo: self.circularProgress.centerXAnchor),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 12),
            self.collectionView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.routeKnowView.bottomAnchor, constant: 17),
            self.collectionView.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 14),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
        ])
        
        // noRouteDataStackView
        NSLayoutConstraint.activate([
            self.noRouteDataStackView.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor, constant: 20),
            self.noRouteDataStackView.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor, constant: -20),
            self.noRouteDataStackView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor),
        ])
        
        // noRouteDataImageView
        NSLayoutConstraint.activate([
            self.noRouteDataImageView.widthAnchor.constraint(equalToConstant: 36),
            self.noRouteDataImageView.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "노선"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton.white")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        self.loadKnowRouteListDataRequest(page: 1) { item in
            self.rateLabel.text = "\(item.knowCount / item.count * 100)"
            self.routeKnowCountLabel.text = "\(item.knowCount)/\(item.count)"
            self.circularProgress.setProgress(value: Double(item.knowCount) / Double(item.count * 100))
            
        }
        
    }
    
}

// MARK: - Extension for methods added
extension RouteViewController {
    func loadRouteListDataRequest(page: Int, search: String = "", group: String = "", know: Bool? = nil, favorite: Bool? = nil, success: ((RouteItem) -> ())?) {
        self.routeModel.loadRouteListDataRequest(page: page, search: search, group: group, know: know, favorite: favorite) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadRouteListDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadKnowRouteListDataRequest(page: Int, completionHandler: ((RouteItem) -> ())? = nil) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadRouteListDataRequest(page: page, know: true) { item in
            self.page = page
            self.nextRequest = item.next
            
            if page == 1 {
                self.routeList = []
                self.routeList = item.routeList
                
            } else {
                self.routeList.append(contentsOf: item.routeList)
                
            }
            
            if !item.routeList.isEmpty {
                self.noRouteDataStackView.isHidden = true
                
            } else {
                self.noRouteDataTitleLabel.text = "숙지된 노선이 없어요"
                self.noRouteDataSubTitleLabel.text = "자주 운행하는 노선을 검색해서 숙지해 주세요"
                self.noRouteDataStackView.isHidden = false
                
            }
            
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
            completionHandler?(item)
            
        }
        
    }
    
    func loadFavoriteRouteListDataRequest(page: Int) {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadRouteListDataRequest(page: page, favorite: true) { item in
            self.page = page
            self.nextRequest = item.next
            
            if page == 1 {
                self.routeList = []
                self.routeList = item.routeList
                
            } else {
                self.routeList.append(contentsOf: item.routeList)
                
            }
            
            if !item.routeList.isEmpty {
                self.noRouteDataStackView.isHidden = true
                
            } else {
                self.noRouteDataTitleLabel.text = "즐겨찾는 노선이 없어요"
                self.noRouteDataSubTitleLabel.text = "자주 운행하는 노선을 즐겨찾기 해보세요"
                self.noRouteDataStackView.isHidden = false
                
            }
            
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        
    }
    
    func sendRouteBookmarkDataRequest(id: Int, success: (() -> ())?) {
        self.routeModel.sendRouteBookmarkDataRequest(id: id) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendRouteBookmarkDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension RouteViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func searchButton(_ sender: UIButton) {
        
    }
    
}

// MARK: - Extension for UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension RouteViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
        
        // 데이터 불러오기
        if self.selectedIndex == 0 {
            // 숙지된 노선
            self.loadKnowRouteListDataRequest(page: 1)
            
        } else {
            // 즐겨찾기 노선
            self.loadFavoriteRouteListDataRequest(page: 1)
            
        }
        self.tableView.reloadData()
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension RouteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteTableViewCell", for: indexPath) as! RouteTableViewCell
        let route = self.routeList[indexPath.row]
        
        cell.setCell(route: route)
        cell.delegate = self
        
        if self.selectedIndex == 0 {
            // 숙지된 노선
            if indexPath.row == self.routeList.count - 1 && self.nextRequest != nil {
                self.loadKnowRouteListDataRequest(page: self.page + 1)
                
            }
            
        } else {
            // 즐겨찾기
            if indexPath.row == self.routeList.count - 1 && self.nextRequest != nil {
                self.loadFavoriteRouteListDataRequest(page: self.page + 1)
                
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}


// FIXME: 삭제 부분 추가되면 재구현하기
extension RouteViewController: RouteBookmarkDelegate {
    func bookmarkRoute(id: Int) {
        if self.selectedIndex == 0 {
            SupportingMethods.shared.turnCoverView(.on)
            self.sendRouteBookmarkDataRequest(id: id) {
                self.loadKnowRouteListDataRequest(page: 1)
                
            }
            
        }
        
    }
    
    
}
