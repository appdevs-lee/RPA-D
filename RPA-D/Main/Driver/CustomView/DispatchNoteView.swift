//
//  DispatchNoteView.swift
//  RPA-D
//
//  Created by 이주성 on 12/4/24.
//

import UIKit

class DispatchNoteView: UIView {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dashboardTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.borderStyle = .none
        textField.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        textField.layer.cornerRadius = 8
        textField.setPlaceholder(placeholder: "계기판 입력")
        textField.addLeftPadding()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DispatchNoteView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.dashboardTextField,
            self.sendButton,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseView.heightAnchor.constraint(equalToConstant: 323),
        ])
        
        // dashboardTextField
        NSLayoutConstraint.activate([
            self.dashboardTextField.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dashboardTextField.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.dashboardTextField.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 24),
            self.dashboardTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // sendButton
        NSLayoutConstraint.activate([
            self.sendButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.sendButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.sendButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.sendButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchNoteView {
    
}

// MARK: - Extension for selector added
extension DispatchNoteView {
    
}

// MARK: - Extension for UITextFieldDelegate
extension DispatchNoteView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == "" {
            self.sendButton.isEnabled = false
            self.sendButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.sendButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            
        } else {
            self.sendButton.isEnabled = true
            self.sendButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.sendButton.setTitleColor(.white, for: .normal)
            
        }
        
    }
    
}
