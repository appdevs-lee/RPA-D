//
//  ManagerMainViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/16/24.
//

import UIKit

final class ManagerMainViewController: UIViewController {
    
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
        label.text = "확인할 노선이 없어요"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var noRoutineDataSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "모두 정상적으로 운행되고 있습니다"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "관리자님\n문제 노선을 확인해 주세요!"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "확인되지 않은 문제 노선이 있습니다!"
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProblemRouteTableViewCell.self, forCellReuseIdentifier: "ProblemRouteTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let mainModel = MainModel()
    var problemList: [ProblemListItem] = []
    
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
        print("----------------------------------- ManagerMainViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension ManagerMainViewController: EssentialViewMethods {
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
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.subTitleLabel,
            self.tableView,
            self.noRoutineDataBaseView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.noRoutineDataStackView,
        ], to: self.noRoutineDataBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 36),
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 24),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
        ])
        
        // noRoutineDataBaseView
        NSLayoutConstraint.activate([
            self.noRoutineDataBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.noRoutineDataBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.noRoutineDataBaseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.noRoutineDataBaseView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // noRoutineDataStackView
        NSLayoutConstraint.activate([
            self.noRoutineDataStackView.leadingAnchor.constraint(equalTo: self.noRoutineDataBaseView.leadingAnchor, constant: 20),
            self.noRoutineDataStackView.trailingAnchor.constraint(equalTo: self.noRoutineDataBaseView.trailingAnchor, constant: -20),
            self.noRoutineDataStackView.centerYAnchor.constraint(equalTo: self.noRoutineDataBaseView.centerYAnchor),
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
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = ""
        
        let leftBarButtonItem = UIBarButtonItem(title: "노선", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 20, weight: .Bold),
            .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .useCustomImage("notificationImage").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightBarButtonItem(_:)))
        
    }
    
    func setData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadProblemListDataRequest { item in
            self.problemList = item
            
            if item.isEmpty {
                self.noRoutineDataBaseView.isHidden = false
                
            } else {
                self.noRoutineDataBaseView.isHidden = true
                
            }
            
            self.tableView.reloadData()
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        
    }
    
}

// MARK: - Extension for methods added
extension ManagerMainViewController {
    func loadProblemListDataRequest(success: (([ProblemListItem]) -> ())?) {
        self.mainModel.loadProblemListDataRequest { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadProblemListDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        }

    }
    
    func loadProblemRouteDetailDataRequest(id: Int, workType: String, success: ((ProblemDetailItem) -> ())?) {
        self.mainModel.loadProblemRouteDetailDataRequest(id: id, workType: workType) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadProblemRouteDetailDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        }

    }
    
}

// MARK: - Extension for selector methods
extension ManagerMainViewController {
    @objc func rightBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        // 알림 모아보기
        let vc = NotificationListViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension ManagerMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.problemList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProblemRouteTableViewCell", for: indexPath) as! ProblemRouteTableViewCell
        let problem = self.problemList[indexPath.row]
        
        cell.setCell(problem: problem)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let problem = self.problemList[indexPath.row]
        SupportingMethods.shared.turnCoverView(.on)
        self.loadProblemRouteDetailDataRequest(id: problem.id, workType: problem.workType) { item in
            let vc = ProblemDetailViewController(item: item)
            
            self.navigationController?.pushViewController(vc, animated: true)
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        
    }
    
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension ManagerMainViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
    
}
