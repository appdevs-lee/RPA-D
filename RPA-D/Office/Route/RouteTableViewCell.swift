//
//  RouteTableViewCell.swift
//  RPA-D
//
//  Created by Awesomepia on 12/11/24.
//

import UIKit

protocol RouteBookmarkDelegate: NSObjectProtocol {
    func bookmarkRoute(id: Int)
    
}

final class RouteTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 16, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("bookmark.no"), for: .normal)
        button.addTarget(self, action: #selector(bookmarkButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var departureTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
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
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 249, green: 249, blue: 249)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var knowStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("route.dont.know")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var knowStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "미숙지 노선"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var knowStatusButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.titleLabel?.font = .useFont(ofSize: 12, weight: .Regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var delegate: RouteBookmarkDelegate?
    
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
extension RouteTableViewCell {
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
            self.titleLabel,
            self.bookmarkButton,
            
            self.departureTitleButton,
            self.departureLabel,
            self.departureTimeLabel,
            
            self.arrivalTitleButton,
            self.arrivalLabel,
            self.arrivalTimeLabel,
            
            self.separateView,
            self.knowStatusImageView,
            self.knowStatusLabel,
            self.knowStatusButton,
        ], to: self.baseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.titleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 16),
        ])
        
        // bookmarkButton
        NSLayoutConstraint.activate([
            self.bookmarkButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.bookmarkButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.bookmarkButton.heightAnchor.constraint(equalToConstant: 18),
            self.bookmarkButton.widthAnchor.constraint(equalToConstant: 18),
        ])
        
        // departureTitleButton
        NSLayoutConstraint.activate([
            self.departureTitleButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.departureTitleButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
            self.departureTitleButton.widthAnchor.constraint(equalToConstant: 37),
            self.departureTitleButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        // departureLabel
        NSLayoutConstraint.activate([
            self.departureLabel.leadingAnchor.constraint(equalTo: self.departureTitleButton.trailingAnchor, constant: 4),
            self.departureLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.departureLabel.centerYAnchor.constraint(equalTo: self.departureTitleButton.centerYAnchor),
        ])
        
        // departureTimeLabel
        NSLayoutConstraint.activate([
            self.departureTimeLabel.leadingAnchor.constraint(equalTo: self.departureLabel.leadingAnchor),
            self.departureTimeLabel.topAnchor.constraint(equalTo: self.departureLabel.bottomAnchor, constant: 5),
        ])
        
        // arrivalTitleButton
        NSLayoutConstraint.activate([
            self.arrivalTitleButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.arrivalTitleButton.topAnchor.constraint(equalTo: self.departureTimeLabel.bottomAnchor, constant: 8),
            self.arrivalTitleButton.widthAnchor.constraint(equalToConstant: 37),
            self.arrivalTitleButton.heightAnchor.constraint(equalToConstant: 22),
        ])
        
        // arrivalLabel
        NSLayoutConstraint.activate([
            self.arrivalLabel.leadingAnchor.constraint(equalTo: self.arrivalTitleButton.trailingAnchor, constant: 4),
            self.arrivalLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.arrivalLabel.centerYAnchor.constraint(equalTo: self.arrivalTitleButton.centerYAnchor),
        ])
        
        // arrivalTimeLabel
        NSLayoutConstraint.activate([
            self.arrivalTimeLabel.leadingAnchor.constraint(equalTo: self.arrivalLabel.leadingAnchor),
            self.arrivalTimeLabel.topAnchor.constraint(equalTo: self.arrivalLabel.bottomAnchor, constant: 5),
        ])
        
        // separateView
        NSLayoutConstraint.activate([
            self.separateView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.separateView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.separateView.topAnchor.constraint(equalTo: self.arrivalTimeLabel.bottomAnchor, constant: 8),
        ])
        
        // knowStatusImageView
        NSLayoutConstraint.activate([
            self.knowStatusImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 16),
            self.knowStatusImageView.topAnchor.constraint(equalTo: self.separateView.bottomAnchor, constant: 11),
            self.knowStatusImageView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -11),
            self.knowStatusImageView.widthAnchor.constraint(equalToConstant: 16),
            self.knowStatusImageView.heightAnchor.constraint(equalToConstant: 16),
        ])
        
        // knowStatusLabel
        NSLayoutConstraint.activate([
            self.knowStatusLabel.leadingAnchor.constraint(equalTo: self.knowStatusImageView.trailingAnchor, constant: 4),
            self.knowStatusLabel.centerYAnchor.constraint(equalTo: self.knowStatusImageView.centerYAnchor),
        ])
        
        // knowStatusButton
        NSLayoutConstraint.activate([
            self.knowStatusButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -16),
            self.knowStatusButton.centerYAnchor.constraint(equalTo: self.knowStatusImageView.centerYAnchor),
        ])
    }
}

// MARK: - Extension for methods added
extension RouteTableViewCell {
    func setCell(route: RouteDetailItem) {
        self.titleLabel.text = "\(route.route)"
        self.bookmarkButton.setImage(route.favorite == "true" ? .useCustomImage("bookmark.yes") : .useCustomImage("bookmark.no") , for: .normal)
        
        self.departureLabel.text = "\(route.departure)"
        self.departureTimeLabel.text = "\(route.departureTime)"
        
        self.arrivalLabel.text = "\(route.arrival)"
        self.arrivalTimeLabel.text = "\(route.arrivalTime)"
        
        self.knowStatusImageView.image = route.know == "true" ? .useCustomImage("route.know") : .useCustomImage("route.dont.know")
        self.knowStatusLabel.text = route.know == "true" ? "숙지 완료된 노선" : "미숙지 노선"
        self.knowStatusLabel.textColor = route.know == "true" ? UIColor.useRGB(red: 223, green: 52, blue: 52) : UIColor.useRGB(red: 46, green: 45, blue: 45)
        self.knowStatusButton.setTitle(route.know == "true" ? "노선 상세 보기" : "노선 숙지하기", for: .normal)
        
        self.bookmarkButton.tag = route.id
    }
    
}

// MARK: - Extension for selector added
extension RouteTableViewCell {
    @objc func bookmarkButton(_ sender: UIButton) {
        self.delegate?.bookmarkRoute(id: sender.tag)
        
    }
    
}

