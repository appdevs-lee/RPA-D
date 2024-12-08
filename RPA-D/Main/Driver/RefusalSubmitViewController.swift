//
//  RefusalSubmitViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/8/24.
//

import UIKit
import PhotosUI

final class RefusalSubmitViewController: UIViewController {
    
    lazy var submitDoneView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var submitDoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.submitDoneImageView, self.submitDoneTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var submitDoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("reason.submit.done")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var submitDoneTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사유서 제출이 완료되었습니다"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var submitDoneButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 15, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(submitDoneButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.keyboardDismissMode = .onDrag
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var submitTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "관련 서류를 제출해 주세요"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    lazy var submitSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "건강 이상과 관련된 의사 소견서를 회사에 제출해 주세요."
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 16, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var uploadContentBaseView: UIView = {
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
        button.addTarget(self, action: #selector(openAlbum(_:)), for: .touchUpInside)
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
    
    lazy var textViewBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var textViewPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "사유를 작성해주세요"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 12, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .useRGB(red: 46, green: 45, blue: 45)
        textView.font = .useFont(ofSize: 12, weight: .Regular)
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.delegate = self
        textView.contentInsetAdjustmentBehavior = .never
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var textViewButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(textViewButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var precautionsBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var precautionsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "사유서 제출 유의사항에 동의합니다"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var precautionsCheckImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("precautions.noCheck")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var precautionsContentLabel: UILabel = {
        let label = UILabel()
        label.text = "병가 제출 시 병가 진단서와 함께 휴가계를 별도로 제출해 주시기 바랍니다.\n지속적인 배차 거부시에는 해당 일수만큼 불이익이 있을 수 있습니다."
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 11, weight: .Regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var precautionsButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(precautionsButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("제출", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.addTarget(self, action: #selector(submitButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var item: DispatchDailyItem
    let dispatchModel = DispatchModel()
    var savedImage: UIImage?
    var precautionsAgreementStatus: Bool = false
    var uploadContentBaseViewHeightAnchorConstraint: NSLayoutConstraint!
    var textViewBaseViewHeightAnchorConstraint: NSLayoutConstraint!
    
    init(item: DispatchDailyItem) {
        self.item = item
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewFoundation()
        self.initializeObjects()
        self.setDelegates()
        self.setGestures()
        self.setNotificationCenters()
        self.setSubviews()
        self.setLayouts()
        self.setUpNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    deinit {
        print("----------------------------------- RefusalSubmitViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RefusalSubmitViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let baseViewTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBaseView(_:)))
        self.baseView.addGestureRecognizer(baseViewTapGesture)
        self.baseView.isUserInteractionEnabled = true
        
    }
    
    func setNotificationCenters() {
//        NotificationCenter.default.addObserver(self, selector: #selector(openAlbum(_:)), name: Notification.Name("OpenAlbum"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: Notification.Name("SubmitReloadData"), object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.scrollView,
//            self.baseView,
            self.submitButton,
            self.submitDoneView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.submitTitleLabel,
            self.submitSubTitleLabel,
            self.uploadContentBaseView,
            self.precautionsBaseView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.titleLabel,
            self.uploadPhotoBaseView,
            self.textViewBaseView,
        ], to: self.uploadContentBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.textViewPlaceholderLabel,
            self.textView,
            self.textViewButton,
        ], to: self.textViewBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.uploadPhotoStackView,
            self.selectedImageView,
            self.uploadPhotoButton,
        ], to: self.uploadPhotoBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.precautionsTitleLabel,
            self.precautionsCheckImageView,
            self.precautionsContentLabel,
            self.precautionsButton,
        ], to: self.precautionsBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.submitDoneStackView,
            self.submitDoneButton,
        ], to: self.submitDoneView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor, constant: -12),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
        ])
        
        // submitTitleLabel
        NSLayoutConstraint.activate([
            self.submitTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.submitTitleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 48),
        ])
        
        // submitSubTitleLabel
        NSLayoutConstraint.activate([
            self.submitSubTitleLabel.leadingAnchor.constraint(equalTo: self.submitTitleLabel.leadingAnchor),
            self.submitSubTitleLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.submitSubTitleLabel.topAnchor.constraint(equalTo: self.submitTitleLabel.bottomAnchor, constant: 4),
        ])
        
        // uploadContentBaseView
        self.uploadContentBaseViewHeightAnchorConstraint = self.uploadContentBaseView.heightAnchor.constraint(equalToConstant: 300)
        NSLayoutConstraint.activate([
            self.uploadContentBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.uploadContentBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.uploadContentBaseView.topAnchor.constraint(equalTo: self.submitSubTitleLabel.bottomAnchor, constant: 20),
            self.uploadContentBaseViewHeightAnchorConstraint,
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.uploadContentBaseView.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.uploadContentBaseView.topAnchor, constant: 20),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // uploadPhotoBaseView
        NSLayoutConstraint.activate([
            self.uploadPhotoBaseView.leadingAnchor.constraint(equalTo: self.uploadContentBaseView.leadingAnchor, constant: 20),
            self.uploadPhotoBaseView.trailingAnchor.constraint(equalTo: self.uploadContentBaseView.trailingAnchor, constant: -20),
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
        
        // textViewBaseView
        self.textViewBaseViewHeightAnchorConstraint = self.textViewBaseView.heightAnchor.constraint(equalToConstant: 48)
        NSLayoutConstraint.activate([
            self.textViewBaseView.leadingAnchor.constraint(equalTo: self.uploadContentBaseView.leadingAnchor, constant: 20),
            self.textViewBaseView.trailingAnchor.constraint(equalTo: self.uploadContentBaseView.trailingAnchor, constant: -20),
            self.textViewBaseView.topAnchor.constraint(equalTo: self.uploadPhotoBaseView.bottomAnchor, constant: 12),
            self.textViewBaseView.bottomAnchor.constraint(equalTo: self.uploadContentBaseView.bottomAnchor, constant: -20),
            self.textViewBaseViewHeightAnchorConstraint,
        ])
        
        // textViewPlaceholderLabel
        NSLayoutConstraint.activate([
            self.textViewPlaceholderLabel.leadingAnchor.constraint(equalTo: self.textViewBaseView.leadingAnchor, constant: 16),
            self.textViewPlaceholderLabel.trailingAnchor.constraint(equalTo: self.textViewBaseView.trailingAnchor, constant: -16),
            self.textViewPlaceholderLabel.topAnchor.constraint(equalTo: self.textViewBaseView.topAnchor, constant: 16),
            self.textViewPlaceholderLabel.bottomAnchor.constraint(equalTo: self.textViewBaseView.bottomAnchor, constant: -16),
        ])
        
        // textView
        NSLayoutConstraint.activate([
            self.textView.leadingAnchor.constraint(equalTo: self.textViewBaseView.leadingAnchor, constant: 16),
            self.textView.trailingAnchor.constraint(equalTo: self.textViewBaseView.trailingAnchor, constant: -16),
            self.textView.topAnchor.constraint(equalTo: self.textViewBaseView.topAnchor, constant: 16),
            self.textView.bottomAnchor.constraint(equalTo: self.textViewBaseView.bottomAnchor, constant: -16),
            self.textView.heightAnchor.constraint(equalToConstant: 16),
        ])
        
        // textViewButton
        NSLayoutConstraint.activate([
            self.textViewButton.leadingAnchor.constraint(equalTo: self.textViewBaseView.leadingAnchor),
            self.textViewButton.trailingAnchor.constraint(equalTo: self.textViewBaseView.trailingAnchor),
            self.textViewButton.topAnchor.constraint(equalTo: self.textViewBaseView.topAnchor),
            self.textViewButton.bottomAnchor.constraint(equalTo: self.textViewBaseView.bottomAnchor),
        ])
        
        // precautionsBaseView
        NSLayoutConstraint.activate([
            self.precautionsBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.precautionsBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.precautionsBaseView.topAnchor.constraint(equalTo: self.uploadContentBaseView.bottomAnchor, constant: 20),
            self.precautionsBaseView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -20),
        ])
        
        // precautionsTitleLabel
        NSLayoutConstraint.activate([
            self.precautionsTitleLabel.leadingAnchor.constraint(equalTo: self.precautionsBaseView.leadingAnchor, constant: 20),
            self.precautionsTitleLabel.topAnchor.constraint(equalTo: self.precautionsBaseView.topAnchor, constant: 20),
        ])
        
        // precautionsCheckImageView
        NSLayoutConstraint.activate([
            self.precautionsCheckImageView.trailingAnchor.constraint(equalTo: self.precautionsBaseView.trailingAnchor, constant: -20),
            self.precautionsCheckImageView.centerYAnchor.constraint(equalTo: self.precautionsTitleLabel.centerYAnchor),
            self.precautionsCheckImageView.widthAnchor.constraint(equalToConstant: 24),
            self.precautionsCheckImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        // precautionsContentLabel
        NSLayoutConstraint.activate([
            self.precautionsContentLabel.leadingAnchor.constraint(equalTo: self.precautionsBaseView.leadingAnchor, constant: 20),
            self.precautionsContentLabel.trailingAnchor.constraint(equalTo: self.precautionsBaseView.trailingAnchor, constant: -20),
            self.precautionsContentLabel.topAnchor.constraint(equalTo: self.precautionsTitleLabel.bottomAnchor, constant: 12),
            self.precautionsContentLabel.bottomAnchor.constraint(equalTo: self.precautionsBaseView.bottomAnchor, constant: -20),
        ])
        
        // precautionsButton
        NSLayoutConstraint.activate([
            self.precautionsButton.leadingAnchor.constraint(equalTo: self.precautionsBaseView.leadingAnchor),
            self.precautionsButton.trailingAnchor.constraint(equalTo: self.precautionsBaseView.trailingAnchor),
            self.precautionsButton.topAnchor.constraint(equalTo: self.precautionsBaseView.topAnchor),
            self.precautionsButton.bottomAnchor.constraint(equalTo: self.precautionsBaseView.bottomAnchor),
        ])
        
        // submitButton
        NSLayoutConstraint.activate([
            self.submitButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.submitButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.submitButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -22),
            self.submitButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        // submitDoneView
        NSLayoutConstraint.activate([
            self.submitDoneView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.submitDoneView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.submitDoneView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.submitDoneView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // submitDoneStackView
        NSLayoutConstraint.activate([
            self.submitDoneStackView.leadingAnchor.constraint(equalTo: self.submitDoneView.leadingAnchor, constant: 20),
            self.submitDoneStackView.trailingAnchor.constraint(equalTo: self.submitDoneView.trailingAnchor, constant: -20),
            self.submitDoneStackView.centerYAnchor.constraint(equalTo: self.submitDoneView.centerYAnchor, constant: -100),
        ])
        
        // submitDoneImageView
        NSLayoutConstraint.activate([
            self.submitDoneImageView.widthAnchor.constraint(equalToConstant: 52),
            self.submitDoneImageView.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        // submitDoneButton
        NSLayoutConstraint.activate([
            self.submitDoneButton.leadingAnchor.constraint(equalTo: self.submitDoneView.leadingAnchor, constant: 20),
            self.submitDoneButton.trailingAnchor.constraint(equalTo: self.submitDoneView.trailingAnchor, constant: -20),
            self.submitDoneButton.bottomAnchor.constraint(equalTo: self.submitDoneView.bottomAnchor, constant: -56),
            self.submitDoneButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 46, green: 45, blue: 45),
            .font:UIFont.useFont(ofSize: 16, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "사유서 작성"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
}


// MARK: - Extension for methods added
extension RefusalSubmitViewController {
    func loadAlbum() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 1
        config.selection = .default
        config.preferredAssetRepresentationMode = .current
        
        let vc = PHPickerViewController(configuration: config)
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        
        self.present(vc, animated: true)
    }
    
    func sendDispatchConnectCheckDataRequest(success: (() -> ())?) {
        self.dispatchModel.sendDispatchConnectCheckDataRequest(id: self.item.id, workType: self.item.workType, check: "0", refusal: self.textView.text, imageData: self.savedImage) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendDispatchConnectCheckDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        }

    }
    
}

// MARK: - Extension for selector methods
extension RefusalSubmitViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        if self.textView.text != "" || self.selectedImageView.image != nil {
            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "작성된 사유서 내용이 사라집니다.", messageContent: "작성한 사유서 내용이 사라지고, 다시 복구할 수 없습니다. 그래도 뒤로 가시겠습니까?", leftButtonTitle: "취소", leftAction: { }, rightButtonTitle: "확인", rightAction: {
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(vc, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
            
        }
        
        
    }
    
    @objc func submitButton(_ sender: UIButton) {
        self.sendDispatchConnectCheckDataRequest {
            UIView.transition(with: self.submitDoneView, duration: 0.5) {
                self.submitDoneView.alpha = 1.0
                
            }
            
        }
        
    }
    
    @objc func textViewButton(_ sender: UIButton) {
        self.textView.becomeFirstResponder()
        
    }
    
    @objc func tappedBaseView(_ gesture: UITapGestureRecognizer) {
        self.textView.resignFirstResponder()
        
    }
    
    @objc func precautionsButton(_ sender: UIButton) {
        if self.textView.text == "" {
            SupportingMethods.shared.showAlertNoti(title: "사유를 먼저 작성해 주세요!")
            
        } else {
            self.precautionsAgreementStatus.toggle()
            if self.precautionsAgreementStatus {
                self.precautionsCheckImageView.image = .useCustomImage("precautions.check")
                self.submitButton.isEnabled = true
                self.submitButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
                self.submitButton.setTitleColor(.white, for: .normal)
                
            } else {
                self.precautionsCheckImageView.image = .useCustomImage("precautions.noCheck")
                self.submitButton.isEnabled = false
                self.submitButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
                self.submitButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
                
            }
            
        }
        
    }
    
    @objc func submitDoneButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name("DispatchRefusalDone"), object: nil)
        
    }
    
    @objc func openAlbum(_ sender: UIButton) {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized:
            self.loadAlbum()
            
        case .limited:
            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 안내", messageContent: "사진 접근 권한이\n선택한 사진에만 허용되어 있습니다.\n설정에서 “모든 사진”으로 변경할 수 있습니다.", leftButtonTitle: "선택 유지", leftAction: {
                self.loadAlbum()
                
            }, rightButtonTitle: "설정", rightAction: {
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }))
            
            self.present(vc, animated: true)
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized:
                    self.loadAlbum()
                    
                case .limited:
                    let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 안내", messageContent: "사진 접근 권한이\n선택한 사진에만 허용되어 있습니다.\n설정에서 “모든 사진”으로 변경할 수 있습니다.", leftButtonTitle: "선택 유지", leftAction: {
                        self.loadAlbum()
                        
                    }, rightButtonTitle: "설정", rightAction: {
                        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }))
                    
                    self.present(vc, animated: true)
                    
                default:
                    let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 필요", messageContent: "사진/동영상 업로드를 위해\n설정에서 ‘사진 접근 권한’을 허용해야 합니다.", leftButtonTitle: "취소", leftAction: nil, rightButtonTitle: "설정", rightAction: {
                        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }))
                    
