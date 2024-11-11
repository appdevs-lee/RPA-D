//
//  SplashViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/10/24.
//

import UIKit

final class SplashViewController: UIViewController {
    
    lazy var splashView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 184, green: 0, blue: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var splashLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("SplashLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KingbusLoginLogo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var idStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.idTitleLabel, self.idTextField, self.idAlertLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var idTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.textColor = .useRGB(red: 51, green: 51, blue: 51)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 51, green: 51, blue: 51)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.setPlaceholder(placeholder: "아이디를 입력해주세요.")
        textField.setBorder(imageName: "IdIcon")
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var idAlertLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "등록되지 않은 계정이거나, 아이디를 다시 확인해주세요"
        label.textColor = .useRGB(red: 234, green: 7, blue: 48)
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.passwordTitleLabel, self.passwordTextField, self.passwordAlertLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.textColor = .useRGB(red: 51, green: 51, blue: 51)
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .useRGB(red: 51, green: 51, blue: 51)
        textField.font = .useFont(ofSize: 14, weight: .Medium)
        textField.isSecureTextEntry = true
        textField.setPlaceholder(placeholder: "비밀번호를 입력해주세요.")
        textField.setBorder(imageName: "PasswordIcon")
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var secretButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setImage(.useCustomImage("secretImage"), for: .normal)
        button.addTarget(self, action: #selector(secretButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var passwordAlertLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "등록되지 않은 계정이거나, 아이디를 다시 확인해주세요"
        label.textColor = .useRGB(red: 234, green: 7, blue: 48)
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("로그인", for: .normal)
        button.setImage(.useCustomImage("login.off"), for: .disabled)
        button.setImage(.useCustomImage("login.on"), for: .normal)
        button.setImage(.useCustomImage("selectedLogin.on"), for: .highlighted)
        button.addTarget(self, action: #selector(loginButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let loginModel = LoginModel()
    
    var timer: Timer?
    var timerNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        self.startTimer()
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
        print("----------------------------------- RenewalLoginViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension SplashViewController: EssentialViewMethods {
    func setViewFoundation() {
        self.view.backgroundColor = .white
        ReferenceValues.firstVC = self
        
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
            self.logoImageView,
            self.idStackView,
            self.passwordStackView,
            self.secretButton,
            self.loginButton,
            self.splashView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.splashLogoImageView,
        ], to: self.splashView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // logoImageView
        NSLayoutConstraint.activate([
            self.logoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.logoImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 40),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 60),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 176),
        ])
        
        // idStackView
        NSLayoutConstraint.activate([
            self.idStackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 48),
            self.idStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.idStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
        ])
        
        // idTextField
        NSLayoutConstraint.activate([
            self.idTextField.heightAnchor.constraint(equalToConstant: 56),
        ])

        // passwordStackView
        NSLayoutConstraint.activate([
            self.passwordStackView.topAnchor.constraint(equalTo: self.idStackView.bottomAnchor, constant: 20),
            self.passwordStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.passwordStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
        ])
        
