//
//  HourlyWorkView.swift
//  RPA-D
//
//  Created by Awesomepia on 11/25/24.
//

import UIKit

class HourlyWorkView: UIView {
    
    lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var stickView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 212, green: 212, blue: 212)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var activateContentBaseView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var activateContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var activateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
        self.setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HourlyWorkView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.circleView,
            self.timeLabel,
            self.stickView,
            self.contentBaseView,
            self.activateContentBaseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.contentLabel,
        ], to: self.contentBaseView)

        SupportingMethods.shared.addSubviews([
            self.activateContentLabel,
            self.activateImageView,
        ], to: self.activateContentBaseView)
    }
    
    func setLayouts() {
        // circleView
        NSLayoutConstraint.activate([
            self.circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.circleView.centerYAnchor.constraint(equalTo: self.timeLabel.centerYAnchor),
            self.circleView.widthAnchor.constraint(equalToConstant: 8),
            self.circleView.heightAnchor.constraint(equalToConstant: 8),
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.leadingAnchor.constraint(equalTo: self.circleView.trailingAnchor, constant: 8),
            self.timeLabel.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        
        // stickView
        NSLayoutConstraint.activate([
            self.stickView.topAnchor.constraint(equalTo: self.circleView.bottomAnchor, constant: 8),
            self.stickView.centerXAnchor.constraint(equalTo: self.circleView.centerXAnchor),
            self.stickView.heightAnchor.constraint(equalToConstant: 46),
            self.stickView.widthAnchor.constraint(equalToConstant: 1),
        ])
        
        // contentBaseView
        NSLayoutConstraint.activate([
            self.contentBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.contentBaseView.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 2),
            self.contentBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentBaseView.heightAnchor.constraint(equalToConstant: 46),
        ])
        
        // contentLabel
        NSLayoutConstraint.activate([
            self.contentLabel.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor, constant: 16),
            self.contentLabel.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor, constant: 16),
            self.contentLabel.centerYAnchor.constraint(equalTo: self.contentBaseView.centerYAnchor),
        ])
        
        // activateContentBaseView
        NSLayoutConstraint.activate([
            self.activateContentBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.activateContentBaseView.topAnchor.constraint(equalTo: self.circleView.bottomAnchor, constant: 8),
            self.activateContentBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.activateContentBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.activateContentBaseView.heightAnchor.constraint(equalToConstant: 72),
        ])
        
        // activateContentLabel
        NSLayoutConstraint.activate([
            self.activateContentLabel.leadingAnchor.constraint(equalTo: self.activateContentBaseView.leadingAnchor, constant: 16),
            self.activateContentLabel.topAnchor.constraint(equalTo: self.activateContentBaseView.topAnchor, constant: 10),
            self.activateContentLabel.bottomAnchor.constraint(equalTo: self.activateContentBaseView.bottomAnchor, constant: -10),
        ])
        
        // activateImageView
        NSLayoutConstraint.activate([
            self.activateImageView.leadingAnchor.constraint(equalTo: self.activateContentLabel.trailingAnchor, constant: 5),
            self.activateImageView.trailingAnchor.constraint(equalTo: self.activateContentBaseView.trailingAnchor, constant: -16),
            self.activateImageView.centerYAnchor.constraint(equalTo: self.activateContentBaseView.centerYAnchor),
            self.activateImageView.widthAnchor.constraint(equalToConstant: 40),
            self.activateImageView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setData() {
        // 텍스트 및 이미지 설정
        
        self.timeLabel.text = ""
        self.contentLabel.text = "" // 운행 준비, 탑승 및 운행을 시작해주세요, 첫 정류장에 도착해주세요, 다음 정류장으로 출발해주세요, 운행을 완료해주세요
        
        self.activateContentLabel.text = "" // 제 시간 안에\n운행을 준비해 주세요. 제 시간 안에\n탑승 및 운행을 시작해 주세요. 제 시간 안에 다음 정류장으로 출발해 주세요. 제 시간 안에 운행을 완료해 주세요.
        self.activateImageView.image = .useCustomImage("")
        
        // FIXME: Status에 따라서 활성화 및 비활성화 및 디자인
        if true {
            self.activate(targetString: "", color: .useRGB(red: 223, green: 52, blue: 52))
            
        } else {
            self.deactivate()
            
        }
        
    }
    
}

// MARK: - Extension for methods added
extension HourlyWorkView {
    func on() {
        
    }
    
    func off() {
        self.deactivate()
        
    }
    
    func activate(targetString: String = "", color: UIColor) {
        self.activateContentBaseView.isHidden = false
        
        self.activateContentLabel.asColor(targetString: targetString, color: color)
    }
    
    func deactivate() {
        self.activateContentBaseView.isHidden = true
        
    }
    
}

// MARK: - Extension for selector added
extension HourlyWorkView {
    
}