                    self.present(vc, animated: true)
                }
            }
            
        default:
            let vc = AlertPopViewController(.normalTwoButton(messageTitle: "권한 설정 필요", messageContent: "사진/동영상 업로드를 위해\n설정에서 ‘사진 접근 권한’을 허용해야 합니다.", leftButtonTitle: "취소", leftAction: nil, rightButtonTitle: "설정", rightAction: {
                if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }))
            
            self.present(vc, animated: true)
        }
        
    }
    
}

// MARK: Extension for PHPickerViewControllerDelegate
extension RefusalSubmitViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider // 2
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in // 4
                DispatchQueue.main.async {
                    self.savedImage = image as? UIImage
                    self.selectedImageView.image = image as? UIImage
                    print("성공")
                    
                }
                
            }
            
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
            print("error")
            
        }

    }
}

extension RefusalSubmitViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.textViewPlaceholderLabel.isHidden = true
        return true
        
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text == "" {
            self.textViewPlaceholderLabel.isHidden = false
            
        } else {
            self.textViewPlaceholderLabel.isHidden = true
            
        }
        
        return true
    }

    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            self.textViewPlaceholderLabel.isHidden = false
            self.submitButton.isEnabled = false
            self.submitButton.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
            self.submitButton.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
            self.precautionsCheckImageView.image = .useCustomImage("precautions.noCheck")
            self.precautionsAgreementStatus = false
            
        } else {
            self.textViewPlaceholderLabel.isHidden = true
            
        }
        
        let size = CGSize(width: ReferenceValues.Size.Device.width - 40, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        if estimatedSize.height < 192 {
            textView.constraints.forEach { (constraint) in
                if constraint.firstAttribute == .height {
                    constraint.constant = estimatedSize.height
                    self.textViewBaseViewHeightAnchorConstraint.constant += (estimatedSize.height - textView.frame.size.height)
                    self.uploadContentBaseViewHeightAnchorConstraint.constant += (estimatedSize.height - textView.frame.size.height)
                    
                }
                
            }
            
        }
        
    }
    
}
