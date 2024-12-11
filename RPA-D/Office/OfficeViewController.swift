//
//  OfficeViewController.swift
//  RPA-D
//
//  Created by 이주성 on 11/11/24.
//

import UIKit

struct OtherTasks {
    let title: String
    let imageName: String
}

final class OfficeViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.bounces = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: 공지사항 View
    lazy var noticeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 공지사항이 없습니다."
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var noticeArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("noticeArrowImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var noticeButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(noticeButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: 사무 메인 View
    lazy var mainOfficeByRoleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var mainOfficeByRoleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var mainOfficeByRoleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var mainOfficeByRoleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(mainOfficeByRoleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: 상단 서브 메인 View
    lazy var subMainOfficeOneByRoleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var subMainOfficeOneByRoleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var subMainOfficeOneByRoleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subMainOfficeOneByRoleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(subMainOfficeOneByRoleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: 하단 서브 메인 View
    lazy var subMainOfficeTwoByRoleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: 1.0, height: 1.0))
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var subMainOfficeTwoByRoleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var subMainOfficeTwoByRoleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subMainOfficeTwoByRoleButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(subMainOfficeTwoByRoleButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: 다른 업무 View
    lazy var otherTasksView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var otherTasksTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "다른 업무"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 56, height: 89)
        flowLayout.minimumLineSpacing = 24
        flowLayout.minimumInteritemSpacing = 24
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(OtherTasksCollectionViewCell.self, forCellWithReuseIdentifier: "OtherTasksCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: 주소 View
    lazy var phoneBookView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var phoneBookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 열람 주소록"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 18, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var phoneBookButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("moveToPhoneBookImage"), for: .normal)
        button.addTarget(self, action: #selector(phoneBookButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var phoneBookCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 112, height: 117)
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(PhoneBookCollectionViewCell.self, forCellWithReuseIdentifier: "PhoneBookCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var noDataPhoneBookStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.noDataPhoneBookLabel, self.moveToPhoneBookButton])
        stackView.isHidden = true
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var noDataPhoneBookLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 열람한 주소록이 없습니다."
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var moveToPhoneBookButton: UIButton = {
        let button = UIButton()
        button.setTitle("주소록 보기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 14, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(moveToPhoneBookButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var role: Role = .driver
    var tasksList: [OtherTasks] = [
        OtherTasks(title: "취업규칙", imageName: "rule"),
        OtherTasks(title: "교육", imageName: "edu"),
        OtherTasks(title: "견적", imageName: "estimate"),
        OtherTasks(title: "사고대처", imageName: "accident"),
    ]
    var phoneBookList: [MemberDetailItem] = []
    
    init() {
        switch User.shared.role {
        case "운전원":
            self.role = .driver
            
        case "팀장":
            self.role = .driverLeader
            
        default:
            break
        }
        
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
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewAfterTransition()
    }
    
    //    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    //        return .portrait
    //    }
    
    deinit {
        print("----------------------------------- OfficeViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension OfficeViewController: EssentialViewMethods {
    func setViewFoundation() {
        // Pop Slide
        if self.navigationController?.viewControllers.first === self  {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.scrollView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self.scrollView)
        
        SupportingMethods.shared.addSubviews([
            self.noticeView,
            self.mainOfficeByRoleView,
            self.subMainOfficeOneByRoleView,
            self.subMainOfficeTwoByRoleView,
            self.otherTasksView,
            self.phoneBookView,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.noticeTitleLabel,
            self.noticeArrowImageView,
            self.noticeButton,
        ], to: self.noticeView)
        
        SupportingMethods.shared.addSubviews([
            self.mainOfficeByRoleImageView,
            self.mainOfficeByRoleLabel,
            self.mainOfficeByRoleButton,
        ], to: self.mainOfficeByRoleView)
        
        SupportingMethods.shared.addSubviews([
            self.subMainOfficeOneByRoleImageView,
            self.subMainOfficeOneByRoleLabel,
            self.subMainOfficeOneByRoleButton,
        ], to: self.subMainOfficeOneByRoleView)
        
        SupportingMethods.shared.addSubviews([
            self.subMainOfficeTwoByRoleImageView,
            self.subMainOfficeTwoByRoleLabel,
            self.subMainOfficeTwoByRoleButton,
        ], to: self.subMainOfficeTwoByRoleView)
        
        SupportingMethods.shared.addSubviews([
            self.otherTasksTitleLabel,
            self.collectionView,
        ], to: self.otherTasksView)
        
        SupportingMethods.shared.addSubviews([
            self.phoneBookTitleLabel,
            self.phoneBookButton,
            self.noDataPhoneBookStackView,
            self.phoneBookCollectionView,
        ], to: self.phoneBookView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // scrollView
        NSLayoutConstraint.activate([
            self.scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.baseView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
        ])
        
        // noticeView
        NSLayoutConstraint.activate([
            self.noticeView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.noticeView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.noticeView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 16),
            self.noticeView.heightAnchor.constraint(equalToConstant: 46),
        ])
        
        // noticeTitleLabel
        NSLayoutConstraint.activate([
            self.noticeTitleLabel.leadingAnchor.constraint(equalTo: self.noticeView.leadingAnchor, constant: 12),
            self.noticeTitleLabel.centerYAnchor.constraint(equalTo: self.noticeView.centerYAnchor),
        ])
        
        // noticeArrowImageView
        NSLayoutConstraint.activate([
            self.noticeArrowImageView.centerYAnchor.constraint(equalTo: self.noticeView.centerYAnchor),
            self.noticeArrowImageView.trailingAnchor.constraint(equalTo: self.noticeView.trailingAnchor, constant: -12),
            self.noticeArrowImageView.widthAnchor.constraint(equalToConstant: 20),
            self.noticeArrowImageView.heightAnchor.constraint(equalToConstant: 20),
        ])
        
        // noticeButton
        NSLayoutConstraint.activate([
            self.noticeButton.leadingAnchor.constraint(equalTo: self.noticeView.leadingAnchor),
            self.noticeButton.trailingAnchor.constraint(equalTo: self.noticeView.trailingAnchor),
            self.noticeButton.topAnchor.constraint(equalTo: self.noticeView.topAnchor),
            self.noticeButton.bottomAnchor.constraint(equalTo: self.noticeView.bottomAnchor),
        ])
        
        // mainOfficeByRoleView
        NSLayoutConstraint.activate([
            self.mainOfficeByRoleView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.mainOfficeByRoleView.topAnchor.constraint(equalTo: self.noticeView.bottomAnchor, constant: 24),
            self.mainOfficeByRoleView.heightAnchor.constraint(equalToConstant: 218),
            self.mainOfficeByRoleView.widthAnchor.constraint(equalToConstant: 180),
        ])
        
        // mainOfficeByRoleImageView
        NSLayoutConstraint.activate([
            self.mainOfficeByRoleImageView.leadingAnchor.constraint(equalTo: self.mainOfficeByRoleView.leadingAnchor),
            self.mainOfficeByRoleImageView.trailingAnchor.constraint(equalTo: self.mainOfficeByRoleView.trailingAnchor),
            self.mainOfficeByRoleImageView.topAnchor.constraint(equalTo: self.mainOfficeByRoleView.topAnchor),
            self.mainOfficeByRoleImageView.bottomAnchor.constraint(equalTo: self.mainOfficeByRoleView.bottomAnchor),
        ])
        
        // mainOfficeByRoleLabel
        NSLayoutConstraint.activate([
            self.mainOfficeByRoleLabel.leadingAnchor.constraint(equalTo: self.mainOfficeByRoleView.leadingAnchor, constant: 20),
            self.mainOfficeByRoleLabel.topAnchor.constraint(equalTo: self.mainOfficeByRoleView.topAnchor, constant: 16),
        ])
        
        // mainOfficeByRoleButton
        NSLayoutConstraint.activate([
            self.mainOfficeByRoleButton.leadingAnchor.constraint(equalTo: self.mainOfficeByRoleView.leadingAnchor),
            self.mainOfficeByRoleButton.trailingAnchor.constraint(equalTo: self.mainOfficeByRoleView.trailingAnchor),
            self.mainOfficeByRoleButton.topAnchor.constraint(equalTo: self.mainOfficeByRoleView.topAnchor),
            self.mainOfficeByRoleButton.bottomAnchor.constraint(equalTo: self.mainOfficeByRoleView.bottomAnchor),
        ])
        
        // subMainOfficeOneByRoleView
        NSLayoutConstraint.activate([
            self.subMainOfficeOneByRoleView.leadingAnchor.constraint(equalTo: self.mainOfficeByRoleView.trailingAnchor, constant: 12),
            self.subMainOfficeOneByRoleView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.subMainOfficeOneByRoleView.topAnchor.constraint(equalTo: self.noticeView.bottomAnchor, constant: 24),
            self.subMainOfficeOneByRoleView.heightAnchor.constraint(equalToConstant: 103),
        ])
        
        // subMainOfficeOneByRoleButton
        NSLayoutConstraint.activate([
            self.subMainOfficeOneByRoleButton.leadingAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.leadingAnchor),
            self.subMainOfficeOneByRoleButton.trailingAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.trailingAnchor),
            self.subMainOfficeOneByRoleButton.topAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.topAnchor),
            self.subMainOfficeOneByRoleButton.bottomAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.bottomAnchor),
        ])
        
        // subMainOfficeOneByRoleImageView
        NSLayoutConstraint.activate([
            self.subMainOfficeOneByRoleImageView.widthAnchor.constraint(equalToConstant: 44),
            self.subMainOfficeOneByRoleImageView.heightAnchor.constraint(equalToConstant: 44),
            self.subMainOfficeOneByRoleImageView.trailingAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.trailingAnchor, constant: -8),
            self.subMainOfficeOneByRoleImageView.bottomAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.bottomAnchor, constant: -8),
        ])
        
        // subMainOfficeOneByRoleLabel
        NSLayoutConstraint.activate([
            self.subMainOfficeOneByRoleLabel.leadingAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.leadingAnchor, constant: 20),
            self.subMainOfficeOneByRoleLabel.topAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.topAnchor, constant: 16),
        ])
        
        // subMainOfficeTwoByRoleView
        NSLayoutConstraint.activate([
            self.subMainOfficeTwoByRoleView.leadingAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.leadingAnchor),
            self.subMainOfficeTwoByRoleView.trailingAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.trailingAnchor),
            self.subMainOfficeTwoByRoleView.topAnchor.constraint(equalTo: self.subMainOfficeOneByRoleView.bottomAnchor, constant: 12),
            self.subMainOfficeTwoByRoleView.heightAnchor.constraint(equalToConstant: 103),
        ])
        
        // subMainOfficeTwoByRoleImageView
        NSLayoutConstraint.activate([
            self.subMainOfficeTwoByRoleImageView.widthAnchor.constraint(equalToConstant: 44),
            self.subMainOfficeTwoByRoleImageView.heightAnchor.constraint(equalToConstant: 44),
            self.subMainOfficeTwoByRoleImageView.trailingAnchor.constraint(equalTo: self.subMainOfficeTwoByRoleView.trailingAnchor, constant: -8),
            self.subMainOfficeTwoByRoleImageView.bottomAnchor.constraint(equalTo: self.subMainOfficeTwoByRoleView.bottomAnchor, constant: -8),
        ])
        
        // subMainOfficeTwoByRoleLabel
        NSLayoutConstraint.activate([
            self.subMainOfficeTwoByRoleLabel.leadingAnchor.constraint(equalTo: self.subMainOfficeTwoByRoleView.leadingAnchor, constant: 20),
            self.subMainOfficeTwoByRoleLabel.topAnchor.constraint(equalTo: self.subMainOfficeTwoByRoleView.topAnchor, constant: 16),
        ])
        
        // subMainOfficeTwoByRoleButton
        NSLayoutConstraint.activate([
            self.subMainOfficeTwoByRoleButton.leadingAnchor.constraint(equalTo: self.subMainOfficeTwoByRoleView.leadingAnchor),
            self.subMainOfficeTwoByRoleButton.trailingAnchor.constraint(equalTo: self.subMainOfficeTwoByRoleView.trailingAnchor),
            self.subMainOfficeTwoByRoleButton.topAnchor.constraint(equalTo: self.subMainOfficeTwoByRoleView.topAnchor),
            self.subMainOfficeTwoByRoleButton.bottomAnchor.constraint(equalTo: self.subMainOfficeTwoByRoleView.bottomAnchor),
        ])
        
        // otherTasksView
        NSLayoutConstraint.activate([
            self.otherTasksView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.otherTasksView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.otherTasksView.topAnchor.constraint(equalTo: self.mainOfficeByRoleView.bottomAnchor, constant: 24),
            self.otherTasksView.heightAnchor.constraint(equalToConstant: 165),
        ])
        
        // otherTasksTitleLabel
        NSLayoutConstraint.activate([
            self.otherTasksTitleLabel.leadingAnchor.constraint(equalTo: self.otherTasksView.leadingAnchor, constant: 20),
            self.otherTasksTitleLabel.topAnchor.constraint(equalTo: self.otherTasksView.topAnchor, constant: 16),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.otherTasksView.leadingAnchor, constant: 20),
            self.collectionView.trailingAnchor.constraint(equalTo: self.otherTasksView.trailingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.otherTasksTitleLabel.bottomAnchor, constant: 16),
            self.collectionView.bottomAnchor.constraint(equalTo: self.otherTasksView.bottomAnchor, constant: -18),
            self.collectionView.heightAnchor.constraint(equalToConstant: 89),
        ])
        
        // phoneBookView
        NSLayoutConstraint.activate([
            self.phoneBookView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.phoneBookView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.phoneBookView.topAnchor.constraint(equalTo: self.otherTasksView.bottomAnchor, constant: 24),
            self.phoneBookView.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -30),
            self.phoneBookView.heightAnchor.constraint(equalToConstant: 155),
        ])
        
        // phoneBookTitleLabel
        NSLayoutConstraint.activate([
            self.phoneBookTitleLabel.leadingAnchor.constraint(equalTo: self.phoneBookView.leadingAnchor),
            self.phoneBookTitleLabel.topAnchor.constraint(equalTo: self.phoneBookView.topAnchor),
        ])
        
        // phoneBookButton
        NSLayoutConstraint.activate([
            self.phoneBookButton.trailingAnchor.constraint(equalTo: self.phoneBookView.trailingAnchor, constant: -20),
            self.phoneBookButton.centerYAnchor.constraint(equalTo: self.phoneBookTitleLabel.centerYAnchor),
            self.phoneBookButton.heightAnchor.constraint(equalToConstant: 20),
            self.phoneBookButton.widthAnchor.constraint(equalToConstant: 72),
        ])
        
        // noDataPhoneBookStackView
        NSLayoutConstraint.activate([
            self.noDataPhoneBookStackView.leadingAnchor.constraint(equalTo: self.phoneBookView.leadingAnchor, constant: 20),
            self.noDataPhoneBookStackView.trailingAnchor.constraint(equalTo: self.phoneBookView.trailingAnchor, constant: -20),
            self.noDataPhoneBookStackView.topAnchor.constraint(equalTo: self.phoneBookTitleLabel.bottomAnchor, constant: 36),
        ])
        
        // moveToPhoneBookButton
        NSLayoutConstraint.activate([
            self.moveToPhoneBookButton.heightAnchor.constraint(equalToConstant: 36),
            self.moveToPhoneBookButton.widthAnchor.constraint(equalToConstant: 92),
        ])
        
        // phoneBookCollectionView
        NSLayoutConstraint.activate([
            self.phoneBookCollectionView.leadingAnchor.constraint(equalTo: self.phoneBookView.leadingAnchor, constant: 20),
            self.phoneBookCollectionView.trailingAnchor.constraint(equalTo: self.phoneBookView.trailingAnchor),
            self.phoneBookCollectionView.topAnchor.constraint(equalTo: self.phoneBookTitleLabel.bottomAnchor, constant: 12),
            self.phoneBookCollectionView.bottomAnchor.constraint(equalTo: self.phoneBookView.bottomAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .clear // Navigation bar is transparent and root view appears on it.
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 18, weight: .Bold)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = ""
        
        let leftBarButtonItem = UIBarButtonItem(title: "사무", style: .plain, target: self, action: nil)
        leftBarButtonItem.setTitleTextAttributes([
            .font:UIFont.useFont(ofSize: 20, weight: .Bold),
            .foregroundColor: UIColor.useRGB(red: 46, green: 45, blue: 45)
        ], for: .normal)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }
    
    func setData() {
        switch self.role {
        case .driver:
            self.mainOfficeByRoleImageView.image = .useCustomImage("pathKnowImage")
            self.mainOfficeByRoleLabel.text = "노선숙지"
            
            self.subMainOfficeOneByRoleImageView.image = .useCustomImage("complaints")
            self.subMainOfficeOneByRoleLabel.text = "민원"
            
            self.subMainOfficeTwoByRoleImageView.image = .useCustomImage("fuel")
            self.subMainOfficeTwoByRoleLabel.text = "주유"
            break
            
        case .driverLeader:
            // FIXME: 임시
            self.mainOfficeByRoleImageView.image = .useCustomImage("pathKnowImage")
            self.mainOfficeByRoleLabel.text = "노선숙지"
            
            self.subMainOfficeOneByRoleImageView.image = .useCustomImage("complaints")
            self.subMainOfficeOneByRoleLabel.text = "민원"
            
            self.subMainOfficeTwoByRoleImageView.image = .useCustomImage("fuel")
            self.subMainOfficeTwoByRoleLabel.text = "주유"
            break
            
        case .manager:
            // FIXME: 임시
            self.mainOfficeByRoleImageView.image = .useCustomImage("pathKnowImage")
            self.mainOfficeByRoleLabel.text = "노선숙지"
            
            self.subMainOfficeOneByRoleImageView.image = .useCustomImage("complaints")
            self.subMainOfficeOneByRoleLabel.text = "민원"
            
            self.subMainOfficeTwoByRoleImageView.image = .useCustomImage("fuel")
            self.subMainOfficeTwoByRoleLabel.text = "주유"
            break
            
        }
        
        // FIXME: 전화번호 최근 내역 불러오기
        if self.phoneBookList.isEmpty {
            self.noDataPhoneBookStackView.isHidden = false
            self.phoneBookCollectionView.isHidden = true
            
        } else {
            self.noDataPhoneBookStackView.isHidden = true
            self.phoneBookCollectionView.isHidden = false
            
            self.phoneBookCollectionView.reloadData()
            
        }
        
    }
    
}

