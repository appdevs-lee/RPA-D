//
//  RefusalReasonViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/8/24.
//

import UIKit

final class RefusalReasonViewController: UIViewController {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var selectReasonTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 불가 사유를 선택해 주세요"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 20, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (ReferenceValues.Size.Device.width - 48) * 0.5 , height: (ReferenceValues.Size.Device.width - 48) * 0.5  * 204 / 163)
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.headerReferenceSize = .zero
        flowLayout.footerReferenceSize = .zero
        flowLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(RefusalReasonCollectionViewCell.self, forCellWithReuseIdentifier: "RefusalReasonCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.useRGB(red: 148, green: 147, blue: 147), for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.layer.cornerRadius = 8
        button.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        button.addTarget(self, action: #selector(nextButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var item: DispatchDailyItem
    var selectedIndex: Int? = nil
    let reasonList: [(title: String, imageName: String)] = [
        (title: "건강 이상", imageName: "reason.health"),
        (title: "경조사", imageName: "reason.familly"),
    ]
    
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
    
    deinit {
        print("----------------------------------- RefusalReasonViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension RefusalReasonViewController: EssentialViewMethods {
    func setViewFoundation() {
        
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
            self.baseView,
            self.nextButton,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.selectReasonTitleLabel,
            self.collectionView,
        ], to: self.baseView)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: -12),
        ])
        
        // selectReasonTitleLabel
        NSLayoutConstraint.activate([
            self.selectReasonTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.selectReasonTitleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 48),
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.collectionView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.collectionView.topAnchor.constraint(equalTo: self.selectReasonTitleLabel.bottomAnchor, constant: 20),
            self.collectionView.heightAnchor.constraint(equalToConstant: (ReferenceValues.Size.Device.width - 48) * 0.5 * 204 / 163),
        ])
        
        // nextButton
        NSLayoutConstraint.activate([
            self.nextButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            self.nextButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            self.nextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -22),
            self.nextButton.heightAnchor.constraint(equalToConstant: 52),
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
extension RefusalReasonViewController {
    
}

// MARK: - Extension for selector methods
extension RefusalReasonViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func nextButton(_ sender: UIButton) {
        let vc = RefusalSubmitViewController(item: self.item)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK: - Extension for
extension RefusalReasonViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reasonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RefusalReasonCollectionViewCell", for: indexPath) as! RefusalReasonCollectionViewCell
        let reason = self.reasonList[indexPath.row]
        
        cell.setCell(reason: reason)
        
        if self.selectedIndex == nil {
            cell.selectImageView.image = .useCustomImage("noSelectedReason")
            cell.reasonLabel.textColor = .useRGB(red: 46, green: 45, blue: 45)
            
        } else {
            cell.selectImageView.image = self.selectedIndex == indexPath.row ? .useCustomImage("selectedReason") : .useCustomImage("noSelectedReason")
            cell.reasonLabel.textColor = self.selectedIndex == indexPath.row ? .useRGB(red: 223, green: 52, blue: 52) : .useRGB(red: 196, green: 195, blue: 195)
            cell.baseView.layer.borderWidth = self.selectedIndex == indexPath.row ? 1.0 : 0.0
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        
        if self.selectedIndex != nil {
            self.nextButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.nextButton.setTitleColor(.white, for: .normal)
            self.nextButton.isEnabled = true
            
        }
        
        self.collectionView.reloadData()
    }
    
}
