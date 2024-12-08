//
//  DispatchPeopleCountView.swift
//  RPA-D
//
//  Created by 이주성 on 12/9/24.
//

import UIKit

class DispatchPeopleCountView: UIView {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승 인원"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승 인원을 입력해 주세요"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var peopleCountBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("minusImage"), for: .normal)
        button.addTarget(self, action: #selector(minusButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var peopleCountTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.borderStyle = .none
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.setPlaceholder(placeholder: "인원수 입력")
        textField.textAlignment = .center
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("plusImage"), for: .normal)
        button.addTarget(self, action: #selector(plusButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var previousButton: UIButton = {
        let button = UIButton()
        button.setTitle("이전", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 8
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

extension DispatchPeopleCountView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.subTitleLabel,
            self.peopleCountBaseView,
            self.previousButton,
            self.nextButton,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.minusButton,
            self.peopleCountTextField,
            self.plusButton,
        ], to: self.peopleCountBaseView)
    }
    
    func setLayouts() {
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 373 / 375),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 24),
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
        ])
        
        // peopleCountBaseView
        NSLayoutConstraint.activate([
            self.peopleCountBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.peopleCountBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.peopleCountBaseView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.peopleCountBaseView.heightAnchor.constraint(equalToConstant: 58),
        ])
        
        // minusButton
        NSLayoutConstraint.activate([
            self.minusButton.leadingAnchor.constraint(equalTo: self.peopleCountBaseView.leadingAnchor, constant: 16),
            self.minusButton.centerYAnchor.constraint(equalTo: self.peopleCountBaseView.centerYAnchor),
            self.minusButton.heightAnchor.constraint(equalToConstant: 26),
            self.minusButton.widthAnchor.constraint(equalToConstant: 26),
        ])
        
        // peopleCountTextField
        NSLayoutConstraint.activate([
            self.peopleCountTextField.centerXAnchor.constraint(equalTo: self.peopleCountBaseView.centerXAnchor),
            self.peopleCountTextField.topAnchor.constraint(equalTo: self.peopleCountBaseView.topAnchor, constant: 7.25),
            self.peopleCountTextField.bottomAnchor.constraint(equalTo: self.peopleCountBaseView.bottomAnchor, constant: -7.25),
            self.peopleCountTextField.heightAnchor.constraint(equalToConstant: 43.5),
            self.peopleCountTextField.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        // plusButton
        NSLayoutConstraint.activate([
            self.plusButton.trailingAnchor.constraint(equalTo: self.peopleCountBaseView.trailingAnchor, constant: -16),
            self.plusButton.centerYAnchor.constraint(equalTo: self.peopleCountBaseView.centerYAnchor),
            self.plusButton.heightAnchor.constraint(equalToConstant: 26),
            self.plusButton.widthAnchor.constraint(equalToConstant: 26),
        ])
        
        // previousButton
        NSLayoutConstraint.activate([
            self.previousButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.previousButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -26),
            self.previousButton.heightAnchor.constraint(equalToConstant: 48),
            self.previousButton.trailingAnchor.constraint(equalTo: self.nextButton.leadingAnchor, constant: -12),
        ])
        
        // nextButton
        NSLayoutConstraint.activate([
            self.nextButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.nextButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -26),
            self.nextButton.heightAnchor.constraint(equalToConstant: 48),
            self.nextButton.widthAnchor.constraint(equalTo: self.previousButton.widthAnchor, multiplier: 1.0),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchPeopleCountView {
    
}

// MARK: - Extension for selector added
extension DispatchPeopleCountView {
    @objc func minusButton(_ sender: UIButton) {
        if self.peopleCountTextField.text == "" {
            self.peopleCountTextField.text = "0"
            
        } else {
            if self.peopleCountTextField.text != "0" {
                self.peopleCountTextField.text = String(Int(self.peopleCountTextField.text!)! - 1)
                
            } else {
                self.peopleCountTextField.text = "0"
                
            }
            
        }
        
    }
    
    @objc func plusButton(_ sender: UIButton) {
        if self.peopleCountTextField.text == "" {
            self.peopleCountTextField.text = "1"
            
        } else {
            self.peopleCountTextField.text = String(Int(self.peopleCountTextField.text!)! + 1)
            
        }
        
    }
}

// MARK: - Extension for UITextFieldDelegate
extension DispatchPeopleCountView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        
    }
    
}
