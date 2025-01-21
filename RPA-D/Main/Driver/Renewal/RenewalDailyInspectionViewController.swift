//
//  RenewalDailyInspectionViewController.swift
//  RPA-D
//
//  Created by 이주성 on 1/21/25.
//

import UIKit

struct VehicleInspection {
    let title: String
    let goodTitle: String
    let badTitle: String
    var contents: [VehicleInspectionContent]
}

struct VehicleInspectionContent {
    let title: String
    var status: Bool? = nil
}

final class RenewalDailyInspectionViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "일일 점검을 진행해 주세요."
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "0/14"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var moreInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "\(User.shared.name) | \(self.busNum) | \(SupportingMethods.shared.convertDate(intoString: Date(), "yyyy.MM.dd EEE요일"))"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 241, green: 241, blue: 241)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RenewalDailyInspectionTableViewCell.self, forCellReuseIdentifier: "RenewalDailyInspectionTableViewCell")
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
    
    let dispatchModel = DispatchModel()
    var busId: Int
    var busNum: String
    var inspectionList: [VehicleInspection] = [
        VehicleInspection(title: "차량상태", goodTitle: "O", badTitle: "X", contents: [
            VehicleInspectionContent(title: "내부"),
            VehicleInspectionContent(title: "외부"),
        ]),
        VehicleInspection(title: "엔진오일 점검", goodTitle: "양호", badTitle: "보충", contents: [
            VehicleInspectionContent(title: "엔진오일 점검")
        ]),
        VehicleInspection(title: "냉각수 점검", goodTitle: "양호", badTitle: "보충", contents: [
            VehicleInspectionContent(title: "냉각수 점검")
        ]),
        VehicleInspection(title: "요소수 점검", goodTitle: "양호", badTitle: "보충", contents: [
            VehicleInspectionContent(title: "요소수 점검")
        ]),
        VehicleInspection(title: "팬 벨트", goodTitle: "양호", badTitle: "고장", contents: [
            VehicleInspectionContent(title: "팬 벨트")
        ]),
        VehicleInspection(title: "등화 장치 점검", goodTitle: "양호", badTitle: "고장", contents: [
            VehicleInspectionContent(title: "라이트 (좌,우)"),
            VehicleInspectionContent(title: "방향지시등 (좌,우)"),
            VehicleInspectionContent(title: "후미등 및 브레이크"),
        ]),
        VehicleInspection(title: "스위치 작동 상태", goodTitle: "양호", badTitle: "고장", contents: [
            VehicleInspectionContent(title: "전문 (승차문)"),
            VehicleInspectionContent(title: "중문 (하차문)"),
            VehicleInspectionContent(title: "차고 (차량 높이)"),
        ]),
        VehicleInspection(title: "타이어 점검", goodTitle: "양호", badTitle: "고장", contents: [
            VehicleInspectionContent(title: "앞바퀴 (상 중 하)"),
            VehicleInspectionContent(title: "뒷바퀴 (상 중 하)"),
        ])
    ]
    var selectedIndex: Int = 0
    
    init(busId: Int, busNum: String) {
        self.busId = busId
        self.busNum = busNum
        
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
        print("----------------------------------- RenewalDailyInspectionViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RenewalDailyInspectionViewController: EssentialViewMethods {
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
            self.countLabel,
            self.moreInfoLabel,
            self.borderView,
            self.tableView,
            self.submitButton,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
        ])
        
        // countLabel
        NSLayoutConstraint.activate([
            self.countLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.countLabel.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
        ])
        
        // moreInfoLabel
        NSLayoutConstraint.activate([
            self.moreInfoLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.moreInfoLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
        ])
        
        // borderView
        NSLayoutConstraint.activate([
            self.borderView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.borderView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.borderView.bottomAnchor.constraint(equalTo: self.tableView.topAnchor),
            self.borderView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.moreInfoLabel.bottomAnchor, constant: 20),
            self.tableView.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor, constant: -10),
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
extension RenewalDailyInspectionViewController {
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
extension RenewalDailyInspectionViewController {
    @objc func submitButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.sendVehicleCheckDataRequest {
            self.dismiss(animated: true) {
                NotificationCenter.default.post(name: Notification.Name("ReloadAllData"), object: nil)
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
    }
    
    @objc func reloadData(_ notification: Notification) {
        guard let index = notification.userInfo?["index"] as? Int else { return }
        guard let status = notification.userInfo?["status"] as? Bool else { return }
        guard let contentsIndex = notification.userInfo?["contentsIndex"] as? Int else { return }
        
//        let problemIndexList: [Int] = [0,1,2,3,6,8]
//        if problemIndexList.contains(index) && status == false {
//            // 회사로 전화
//            self.inspectionList[index].status = nil
//            if let url = URL(string: "tel://1522-9821") {
//                UIApplication.shared.open(url)
//                
//            }
//            
//        } else {
//            // 정상 운행 진행
//            self.inspectionList[index].status = status
//            
//        }
        
        self.inspectionList[index].contents[contentsIndex].status = status
        
        self.tableView.reloadData()
        
        var sumCount: Int = 0
        for inspection in self.inspectionList {
            sumCount += inspection.contents.filter({ $0.status != nil }).count
            
        }
        
        self.countLabel.text = "\(sumCount)/14"
        
        if sumCount == 14 {
            self.submitButton.isEnabled = true
            self.submitButton.setTitleColor(.white, for: .normal)
            self.submitButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            
        } else {
            self.submitButton.isEnabled = false
            self.submitButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            self.submitButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            
        }
        
    }
    
}

// MARK: - Extension for selector methods
extension RenewalDailyInspectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inspectionList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RenewalDailyInspectionTableViewCell", for: indexPath) as! RenewalDailyInspectionTableViewCell
        let inspection = self.inspectionList[indexPath.row]
        
        cell.setCell(inspection: inspection, index: indexPath.row)
        cell.titleBaseView.isHidden = self.selectedIndex == indexPath.row ? true : false
        cell.mainStackView.isHidden = self.selectedIndex == indexPath.row ? false : true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        self.tableView.reloadData()
        
    }
    
}
