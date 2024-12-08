//
//  DailyInspectionViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 12/6/24.
//

import UIKit

struct Inspection {
    let title: String
    var status: Bool? = nil
}

final class DailyInspectionViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "일일 점검을 진행해 주세요."
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DailyInspectionTableViewCell.self, forCellReuseIdentifier: "DailyInspectionTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("점검지 제출", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(submitButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var busId: Int
    var inspectionList: [Inspection] = [
        Inspection(title: "엔진오일 확인"),
        Inspection(title: "파워오일, 클러치 확인"),
        Inspection(title: "냉각수, 부동액 확인"),
        Inspection(title: "외부차체상태(파손 여부) 확인"),
        Inspection(title: "등화장치(실내/외) 확인"),
        Inspection(title: "블랙박스(작동 여부) 확인"),
        Inspection(title: "타이어 상태(나사, 못 등) 확인"),
        Inspection(title: "실내(복도, 선반, 청소 등) 상태 확인"),
        Inspection(title: "안전벨트/슬라이드 확인"),
        Inspection(title: "제복 착용"),
    ]
    var selectedIndex: Int = 0
    let dispatchModel = DispatchModel()
    
    init(busId: Int) {
        self.busId = busId
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .fullScreen
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- DailyInspectionViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DailyInspectionViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: Notification.Name("InspectionReloadData"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.tableView,
            self.submitButton,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 52),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor, constant: -20),
        ])
        
        // submitButton
        NSLayoutConstraint.activate([
            self.submitButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.submitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.submitButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -24),
            self.submitButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension DailyInspectionViewController {
    func sendVehicleCheckDataRequest(success: (() -> ())?) {
        self.dispatchModel.sendVehicleCheckDataRequest(busId: self.busId, inspectionList: self.inspectionList) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendVehicleCheckDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
}

// MARK: - Extension for selector methods
extension DailyInspectionViewController {
    @objc func reloadData(_ notification: Notification) {
        guard let status = notification.userInfo?["status"] as? Bool else { return }
        guard let index = notification.userInfo?["index"] as? Int else { return }
        let problemIndexList: [Int] = [0,1,2,3,6,8]
        if problemIndexList.contains(index) && status == false {
            // 회사로 전화
            self.inspectionList[index].status = nil
            if let url = URL(string: "tel://1522-9821") {
                UIApplication.shared.open(url)
                
            }
            
        } else {
            // 정상 운행 진행
            self.inspectionList[index].status = status
            
        }
        
        self.tableView.reloadData()
        
        if self.inspectionList.filter({ $0.status == nil }).isEmpty {
            self.submitButton.isEnabled = true
            self.submitButton.setTitleColor(.white, for: .normal)
            self.submitButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            
        } else {
            self.submitButton.isEnabled = false
            self.submitButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            self.submitButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            
        }
        
    }
    
    @objc func submitButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.sendVehicleCheckDataRequest {
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: Notification.Name("ReloadAllData"), object: nil)
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DailyInspectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inspectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyInspectionTableViewCell", for: indexPath) as! DailyInspectionTableViewCell
        let inspection = self.inspectionList[indexPath.row]
        
        cell.setCell(inspection: inspection, index: indexPath.row)
        cell.titleBaseView.isHidden = self.selectedIndex == indexPath.row ? true : false
        cell.buttonBaseView.isHidden = self.selectedIndex == indexPath.row ? false : true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        self.tableView.reloadData()
        
    }
    
}

