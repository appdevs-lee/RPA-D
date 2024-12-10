//
//  OtherTasksCollectionViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/10/24.
//

import UIKit

final class OtherTasksCollectionViewCell: UICollectionViewCell {
    
    lazy var taskImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var taskLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Regular)
        label.textAlignment = .center
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
extension OtherTasksCollectionViewCell: EssentialCellHeaderMethods {
    func setViewFoundation() {
        self.backgroundColor = .white
    }
    
    func initializeObjects() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.taskImageView,
            self.taskLabel,
        ], to: self)
    }
    
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // taskImageView
        NSLayoutConstraint.activate([
            self.taskImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.taskImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.taskImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.taskImageView.widthAnchor.constraint(equalToConstant: 56),
            self.taskImageView.heightAnchor.constraint(equalToConstant: 56),
        ])
        
        // taskLabel
        NSLayoutConstraint.activate([
            self.taskLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.taskLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.taskLabel.topAnchor.constraint(equalTo: self.taskImageView.bottomAnchor, constant: 7),
            self.taskLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension OtherTasksCollectionViewCell {
    func setCell(task: OtherTasks) {
        self.taskImageView.image = .useCustomImage(task.imageName)
        self.taskLabel.text = task.title
        
    }
    
}

