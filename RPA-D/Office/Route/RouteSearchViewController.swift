//
//  RouteSearchViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/16/24.
//

import UIKit

final class RouteSearchViewController: UIViewController {
    
    lazy var noRouteDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noRouteDataImageView, self.noRouteDataTitleLabel])
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
    
    let searchController = UISearchController(searchResultsController: nil)
    let routeModel = RouteModel()
    var page: Int = 1
    var nextRequest: String?
    var routeList: [RouteListItem] = []
    var searchText: String = ""
    
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
        self.setUpSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- RouteSearchViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RouteSearchViewController: EssentialViewMethods {
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
            self.tableView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
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
        
        self.navigationItem.title = "노선 검색"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setUpSearchController() {
        self.searchController.searchBar.searchTextField.setPlaceholder(placeholder: "어떤 노선을 찾으세요?")
        self.searchController.searchBar.searchTextField.textColor = .useRGB(red: 46, green: 45, blue: 45)
        self.searchController.searchBar.searchTextField.font = .useFont(ofSize: 14, weight: .Regular)
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.automaticallyShowsCancelButton = false
        
        // searchbar에 text가 업데이트 될 때마다 불리는 메소드를 위한 설정
        self.searchController.searchResultsUpdater = self
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
}

// MARK: - Extension for methods added
extension RouteSearchViewController {
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
    
    func loadRouteListDataRequestForSearch(page: Int, search: String, completionHandler: ((RouteItem) -> ())? = nil) {
        self.loadRouteListDataRequest(page: page, search: search) { item in
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
                self.noRouteDataTitleLabel.text = "검색 결과가 없습니다!"
                self.noRouteDataStackView.isHidden = false
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
            completionHandler?(item)
        }
    }
    
    func loadRouteDetailDataRequest(id: Int, success: ((RouteDetailItem) -> ())?) {
        self.routeModel.loadRouteDetailDataRequest(id: id) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadRouteDetailDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension RouteSearchViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

// MARK: - Extension for UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating
extension RouteSearchViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.loadRouteListDataRequestForSearch(page: 1, search: searchController.searchBar.text ?? "")
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.loadRouteListDataRequestForSearch(page: 1, search: searchBar.text ?? "")
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
        
    }
    
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension RouteSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RouteTableViewCell", for: indexPath) as! RouteTableViewCell
        let route = self.routeList[indexPath.row]
        
        cell.setCell(route: route)
        
        if indexPath.row == self.routeList.count - 1 && self.nextRequest != nil {
            self.loadRouteListDataRequestForSearch(page: self.page + 1, search: self.searchText)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let route = self.routeList[indexPath.row]
        SupportingMethods.shared.turnCoverView(.on)
        self.loadRouteDetailDataRequest(id: route.id) { item in
            let vc = RouteDetailViewController(id: route.id, item: item)
            
            self.navigationController?.pushViewController(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
        }
    }
    
}
