//
//  MainViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    lazy var statusBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
    
    var dispatchIsHiddenStatus: [Bool] = []
    var role: Role = .driver
    
    let mainModel = MainModel()
    var routine: RoutineItem?
    var goToWorkData: RoutineGoToWork?
    var dispatchList: [RoutineDispatch?] = []
    var getOffWorkData: RoutineGetOffWork?
    
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
    
    deinit {
        print("----------------------------------- MainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension MainViewController: EssentialViewMethods {
    func setViewFoundation() {
        
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
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.statusBaseView,
            self.tableView,
        ], to: self.view)
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
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.statusBaseView.bottomAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
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
            let leftBarButtonItem = UIBarButtonItem(title: "운행", style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
            leftBarButtonItem.setTitleTextAttributes([
                .font:UIFont.useFont(ofSize: 20, weight: .Bold),
                .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
            ], for: .normal)
            self.navigationItem.leftBarButtonItem = leftBarButtonItem
            
        }
        
    }
    
    func setData() {
        self.loadDailyRoutineDataRequest { item in
            print("routine Item: \(item)")
            self.routine = item
            
            if item.tasks.isEmpty {
                
            } else {
                self.goToWorkData = item.goToWork
                self.dispatchList = item.tasks
                self.getOffWorkData = item.getOffWork
                
                self.dispatchIsHiddenStatus = Array(repeating: true, count: self.dispatchList.count)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
                
            }
            
            
            
            if item.goToWork.wakeTime == "" {
//                let vc = GetUpCheckViewController()
//                
//                self.present(vc, animated: false)
            } else {
                
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
}

// MARK: - Extension for selector methods
extension MainViewController {
    // FIXME: 추후 삭제 필수
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        let vc = GetUpCheckViewController()
        
        self.present(vc, animated: true)
    }
    
    @objc func reloadData(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        
        self.dispatchIsHiddenStatus[index].toggle()
        self.tableView.reloadData()
//        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
    }
    
    @objc func workReloadData(_ notification: Notification) {
        self.tableView.reloadData()
        
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
            
            cell.setCell()
            
            return cell
        } else if indexPath.section == 1 {
            // GoToWorkTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoToWorkTableViewCell", for: indexPath) as! GoToWorkTableViewCell
            
            cell.setCell(routine: self.routine)
            
            return cell
            
        } else if indexPath.section == 3 {
            // GetOffWorkTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "GetOffWorkTableViewCell", for: indexPath) as! GetOffWorkTableViewCell
            
            cell.setCell()
            
            return cell
            
        } else {
            // DispatchTableViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchTableViewCell", for: indexPath) as! DispatchTableViewCell
            
            cell.dispatchContentBaseView.isHidden = self.dispatchIsHiddenStatus[indexPath.row]
            cell.setCell(index: indexPath.row)
            
            return cell
            
        }
        
    }
}

