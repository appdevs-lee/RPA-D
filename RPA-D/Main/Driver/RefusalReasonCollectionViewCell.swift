//
//  RefusalReasonCollectionViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/8/24.
//

import UIKit

final class RefusalReasonCollectionViewCell: UICollectionViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.useRGB(red: 223, green: 52, blue: 52).cgColor
        view.layer.borderWidth = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("noSelectedReason")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var reasonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var reasonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extension for essential methods
extension RefusalReasonCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .clear
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.selectImageView,
            self.reasonImageView,
            self.reasonLabel,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // selectImageView
        NSLayoutConstraint.activate([
            self.selectImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 12),
            self.selectImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 12),
            self.selectImageView.heightAnchor.constraint(equalToConstant: 12),
            self.selectImageView.widthAnchor.constraint(equalToConstant: 12),
        ])
        
        // reasonImageView
        NSLayoutConstraint.activate([
            self.reasonImageView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.reasonImageView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor),
            self.reasonImageView.widthAnchor.constraint(equalToConstant: 68),
            self.reasonImageView.heightAnchor.constraint(equalToConstant: 68),
        ])
        
        // reasonLabel
        NSLayoutConstraint.activate([
            self.reasonLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.reasonLabel.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -16),
        ])
    }
}

// MARK: - Extension for methods added
extension RefusalReasonCollectionViewCell {
    func setCell(reason: (title: String, imageName: String)) {
        self.reasonLabel.text = reason.title
        self.reasonImageView.image = .useCustomImage(reason.imageName)
    }
}
