//
//  CategoryButton.swift
//  InjeFestival
//
//  Created by Awesomepia on 8/23/24.
//

import UIKit

final class CategoryButton: UIControl {
    
    lazy var imageBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.textColor = .useRGB(red: 97, green: 97, blue: 97)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    init(imageName: String, title: String) {
        super.init(frame: .zero)
        
        self.imageView.image = UIImage(named: imageName)
        self.titleLabel.text = title
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 88),
            self.widthAnchor.constraint(equalToConstant: 88)
        ])
        
        self.addSubview(self.imageBaseView)
        self.imageBaseView.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        
        NSLayoutConstraint.activate([
            self.imageBaseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageBaseView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            self.imageBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.imageView.centerYAnchor.constraint(equalTo: self.imageBaseView.centerYAnchor),
            self.imageView.centerXAnchor.constraint(equalTo: self.imageBaseView.centerXAnchor),
            
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        self.sendActions(for: .touchUpInside)
    }
}