        // passwordTextField
        NSLayoutConstraint.activate([
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        // secretButton
        NSLayoutConstraint.activate([
            self.secretButton.trailingAnchor.constraint(equalTo: self.passwordTextField.trailingAnchor),
            self.secretButton.centerYAnchor.constraint(equalTo: self.passwordTextField.centerYAnchor),
            self.secretButton.topAnchor.constraint(equalTo: self.passwordTextField.topAnchor),
            self.secretButton.bottomAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor),
            self.secretButton.widthAnchor.constraint(equalToConstant: 52),
        ])
        
        // loginButton
        NSLayoutConstraint.activate([
            self.loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24),
            self.loginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24),
            self.loginButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            self.loginButton.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        // splashView
        NSLayoutConstraint.activate([
            self.splashView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.splashView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.splashView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.splashView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // splashLogoImageView
        NSLayoutConstraint.activate([
            self.splashLogoImageView.centerXAnchor.constraint(equalTo: self.splashView.centerXAnchor),
            self.splashLogoImageView.centerYAnchor.constraint(equalTo: self.splashView.centerYAnchor),
            self.splashLogoImageView.widthAnchor.constraint(equalToConstant: 150),
            self.splashLogoImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
        
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extension for methods added
extension SplashViewController {
    func startTimer() {
        //기존에 타이머 동작중이면 중지 처리
        if self.timer != nil && self.timer!.isValid {
            self.timer!.invalidate()
        }

        self.timerNum = 2
        
        //1초 간격 타이머 시작
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    func checkPermission() {
        // 권한 허용 확인
        if ReferenceValues.isCheckPermission {
            if ReferenceValues.isLoginCheck {
                SupportingMethods.shared.turnCoverView(.on)
                self.tokenRefreshRequest {
                    self.proceedLoginProcess()
                    
                } failure: {
                    ReferenceValues.isLoginCheck = false
                    SupportingMethods.shared.turnCoverView(.off)
                    
                }

            }
            
        } else {
            let vc = PermissionViewController()
            
            self.present(vc, animated: true)
            
        }
        
    }
    
    func proceedLoginProcess() {
        self.sendFCMTokenRequest {
            // 홈 화면 present
            print("홈 화면 Present")
            let vc = CustomizedTabBarController()
            
            self.present(vc, animated: false) {
                ReferenceValues.isLoginCheck = true
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
        
    }
    
    // MARK: API
    func loginRequest(id: String, pwd: String, success: ((LoginDetail) -> ())?) {
        self.loginModel.loginRequest(id: id, pwd: pwd) { info in
            success?(info)
            
        } loginFailure: { reason in
            print("reason: \(reason)")
            self.idAlertLabel.isHidden = false
            if reason == 1 {
                print("아이디 또는 비밀번호가 일치하지 않습니다.")
                self.idAlertLabel.text = "아이디 또는 비밀번호가 일치하지 않습니다."
                
            } else if reason == 2 {
                print("탈퇴 혹은 탈퇴처리된 회원입니다.")
                self.idAlertLabel.text = "탈퇴 혹은 탈퇴처리된 회원입니다."
                
            } else {
                self.idAlertLabel.text = "관리자에게 문의 바랍니다."
                
            }
            SupportingMethods.shared.turnCoverView(.off)
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("loginRequest API error: \(errorMessage)")
            
        }
        
    }
    
    func tokenRefreshRequest(success: (() -> ())?, failure: (() -> ())?) {
        self.loginModel.tokenRefreshRequest { _ in
            success?()
            
        } failure: { errorMessage in
            print("tokenRefreshRequest API Error: \(errorMessage)")
            failure?()
        }

    }
    
    func sendFCMTokenRequest(success: (() -> ())?) {
        self.loginModel.sendFCMTokenRequest { _ in
            success?()
            
        } failure: { errorMessage in
            SupportingMethods.shared.turnCoverView(.off)
            print("sendFCMTokenRequest API error: \(errorMessage)")
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension SplashViewController {
    @objc func timerCallback() {
        //timerNum이 0이면(60초 경과) 타이머 종료
        if(self.timerNum == 0) {
            self.timer?.invalidate()
            self.timer = nil
            
            //타이머 종료 후 처리...
            self.splashView.isHidden = true
            self.checkPermission()
            
        }
     
        //timerNum -1 감소시키기
        self.timerNum -= 1
    }
    
    @objc func secretButton(_ sender: UIButton) {
        if self.passwordTextField.isSecureTextEntry {
            self.secretButton.setImage(.useCustomImage("noSecretImage"), for: .normal)
            self.passwordTextField.isSecureTextEntry = false
            
        } else {
            self.secretButton.setImage(.useCustomImage("secretImage"), for: .normal)
            self.passwordTextField.isSecureTextEntry = true
            
        }
    }
    
    @objc func loginButton(_ sender: UIButton) {
        print("loginButton")
        SupportingMethods.shared.turnCoverView(.on)
        self.loginRequest(id: self.idTextField.text!, pwd: self.passwordTextField.text!) { info in
            // FCMToken 등록
            self.proceedLoginProcess()
            
        }
        
    }
    
    @objc func proceedLoginProcess(_ notification: Notification) {
        SupportingMethods.shared.turnCoverView(.on)
        self.proceedLoginProcess()
        
    }
    
}

extension SplashViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.idTextField {
            self.idTextField.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
            self.idTextField.addLeftImageView(imageName: "EditingIdIcon")
            
        } else {
            self.passwordTextField.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
            self.passwordTextField.addLeftImageView(imageName: "EditingPasswordIcon")
            self.secretButton.isEnabled = true
            
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == self.idTextField {
            if self.idTextField.text == "" {
                self.idTextField.layer.borderColor = UIColor.useRGB(red: 218, green: 218, blue: 218).cgColor
                self.idTextField.addLeftImageView(imageName: "IdIcon")
                
            } else {
                self.idTextField.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
                self.idTextField.addLeftImageView(imageName: "EditingIdIcon")
                
            }
            
            
        } else {
            if self.passwordTextField.text == "" {
                self.passwordTextField.addLeftImageView(imageName: "PasswordIcon")
                self.passwordTextField.layer.borderColor = UIColor.useRGB(red: 218, green: 218, blue: 218).cgColor
                self.secretButton.isEnabled = false
                
            } else {
                self.passwordTextField.layer.borderColor = UIColor.useRGB(red: 176, green: 0, blue: 32).cgColor
                self.passwordTextField.addLeftImageView(imageName: "EditingPasswordIcon")
                self.secretButton.isEnabled = true
                
            }
            
            
        }
        
        return true
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.idTextField.text != "" && self.passwordTextField.text != "" {
            self.loginButton.isEnabled = true
            
        } else {
            self.loginButton.isEnabled = false
            
        }
        
    }
    
}
