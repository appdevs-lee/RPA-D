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
        textField.borderStyle = .none
        textField.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        textField.layer.cornerRadius = 8
        textField.setPlaceholder(placeholder: "계기판 입력")
        textField.addLeftPadding()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
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
            
        ], to: self)
    }
    
    func setLayouts() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchNoteView {
    
}

// MARK: - Extension for selector added
extension DispatchNoteView {
    
}
