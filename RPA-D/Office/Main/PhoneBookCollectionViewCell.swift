//
//  PhoneBookCollectionViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/10/24.
//

import UIKit

final class PhoneBookCollectionViewCell: UICollectionViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var callImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("callImage")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
extension PhoneBookCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.nameLabel,
            self.positionLabel,
            self.callImageView,
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
            self.baseView.widthAnchor.constraint(equalToConstant: 112),
            self.baseView.heightAnchor.constraint(equalToConstant: 117),
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 17),
            self.nameLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 16),
        ])
        
        // positionLabel
        NSLayoutConstraint.activate([
            self.positionLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 17),
            self.positionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
        ])
        
        // callImageView
        NSLayoutConstraint.activate([
            self.callImageView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -12),
            self.callImageView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -12),
            self.callImageView.widthAnchor.constraint(equalToConstant: 28),
            self.callImageView.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
}

// MARK: - Extension for methods added
extension PhoneBookCollectionViewCell {
    func setCell(phone: MemberDetailItem) {
        self.nameLabel.text = phone.name
        self.positionLabel.text = phone.role
        
    }
    
}

