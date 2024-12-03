//
//  BottomSheetView.swift
//  RPA-D
//
//  Created by 이주성 on 11/30/24.
//

import UIKit

class BottomSheetView: UIView {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var baseHeight: CGFloat
    var parentView: UIView
    
    init(baseHeight: CGFloat, view: UIView) {
        self.baseHeight = baseHeight
        self.parentView = view
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setGestures()
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BottomSheetView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.baseView
        ], to: self)
    }
    
    func setGestures() {
        let bottomSheetPanGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(_:)))
        self.addGestureRecognizer(bottomSheetPanGesture)
    }
    
    func setLayouts() {
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseView.heightAnchor.constraint(equalToConstant: self.baseHeight)
        ])
    }
}

// MARK: - Extension for methods added
extension BottomSheetView {
    
}

// MARK: - Extension for selector added
extension BottomSheetView {
    @objc func panGestureHandler(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let height: CGFloat = 600
        let velocity = gesture.velocity(in: self.parentView)
        
        if gesture.state == .ended {
            if velocity.y > 0 {
                print("velocity positive")
                
            } else {
                print("velocity negative")
                
            }
        } else {
            print(height + translation.y)
            gesture.setTranslation(.zero, in: self.parentView)
            
        }
        
    }
    
}

extension BottomSheetView: UIGestureRecognizerDelegate {
    
}
