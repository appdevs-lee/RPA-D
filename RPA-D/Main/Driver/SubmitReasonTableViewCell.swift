//
//  SubmitReasonTableViewCell.swift
//  RPA-D
//
//  Created by 이주성 on 12/8/24.
//

import UIKit

final class SubmitReasonTableViewCell: UITableViewCell {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사진 첨부"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var uploadPhotoBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var uploadPhotoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.uploadPhotoPlusImageView, self.uploadPhotoLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var uploadPhotoPlusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("uploadPhotoPlus")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var uploadPhotoLabel: UILabel = {
        let label = UILabel()
        label.text = "사진 올리기"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var uploadPhotoButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(uploadPhotoButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "추가 내용 작성"
        textView.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        textView.layer.cornerRadius = 8
        textView.textColor = .useRGB(red: 46, green: 45, blue: 45)
        textView.font = .useFont(ofSize: 12, weight: .Regular)
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    var baseViewHeightAnchorConstraint: NSLayoutConstraint!
    
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
extension SubmitReasonTableViewCell {
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
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.uploadPhotoBaseView,
            self.textView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.uploadPhotoStackView,
            self.selectedImageView,
            self.uploadPhotoButton,
        ], to: self.uploadPhotoBaseView)
    }
    
    // Set layouts
    func setLayouts() {
        //let safeArea = self.safeAreaLayoutGuide
        
        // baseView
        self.baseViewHeightAnchorConstraint = self.baseView.heightAnchor.constraint(equalToConstant: 300)
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseViewHeightAnchorConstraint,
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 20),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // uploadPhotoBaseView
        NSLayoutConstraint.activate([
            self.uploadPhotoBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.uploadPhotoBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.uploadPhotoBaseView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12),
            self.uploadPhotoBaseView.heightAnchor.constraint(equalToConstant: 168),
        ])
        
        // uploadPhotoStackView
        NSLayoutConstraint.activate([
            self.uploadPhotoStackView.centerYAnchor.constraint(equalTo: self.uploadPhotoBaseView.centerYAnchor),
            self.uploadPhotoStackView.leadingAnchor.constraint(equalTo: self.uploadPhotoBaseView.leadingAnchor, constant: 20),
            self.uploadPhotoStackView.trailingAnchor.constraint(equalTo: self.uploadPhotoBaseView.trailingAnchor, constant: -20),
        ])
        
        // uploadPhotoPlusImageView
        NSLayoutConstraint.activate([
            self.uploadPhotoPlusImageView.heightAnchor.constraint(equalToConstant: 24),
            self.uploadPhotoPlusImageView.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        // selectedImageView
        NSLayoutConstraint.activate([
            self.selectedImageView.leadingAnchor.constraint(equalTo: self.uploadPhotoBaseView.leadingAnchor, constant: 20),
            self.selectedImageView.trailingAnchor.constraint(equalTo: self.uploadPhotoBaseView.trailingAnchor, constant: -20),
            self.selectedImageView.topAnchor.constraint(equalTo: self.uploadPhotoBaseView.topAnchor, constant: 10),
            self.selectedImageView.bottomAnchor.constraint(equalTo: self.uploadPhotoBaseView.bottomAnchor, constant: -10),
        ])
        
        // uploadPhotoButton
        NSLayoutConstraint.activate([
            self.uploadPhotoButton.leadingAnchor.constraint(equalTo: self.uploadPhotoBaseView.leadingAnchor),
            self.uploadPhotoButton.trailingAnchor.constraint(equalTo: self.uploadPhotoBaseView.trailingAnchor),
            self.uploadPhotoButton.topAnchor.constraint(equalTo: self.uploadPhotoBaseView.topAnchor),
            self.uploadPhotoButton.bottomAnchor.constraint(equalTo: self.uploadPhotoBaseView.bottomAnchor),
        ])
        
        // textView
        NSLayoutConstraint.activate([
            self.textView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.textView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.textView.topAnchor.constraint(equalTo: self.uploadPhotoBaseView.bottomAnchor, constant: 12),
            self.textView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -20),
            self.textView.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

// MARK: - Extension for methods added
extension SubmitReasonTableViewCell {
    func setCell(image: UIImage?) {
        if let image = image {
            self.selectedImageView.isHidden = false
            self.selectedImageView.image = image
            
        } else {
            self.selectedImageView.isHidden = true
            
        }
        
    }
}

// MARK: - Extension for selector added
extension SubmitReasonTableViewCell {
    @objc func uploadPhotoButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("OpenAlbum"), object: nil)
    }
    
}

extension SubmitReasonTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: ReferenceValues.Size.Device.width - 40, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
                self.baseViewHeightAnchorConstraint.constant += (estimatedSize.height - textView.frame.size.height)
                NotificationCenter.default.post(name: Notification.Name("SubmitReloadData"), object: nil)
                
            }
            
        }
        
    }
    
}
