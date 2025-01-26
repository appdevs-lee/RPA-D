//
//  DispatchOffTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/9/24.
//

import UIKit

final class DispatchOffTableViewCell: UITableViewCell {
    
    lazy var leftTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var leftFigureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("note.arrow")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var rightTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 101, green: 100, blue: 100)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var rightFigureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
extension DispatchOffTableViewCell {
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
            self.leftTitleLabel,
            self.leftFigureLabel,
            self.arrowImageView,
            self.rightTitleLabel,
            self.rightFigureLabel,
        ], to: self)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // leftTitleLabel
        NSLayoutConstraint.activate([
            self.leftTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.leftTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
        
        // leftFigureLabel
        NSLayoutConstraint.activate([
            self.leftFigureLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.leftFigureLabel.topAnchor.constraint(equalTo: self.leftTitleLabel.bottomAnchor, constant: 4),
            self.leftFigureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // arrowImageView
        NSLayoutConstraint.activate([
            self.arrowImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.arrowImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: 10),
        ])
        
        // rightTitleLabel
        NSLayoutConstraint.activate([
            self.rightTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.rightTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        ])
        
        // rightFigureLabel
        NSLayoutConstraint.activate([
            self.rightFigureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.rightFigureLabel.topAnchor.constraint(equalTo: self.rightTitleLabel.bottomAnchor, constant: 4),
            self.rightFigureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
}

// MARK: - Extension for methods added
extension DispatchOffTableViewCell {
    func setCell(note: (leftTitle: String, leftFigure: String, rightTitle: String, rightFigure: String)) {
        self.leftTitleLabel.text = note.leftTitle
        self.leftFigureLabel.text = note.leftFigure
        
        self.rightTitleLabel.text = note.rightTitle
        self.rightFigureLabel.text = note.rightFigure
        
    }
    
}