// MARK: - Extension for methods added
extension OfficeViewController {
    
}

// MARK: - Extension for selector methods
extension OfficeViewController {
    @objc func noticeButton(_ sender: UIButton) {
        print("noticeButton")
        
    }
    
    @objc func mainOfficeByRoleButton(_ sender: UIButton) {
        print("mainOfficeByRoleButton")
        switch self.role {
        case .driver:
            let vc = RouteViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .driverLeader:
            // FIXME: 임시
            let vc = RouteViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .manager:
            // FIXME: 임시
            let vc = RouteViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }

    @objc func subMainOfficeOneByRoleButton(_ sender: UIButton) {
        print("subMainOfficeOneByRoleButton")
        
    }
    
    @objc func subMainOfficeTwoByRoleButton(_ sender: UIButton) {
        print("subMainOfficeTwoByRoleButton")
        
    }
    
    @objc func phoneBookButton(_ sender: UIButton) {
        print("phoneBookButton")
    }
    
    @objc func moveToPhoneBookButton(_ sender: UIButton) {
        print("moveToPhoneBookButton")
        
    }
    
}

extension OfficeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return self.tasksList.count
            
        } else {
            return self.phoneBookList.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherTasksCollectionViewCell", for: indexPath) as! OtherTasksCollectionViewCell
            let task = self.tasksList[indexPath.row]
            
            cell.setCell(task: task)
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhoneBookCollectionViewCell", for: indexPath) as! PhoneBookCollectionViewCell
            let phone = self.phoneBookList[indexPath.row]
            
            cell.setCell(phone: phone)
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let phone = self.phoneBookList[indexPath.row]
        if let url = URL(string: "tel://\(phone.phoneNum)") {
            UIApplication.shared.open(url)
            
        }
    }
    
}

// MARK: - Extension for UIGestureRecognizerDelegate
extension OfficeViewController: UIGestureRecognizerDelegate {
    // For swipe gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // For swipe gesture, prevent working on the root view of navigation controller
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.navigationController!.viewControllers.count > 1 ? true : false
    }
    
}
