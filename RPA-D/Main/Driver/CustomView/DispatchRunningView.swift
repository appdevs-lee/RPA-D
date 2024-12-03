//
//  DispatchRunningView.swift
//  RPA-D
//
//  Created by Awesomepia on 12/3/24.
//

import UIKit

class DispatchRunningView: UIView {
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DispatchRunningView {
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
extension DispatchRunningView {
    
}

// MARK: - Extension for selector added
extension DispatchRunningView {
    
}
