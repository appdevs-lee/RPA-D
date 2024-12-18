//
//  ProblemRouteTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/17/24.
//

import UIKit

final class ProblemRouteTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 78, green: 78, blue: 78)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var etcLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 78, green: 78, blue: 78)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTitleButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("출발", for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 117, blue: 42), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 11, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 242, blue: 235)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var departureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTitleButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("도착", for: .normal)
        button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 11, weight: .Medium)
        button.backgroundColor = .useRGB(red: 255, green: 242, blue: 242)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var arrivalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 249, green: 249, blue: 249)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var showDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "상세보기"
        label.textColor = .useRGB(red: 109, green: 109, blue: 109)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.textAlignment = .center
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
extension ProblemRouteTableViewCell {
    // Set view foundation
    func setCellFoundation() {
        self.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
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
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.timeLabel,
            self.etcLabel,
            self.departureTitleButton,
            self.departureLabel,
            self.arrivalTitleButton,
            self.arrivalLabel,
            self.separateView,
            self.showDetailLabel,
        ], to: self.baseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
        
        // timeLabel
        NSLayoutConstraint.activate([
            self.timeLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.timeLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 20),
        ])
        
        // etcLabel
        NSLayoutConstraint.activate([
            self.etcLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.etcLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 20),
        ])
        
        // departureTitleButton
        NSLayoutConstraint.activate([
            self.departureTitleButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.departureTitleButton.centerYAnchor.constraint(equalTo: self.departureLabel.centerYAnchor),
            self.departureTitleButton.widthAnchor.constraint(equalToConstant: 37),
            self.departureTitleButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureTitleButton.trailingAnchor, constant: 4),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.departureLabel.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 20),
        ])
        
        // arrivalTitleButton
        NSLayoutConstraint.activate([
            self.arrivalTitleButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.arrivalTitleButton.centerYAnchor.constraint(equalTo: self.arrivalLabel.centerYAnchor),
            self.arrivalTitleButton.widthAnchor.constraint(equalToConstant: 37),
            self.arrivalTitleButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleButton.trailingAnchor, constant: 4),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.arrivalLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 12),
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.separateView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.separateView.topAnchor.constraint(equalTo: self.arrivalLabel.bottomAnchor, constant: 20),
            self.separateView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        // showDetailLabel
        NSLayoutConstraint.activate([
            self.showDetailLabel.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.showDetailLabel.topAnchor.constraint(equalTo: self.separateView.bottomAnchor, constant: 8),
            self.showDetailLabel.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -8),
            self.showDetailLabel.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
}

// MARK: - Extension for methods added
extension ProblemRouteTableViewCell {
    func setCell(problem: ProblemListItem) {
        self.timeLabel.text = "\(problem.departureDate.split(separator: " ")[1]) -> \(problem.arrivalDate.split(separator: " ")[1])"
        self.etcLabel.text = "\(problem.group) | \(problem.busNum)"
        
        self.departureLabel.text = problem.departure
        self.arrivalLabel.text = problem.arrival
        
    }
    
}
