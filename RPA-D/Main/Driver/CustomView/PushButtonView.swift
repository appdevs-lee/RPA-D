//
//  PushButtonView.swift
//  RPA-D
//
//  Created by Awesomepia on 12/4/24.
//

import UIKit

class PushButtonView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        view.layer.cornerRadius = 37
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
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
    
    var backgroundViewWidthAnchorConstraint: NSLayoutConstraint!
    var arriveButtonLeadingConstraint: NSLayoutConstraint!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setGestures()
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PushButtonView {
    func setGestures() {
        let arriveButtonPanGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(_:)))
        self.arriveButton.addGestureRecognizer(arriveButtonPanGesture)
        self.arriveButton.isUserInteractionEnabled = true
    }
    
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.backgroundView,
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
        
        // backgroundView
        self.backgroundViewWidthAnchorConstraint = self.backgroundView.widthAnchor.constraint(equalToConstant: 86)
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundView.heightAnchor.constraint(equalToConstant: 74),
            self.backgroundViewWidthAnchorConstraint,
        ])
        
        // guideLabel
        NSLayoutConstraint.activate([
            self.guideLabel.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.guideLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
        ])
        
        // arriveButton
        self.arriveButtonLeadingConstraint = self.arriveButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 12)
        NSLayoutConstraint.activate([
            self.arriveButtonLeadingConstraint,
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
    @objc func panGestureHandler(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.arriveButton)
        let width: CGFloat = self.baseView.frame.size.width
        
        if gesture.state == .ended {
            if self.arriveButtonLeadingConstraint.constant > ((ReferenceValues.Size.Device.width - 40) / 2) {
                print("정류장 도착 함수 실행")
                NotificationCenter.default.post(name: Notification.Name("StationCheck"), object: nil)
                
            }
            
            self.arriveButtonLeadingConstraint.constant = 12
            self.backgroundViewWidthAnchorConstraint.constant = 86
            self.backgroundView.alpha = 0.0
            
        } else {
            print(width)
            if self.arriveButtonLeadingConstraint.constant < (width - 84) && self.arriveButtonLeadingConstraint.constant >= 12 {
                self.backgroundView.alpha = 1.0
                
                self.arriveButtonLeadingConstraint.constant += translation.x
                self.backgroundViewWidthAnchorConstraint.constant += translation.x
                print(self.arriveButtonLeadingConstraint.constant)
                UIView.animate(withDuration: 0) {
                    self.baseView.layoutIfNeeded()
                    
                }
                gesture.setTranslation(.zero, in: self.baseView)
                
            }
            
        }
    }
}
