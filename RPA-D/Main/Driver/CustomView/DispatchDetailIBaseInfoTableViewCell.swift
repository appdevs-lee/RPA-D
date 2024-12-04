//
//  DispatchDetailIBaseInfoTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/3/24.
//

import UIKit

final class DispatchDetailIBaseInfoTableViewCell: UITableViewCell {
    
    lazy var todayDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 223, green: 52, blue: 52)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var busNumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var moreInfoBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setCellFoundation()
        self.initializeViews()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

// MARK: Extension for essential methods
extension DispatchDetailIBaseInfoTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = true
    }
    
    // Initialize views
    func initializeViews() {
        
    }
    
    // Set gestures
    func setGestures() {
        
    }
    
    // Set notificationCenters
    func setNotificationCenters() {
        
    }
    
    // Set subviews
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.todayDateLabel,
            self.busNumLabel,
            self.moreInfoBaseView,
            self.separateView,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // todayDateLabel
        NSLayoutConstraint.activate([
            self.todayDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.todayDateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
        ])
        
        // busNumLabel
        NSLayoutConstraint.activate([
            self.busNumLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.busNumLabel.centerYAnchor.constraint(equalTo: self.todayDateLabel.centerYAnchor),
        ])
        
        // moreInfoBaseView
        NSLayoutConstraint.activate([
            self.moreInfoBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.moreInfoBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.moreInfoBaseView.topAnchor.constraint(equalTo: self.busNumLabel.bottomAnchor, constant: 12),
            self.moreInfoBaseView.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.separateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.separateView.topAnchor.constraint(equalTo: self.moreInfoBaseView.bottomAnchor, constant: 24),
            self.separateView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.separateView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchDetailIBaseInfoTableViewCell {
    func setCell(date: String, item: DispatchDetailItem) {
        let date = SupportingMethods.shared.convertString(intoCustomString: date, "MM월 dd일")
        self.todayDateLabel.text = date
        self.busNumLabel.text = "\(item.busNum)"
        
    }
}

