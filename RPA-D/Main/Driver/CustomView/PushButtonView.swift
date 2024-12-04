//
//  PushButtonView.swift
//  RPA-D
//
//  Created by Awesomepia on 12/4/24.
//

import UIKit

class PushButtonView: UIView {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 37
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = "밀어서 도착 알리기"
        label.textColor = .useRGB(red: 196, green: 195, blue: 195)
        label.font = .useFont(ofSize: 20, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arriveButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("arrive.deactivate"), for: .normal)
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

extension PushButtonView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.guideLabel,
            self.arriveButton,
        ], to: self.baseView)
        
    }
    
    func setLayouts() {
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseView.heightAnchor.constraint(equalToConstant: 74),
        ])
        
        // guideLabel
        NSLayoutConstraint.activate([
            self.guideLabel.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.guideLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
        ])
        
        // arriveButton
        NSLayoutConstraint.activate([
            self.arriveButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -13),
            self.arriveButton.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.arriveButton.heightAnchor.constraint(equalToConstant: 60),
            self.arriveButton.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
}

// MARK: - Extension for methods added
extension PushButtonView {
    
}

// MARK: - Extension for selector added
extension PushButtonView {
    
}
