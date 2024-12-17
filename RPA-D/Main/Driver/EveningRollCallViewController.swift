//
//  EveningRollCallViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 12/9/24.
//

import UIKit

final class EveningRollCallViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "저녁 점호를 진행해 주세요."
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.keyboardDismissMode = .onDrag
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: 메인 스위치
    lazy var mainSwitchTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "메인 스위치"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var mainSwitchOnButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setTitle("ON", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var mainSwitchOffButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setTitle("OFF", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(offButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: 계기판
    lazy var dashboardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "계기판"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dashboardTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 46, green: 45, blue: 45)
        textField.font = .useFont(ofSize: 14, weight: .Regular)
        textField.borderStyle = .none
        textField.keyboardType = .decimalPad
        textField.addLeftPadding()
        textField.setPlaceholder(placeholder: "계기판 수치를 입력해 주세요")
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // MARK: 현재 주유량
    lazy var fuelTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 주유량"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var fuelSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 0
        slider.minimumTrackTintColor = .useRGB(red: 223, green: 52, blue: 52)
        slider.setThumbImage(.useCustomImage("fuel.thumb.image"), for: .normal)
        slider.addTarget(self, action: #selector(fuelValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    
    lazy var fuelLabel: UILabel = {
        let label = UILabel()
        label.text = "0%"
        label.textColor = .useRGB(red: 223, green: 52, blue: 52)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: 현재 요소수량
    lazy var ureaTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 요소수량"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var ureaTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 46, green: 45, blue: 45)
        textField.font = .useFont(ofSize: 14, weight: .Regular)
        textField.borderStyle = .none
        textField.keyboardType = .decimalPad
        textField.addLeftPadding()
        textField.setPlaceholder(placeholder: "요소수 량을 입력해 주세요")
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // MARK: 수트게이지
    lazy var gaugeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "수트 게이지"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var gaugeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.value = 0
        slider.minimumTrackTintColor = .useRGB(red: 223, green: 52, blue: 52)
        slider.setThumbImage(.useCustomImage("guage.thumb.image"), for: .normal)
        slider.addTarget(self, action: #selector(gaugeValueChanged(_:)), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    
    lazy var gaugeLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .useRGB(red: 223, green: 52, blue: 52)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: 특이사항
    lazy var specialTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "특이사항"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var specialTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 46, green: 45, blue: 45)
        textField.font = .useFont(ofSize: 14, weight: .Regular)
        textField.borderStyle = .none
        textField.addLeftPadding()
        textField.setPlaceholder(placeholder: "특이사항을 입력해 주세요")
        textField.layer.cornerRadius = 8
        textField.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("점검지 제출", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.addTarget(self, action: #selector(submitButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let dispatchModel = DispatchModel()
    var titleLabelTopAnchorConstraint: NSLayoutConstraint!
    var selectedIndex: Int?
    var submitCheck: (mainSwitch: Bool, dashboard: Bool, fuel: Bool, urea: Bool, gauge: Bool) = (false, false, false, false, false)
    
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
    
    deinit {
        print("----------------------------------- EveningRollCallViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension EveningRollCallViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let baseViewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBaseView(_:)))
        self.baseView.addGestureRecognizer(baseViewTapGesture)
        self.baseView.isUserInteractionEnabled = true
        
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.scrollView,
            self.baseView,
            self.submitButton,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.mainSwitchTitleLabel,
            self.mainSwitchOnButton,
            self.mainSwitchOffButton,
            
            self.dashboardTitleLabel,
            self.dashboardTextField,
            
            self.fuelTitleLabel,
            self.fuelLabel,
            self.fuelSlider,
            
            self.ureaTitleLabel,
            self.ureaTextField,
            
            self.gaugeTitleLabel,
            self.gaugeLabel,
            self.gaugeSlider,
            
            self.specialTitleLabel,
            self.specialTextField,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // titleLabel
        self.titleLabelTopAnchorConstraint = self.titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 46)
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.titleLabelTopAnchorConstraint,
        ])
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 24),
            self.scrollView.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor, constant: -10),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
        ])
        
        // mainSwitchTitleLabel
        NSLayoutConstraint.activate([
            self.mainSwitchTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.mainSwitchTitleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor),
        ])
        
        // mainSwitchOnButton
        NSLayoutConstraint.activate([
            self.mainSwitchOnButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.mainSwitchOnButton.trailingAnchor.constraint(equalTo: self.mainSwitchOffButton.leadingAnchor, constant: -8),
            self.mainSwitchOnButton.topAnchor.constraint(equalTo: self.mainSwitchTitleLabel.bottomAnchor, constant: 8),
            self.mainSwitchOnButton.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // mainSwitchOffButton
        NSLayoutConstraint.activate([
            self.mainSwitchOffButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.mainSwitchOffButton.topAnchor.constraint(equalTo: self.mainSwitchTitleLabel.bottomAnchor, constant: 8),
            self.mainSwitchOffButton.heightAnchor.constraint(equalToConstant: 48),
            self.mainSwitchOffButton.widthAnchor.constraint(equalTo: self.mainSwitchOnButton.widthAnchor, multiplier: 1.0)
        ])
        
        // dashboardTitleLabel
        NSLayoutConstraint.activate([
            self.dashboardTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dashboardTitleLabel.topAnchor.constraint(equalTo: self.mainSwitchOnButton.bottomAnchor, constant: 20),
        ])
        
        // dashboardTextField
        NSLayoutConstraint.activate([
            self.dashboardTextField.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dashboardTextField.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.dashboardTextField.topAnchor.constraint(equalTo: self.dashboardTitleLabel.bottomAnchor, constant: 8),
            self.dashboardTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // fuelTitleLabel
        NSLayoutConstraint.activate([
            self.fuelTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.fuelTitleLabel.topAnchor.constraint(equalTo: self.dashboardTextField.bottomAnchor, constant: 20),
        ])
        
        // fuelLabel
        NSLayoutConstraint.activate([
            self.fuelLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.fuelLabel.centerYAnchor.constraint(equalTo: self.fuelTitleLabel.centerYAnchor),
        ])
        
        // fuelSlider
        NSLayoutConstraint.activate([
            self.fuelSlider.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.fuelSlider.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.fuelSlider.topAnchor.constraint(equalTo: self.fuelLabel.bottomAnchor, constant: 8),
            self.fuelSlider.heightAnchor.constraint(equalToConstant: 32),
        ])
        
        // ureaTitleLabel
        NSLayoutConstraint.activate([
            self.ureaTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.ureaTitleLabel.topAnchor.constraint(equalTo: self.fuelSlider.bottomAnchor, constant: 20),
        ])
        
        // ureaTextField
        NSLayoutConstraint.activate([
            self.ureaTextField.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.ureaTextField.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.ureaTextField.topAnchor.constraint(equalTo: self.ureaTitleLabel.bottomAnchor, constant: 8),
            self.ureaTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        // gaugeTitleLabel
        NSLayoutConstraint.activate([
            self.gaugeTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.gaugeTitleLabel.topAnchor.constraint(equalTo: self.ureaTextField.bottomAnchor, constant: 20),
        ])
        
        // gaugeLabel
        NSLayoutConstraint.activate([
            self.gaugeLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.gaugeLabel.centerYAnchor.constraint(equalTo: self.gaugeTitleLabel.centerYAnchor),
        ])
        
        // gaugeSlider
        NSLayoutConstraint.activate([
            self.gaugeSlider.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.gaugeSlider.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.gaugeSlider.topAnchor.constraint(equalTo: self.gaugeLabel.bottomAnchor, constant: 8),
            self.gaugeSlider.heightAnchor.constraint(equalToConstant: 32),
        ])
        
        // specialTitleLabel
        NSLayoutConstraint.activate([
            self.specialTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.specialTitleLabel.topAnchor.constraint(equalTo: self.gaugeSlider.bottomAnchor, constant: 20),
        ])
        
        // specialTextField
        NSLayoutConstraint.activate([
            self.specialTextField.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.specialTextField.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.specialTextField.topAnchor.constraint(equalTo: self.specialTitleLabel.bottomAnchor, constant: 8),
            self.specialTextField.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -20),
            self.specialTextField.heightAnchor.constraint(equalToConstant: 48),
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
extension EveningRollCallViewController {
    func reloadData() {
        if self.selectedIndex == 0 {
            // onButton 클릭
            self.mainSwitchOnButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.mainSwitchOnButton.setTitleColor(.white, for: .normal)
            
            self.mainSwitchOffButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.mainSwitchOffButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
            
        } else if self.selectedIndex == 1 {
            // offButton 클릭
            self.mainSwitchOffButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.mainSwitchOffButton.setTitleColor(.white, for: .normal)
            
            self.mainSwitchOnButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.mainSwitchOnButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        } else {
            self.mainSwitchOnButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.mainSwitchOnButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
            self.mainSwitchOffButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.mainSwitchOffButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        }
        
        self.checkValidation()
    }
    
    func checkValidation() {
        if self.submitCheck.dashboard && self.submitCheck.fuel && self.submitCheck.gauge && self.submitCheck.mainSwitch && self.submitCheck.urea {
            self.submitButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.submitButton.setTitleColor(.white, for: .normal)
            self.submitButton.isEnabled = true
            
        } else {
            self.submitButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.submitButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            self.submitButton.isEnabled = false
            
        }
        
    }
    
    func sendEveningRollCallDataRequest(success: (() -> ())?) {
        self.dispatchModel.sendEveningRollCallDataRequest(dashboard: self.dashboardTextField.text!, fuel: String(self.fuelSlider.value), urea: self.ureaTextField.text!, gauge: String(self.gaugeSlider.value), specialNotes: self.specialTextField.text ?? "없음") {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendEveningRollCallDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension EveningRollCallViewController {
    @objc func fuelValueChanged(_ sender: UISlider) {
        self.fuelLabel.text = "\(String(format: "%.2f", sender.value))%"
        if sender.value < 50 {
            self.submitCheck.fuel = false
            
        } else {
            self.submitCheck.fuel = true
            
        }
        
        self.checkValidation()
        
    }
    
    @objc func gaugeValueChanged(_ sender: UISlider) {
        self.gaugeLabel.text = "\(Int(sender.value))"
        if Int(sender.value) > 6 {
            self.submitCheck.gauge = false
            
        } else {
            self.submitCheck.gauge = true
            
        }
        
        self.checkValidation()
        
    }
    
    @objc func tappedBaseView(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
        
    }
    
    @objc func onButton(_ sender: UIButton) {
        SupportingMethods.shared.showAlertNoti(title: "메인 스위치를 반드시 꺼주세요")
        self.selectedIndex = nil
        self.submitCheck.mainSwitch = false
        self.reloadData()
        
    }
    
    @objc func offButton(_ sender: UIButton) {
        self.selectedIndex = sender.tag
        self.submitCheck.mainSwitch = true
        self.reloadData()
        
    }
    
    @objc func submitButton(_ sender: UIButton) {
        SupportingMethods.shared.turnCoverView(.on)
        self.sendEveningRollCallDataRequest {
            self.dismiss(animated: true) {
                SupportingMethods.shared.showAlertNoti(title: "점검지 제출이 완료되었습니다.")
                SupportingMethods.shared.turnCoverView(.off)
                NotificationCenter.default.post(name: Notification.Name("ReloadAllData"), object: nil)
                
            }
            
        }
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                let keyboardYValue = (ReferenceValues.Size.Device.height - ReferenceValues.Size.StatusBar.height) - keyboardSize.height
                let ureaYValue = self.scrollView.frame.minY + self.ureaTextField.frame.maxY
                let specialYValue = self.scrollView.frame.minY + self.specialTextField.frame.maxY
                
                print(keyboardYValue)
                print("urea: \(keyboardYValue - ureaYValue)")
                print("specialNotes: \(keyboardYValue - specialYValue)")
                
                if self.ureaTextField.isEditing {
                    if (keyboardYValue - ureaYValue) < 0 {
                        self.titleLabelTopAnchorConstraint.constant += (keyboardYValue - ureaYValue)
                        
                    }
                    
                    
                } else if self.specialTextField.isEditing {
                    if (keyboardYValue - specialYValue) < 0 {
                        self.titleLabelTopAnchorConstraint.constant += (keyboardYValue - specialYValue)
                        
                    }
                    
                }
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                self.titleLabelTopAnchorConstraint.constant = 46
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
}

extension EveningRollCallViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 백스페이스 실행가능하게 하게하기
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                return true
            }
        }
        // 숫자만 && 글자수 제한
        guard textField.text!.count < 6 else { return false }
            
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.dashboardTextField.text != "" && self.ureaTextField.text != "" {
            self.submitCheck.dashboard = true
            self.submitCheck.urea = true
            
        } else if self.dashboardTextField.text == "" {
            self.submitCheck.dashboard = false
            
        } else if self.ureaTextField.text == "" {
            self.submitCheck.urea = false
            
        }
        self.checkValidation()
        
    }
    
}
