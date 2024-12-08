//
//  MorningRollCallViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 11/27/24.
//

import UIKit

final class MorningRollCallViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "아침 점호를 진행해 주세요"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "점검지 제출 시간이 출근 시간으로 기록됩니다."
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "점호지 도착시간"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = SupportingMethods.shared.convertDate(intoString: Date(), "a HH:mm")
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MorningRollCallTableViewCell.self, forCellReuseIdentifier: "MorningRollCallTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var alcoholBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var alcoholTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "음주 측정"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var alcoholGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "0.03 이상 시 운행이 불가능합니다."
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var alcoholMeasurementTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        textField.layer.cornerRadius = 8
        textField.setPlaceholder(placeholder: "음주 측정")
        textField.addLeftPadding()
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("일일 점검 진행", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(nextButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var nextButtonBottomAnchorConstraint: NSLayoutConstraint!
    var rollCallList: [(title: String, status: Bool)] = [ // true: 양호, false: 이상
        ("건강 상태", true),
        ("청소 상태", true),
        ("노선 숙지", true),
    ]
    
    let dispatchModel = DispatchModel()
    
    init() {
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    deinit {
        print("----------------------------------- MorningRollCallViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension MorningRollCallViewController: EssentialViewMethods {
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataForCheckRollCall(_:)), name: Notification.Name("CheckRollCall"), object: nil)
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.subTitleLabel,
            self.arrivalTimeTitleLabel,
            self.arrivalTimeBaseView,
            self.tableView,
            self.alcoholBaseView,
            self.nextButton,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.alcoholTitleLabel,
            self.alcoholGuideLabel,
            self.alcoholMeasurementTextField,
        ], to: self.alcoholBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.arrivalTimeLabel,
        ], to: self.arrivalTimeBaseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 52),
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4),
        ])
        
        // arrivalTimeTitleLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.arrivalTimeTitleLabel.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 24),
        ])
        
        // arrivalTimeBaseView
        NSLayoutConstraint.activate([
            self.arrivalTimeBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.arrivalTimeBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.arrivalTimeBaseView.topAnchor.constraint(equalTo: self.arrivalTimeTitleLabel.bottomAnchor, constant: 8),
            self.arrivalTimeBaseView.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalTimeBaseView.leadingAnchor, constant: 12),
            self.arrivalTimeLabel.centerYAnchor.constraint(equalTo: self.arrivalTimeBaseView.centerYAnchor),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.arrivalTimeBaseView.bottomAnchor, constant: 20),
            self.tableView.bottomAnchor.constraint(equalTo: self.alcoholBaseView.topAnchor, constant: -20),
        ])
        
        // alcoholBaseView
        NSLayoutConstraint.activate([
            self.alcoholBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.alcoholBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.alcoholBaseView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -26),
        ])
        
        // alcoholTitleLabel
        NSLayoutConstraint.activate([
            self.alcoholTitleLabel.topAnchor.constraint(equalTo: self.alcoholBaseView.topAnchor),
            self.alcoholTitleLabel.leadingAnchor.constraint(equalTo: self.alcoholBaseView.leadingAnchor, constant: 20),
            self.alcoholTitleLabel.bottomAnchor.constraint(equalTo: self.alcoholMeasurementTextField.topAnchor, constant: -8),
        ])
        
        // alcoholGuideLabel
        NSLayoutConstraint.activate([
            self.alcoholGuideLabel.trailingAnchor.constraint(equalTo: self.alcoholBaseView.trailingAnchor, constant: -20),
            self.alcoholGuideLabel.bottomAnchor.constraint(equalTo: self.alcoholMeasurementTextField.topAnchor, constant: -8),
        ])
        
        // alcoholMeasurementTextField
        NSLayoutConstraint.activate([
            self.alcoholMeasurementTextField.leadingAnchor.constraint(equalTo: self.alcoholBaseView.leadingAnchor, constant: 20),
            self.alcoholMeasurementTextField.trailingAnchor.constraint(equalTo: self.alcoholBaseView.trailingAnchor, constant: -20),
            self.alcoholMeasurementTextField.bottomAnchor.constraint(equalTo: self.alcoholBaseView.bottomAnchor),
            self.alcoholMeasurementTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // nextButton
        self.nextButtonBottomAnchorConstraint = self.nextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([
            self.nextButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.nextButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.nextButtonBottomAnchorConstraint,
            self.nextButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension MorningRollCallViewController {
    func sendMorningRollCallDataRequest(arrivalTime: String, healthStatus: Bool, cleanStatus: Bool, routeKnowStatus: Bool, alcohol: Double, success: (() -> ())?) {
        self.dispatchModel.sendMorningRollCallDataRequest(arrivalTime: arrivalTime, healthStatus: healthStatus, cleanStatus: cleanStatus, routeKnowStatus: routeKnowStatus, alcohol: alcohol) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendMorningRollCallDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension MorningRollCallViewController {
    @objc func nextButton(_ sender: UIButton) {
        self.sendMorningRollCallDataRequest(arrivalTime: self.arrivalTimeLabel.text!, healthStatus: self.rollCallList[0].status, cleanStatus: self.rollCallList[1].status, routeKnowStatus: self.rollCallList[2].status, alcohol: Double(self.alcoholMeasurementTextField.text!)!) {
            self.dismiss(animated: false) {
                NotificationCenter.default.post(name: Notification.Name("OpenDailyInspection"), object: nil)
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                self.nextButtonBottomAnchorConstraint.constant = -keyboardSize.height
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                self.nextButtonBottomAnchorConstraint.constant = 0
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func reloadDataForCheckRollCall(_ notification: Notification) {
        guard let status = notification.userInfo?["status"] as? Bool else { return }
        guard let index = notification.userInfo?["index"] as? Int else { return }
        
        self.rollCallList[index].status = status
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
        
    }
    
}

// MARK: - Extension for UITextFieldDelegate
extension MorningRollCallViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text != "" && Double(textField.text!)! < 0.03 {
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.nextButton.setTitleColor(.white, for: .normal)
            
        } else {
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.nextButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        }
        
    }
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension MorningRollCallViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rollCallList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MorningRollCallTableViewCell", for: indexPath) as! MorningRollCallTableViewCell
        let rollCall = self.rollCallList[indexPath.row]
        
        cell.setCell(rollCall: rollCall, index: indexPath.row)
        
        return cell
    }
}
