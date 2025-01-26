//
//  DispatchDetailViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 11/27/24.
//

import UIKit
import MapKit

// CustomAnnotation에 이미지 관련 프로퍼티 추가
class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var image: UIImage? // 커스텀 이미지를 위한 프로퍼티
    var width: Int?
    var height: Int?

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, image: UIImage? = nil, width: Int? = nil, height: Int? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.image = image
        self.width = width
        self.height = height
        super.init()
    }
}

final class DispatchDetailViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        if #available(iOS 16.0, *) {
            mapView.preferredConfiguration = MKStandardMapConfiguration()
        } else {
            mapView.mapType = .standard
        }
        mapView.setUserTrackingMode(.follow, animated: true)
        let center = CLLocationCoordinate2D(latitude: Double(self.item.stations.first!.latitude.trimmingCharacters(in: .whitespaces))!, longitude: Double(self.item.stations.first!.longitude.trimmingCharacters(in: .whitespaces))!)
        mapView.setRegion(MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200), animated: true)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()
    
    lazy var bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var kakaoMapButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("kakaoMap"), for: .normal)
//        button.setImage(.useCustomImage("highlightedKakaoMap"), for: .highlighted)
        button.addTarget(self, action: #selector(kakaoMapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var pathBackgroundView: UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.75)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var allPathButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage("path.all"), for: .normal)
        button.addTarget(self, action: #selector(allPathButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var allPathLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0.0
        label.text = "전체 노선"
        label.textColor = .white
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var partPathButton: UIButton = {
        let button = UIButton()
        button.isHidden = !self.isRunning
        button.setImage(.useCustomImage("path.part"), for: .normal)
        button.addTarget(self, action: #selector(partPathButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var partPathLabel: UILabel = {
        let label = UILabel()
        label.alpha = 0.0
        label.text = "다음 정류장"
        label.textColor = .white
        label.font = .useFont(ofSize: 14, weight: .Medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var contentBaseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var forScrollView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchDetailView: DispatchDetailView = {
        let view = DispatchDetailView(date: self.departureDate, item: self.item)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    lazy var dispatchRunningView: DispatchRunningView = {
        let view = DispatchRunningView(item: self.item)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .useRGB(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchNoteView: DispatchNoteView = {
        let view = DispatchNoteView()
        view.isHidden = true
        view.sendButton.addTarget(self, action: #selector(dispatchNoteSendButton(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var peopleCountView: DispatchPeopleCountView = {
        let view = DispatchPeopleCountView()
        view.isHidden = true
        view.previousButton.addTarget(self, action: #selector(previousButton(_:)), for: .touchUpInside)
        view.nextButton.addTarget(self, action: #selector(nextButton(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchOffView: DispatchOffView = {
        let view = DispatchOffView(item: self.item)
        view.isHidden = true
        view.dispatchOffButton.addTarget(self, action: #selector(dispatchOffButton(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var isRunning: Bool
    let dispatchModel = DispatchModel()
    var item: DispatchDetailItem
    var departureDate: String
    
    var bottomSheetViewHeightAnchorConstraint: NSLayoutConstraint!
    var dispatchNoteViewBottomAnchorConstraint: NSLayoutConstraint!
    var peopleCountViewBottomAnchorConstraint: NSLayoutConstraint!
    
    let detailBaseHeight: CGFloat = 160
    var detailMaxHeight: CGFloat = 609
    
    let runningBaseHeight: CGFloat = 328
    var runningMaxHeight: CGFloat = 548
    
    var isClose: Bool = false
    var allPathButtonTopAnchorConstraint: NSLayoutConstraint!
    var partPathButtonTopAnchorConstraint: NSLayoutConstraint!
    
    init(isRunning: Bool = false, item: DispatchDetailItem, departureDate: String) {
        self.isRunning = isRunning
        self.item = item
        self.departureDate = departureDate
        
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
        self.setAnnotation()
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
        print("----------------------------------- DispatchDetailViewController is disposed -----------------------------------")
    }
}

// MARK: Extension for essential methods
extension DispatchDetailViewController: EssentialViewMethods {
    func setViewFoundation() {
        
    }
    
    func initializeObjects() {
        
    }
    
    func setDelegates() {
        
    }
    
    func setGestures() {
        let bottomSheetPanGesture: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler(_:)))
        self.forScrollView.addGestureRecognizer(bottomSheetPanGesture)
        self.forScrollView.isUserInteractionEnabled = true
        
        let pathBackgroundOffGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedPathBackgroundView(_:)))
        self.pathBackgroundView.addGestureRecognizer(pathBackgroundOffGesture)
        self.pathBackgroundView.isUserInteractionEnabled = true
    }
    
    func setNotificationCenters() {
        NotificationCenter.default.addObserver(self, selector: #selector(stationCheck(_:)), name: Notification.Name("StationCheck"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.mapView,
            self.bottomSheetView,
            self.pathBackgroundView,
            self.allPathButton,
            self.allPathLabel,
            self.partPathButton,
            self.partPathLabel,
            self.kakaoMapButton,
            self.backgroundView,
            self.dispatchNoteView,
            self.peopleCountView,
            self.dispatchOffView,
        ], to: self.view)
        
        if !self.isRunning {
            SupportingMethods.shared.addSubviews([
                self.forScrollView,
            ], to: self.view)
            
            SupportingMethods.shared.addSubviews([
                self.dispatchDetailView,
            ], to: self.contentBaseView)
        } else {
            SupportingMethods.shared.addSubviews([
                self.dispatchRunningView,
            ], to: self.contentBaseView)
        }
        
        SupportingMethods.shared.addSubviews([
            self.contentBaseView,
        ], to: self.bottomSheetView)
        
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // mapView
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: self.isRunning ? self.view.topAnchor : safeArea.topAnchor),
//            self.mapView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 486 / 375)
            self.mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // bottomSheetView
        self.bottomSheetViewHeightAnchorConstraint = self.bottomSheetView.heightAnchor.constraint(equalToConstant: self.isRunning ? self.runningBaseHeight : detailBaseHeight)
        NSLayoutConstraint.activate([
            self.bottomSheetView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.bottomSheetView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.bottomSheetViewHeightAnchorConstraint,
        ])
        
        // kakaoMapButton
        NSLayoutConstraint.activate([
            self.kakaoMapButton.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor),
            self.kakaoMapButton.bottomAnchor.constraint(equalTo: self.bottomSheetView.topAnchor),
            self.kakaoMapButton.heightAnchor.constraint(equalToConstant: 62),
            self.kakaoMapButton.widthAnchor.constraint(equalToConstant: 62),
        ])
        
        // contentBaseView
        NSLayoutConstraint.activate([
            self.contentBaseView.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor),
            self.contentBaseView.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor),
            self.contentBaseView.bottomAnchor.constraint(equalTo: self.bottomSheetView.bottomAnchor, constant: -10),
            self.contentBaseView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor),
        ])
        
        if !self.isRunning {
            // dispatchDetailView
            NSLayoutConstraint.activate([
                self.dispatchDetailView.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor),
                self.dispatchDetailView.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor),
                self.dispatchDetailView.topAnchor.constraint(equalTo: self.contentBaseView.topAnchor),
                self.dispatchDetailView.bottomAnchor.constraint(equalTo: self.contentBaseView.bottomAnchor),
            ])
            
            // forScrollView
            NSLayoutConstraint.activate([
                self.forScrollView.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor),
                self.forScrollView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor),
                self.forScrollView.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor),
                self.forScrollView.heightAnchor.constraint(equalToConstant: self.detailBaseHeight)
            ])
            
        } else {
            // dispatchRunningView
            NSLayoutConstraint.activate([
                self.dispatchRunningView.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor),
                self.dispatchRunningView.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor),
                self.dispatchRunningView.topAnchor.constraint(equalTo: self.contentBaseView.topAnchor),
                self.dispatchRunningView.bottomAnchor.constraint(equalTo: self.contentBaseView.bottomAnchor),
            ])
        }
        
        // backgroundView
        NSLayoutConstraint.activate([
            self.backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // dispatchNoteView
        self.dispatchNoteViewBottomAnchorConstraint = self.dispatchNoteView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate([
            self.dispatchNoteView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.dispatchNoteView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.dispatchNoteViewBottomAnchorConstraint,
        ])
        
        // peopleCountView
        self.peopleCountViewBottomAnchorConstraint = self.peopleCountView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        NSLayoutConstraint.activate([
            self.peopleCountView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.peopleCountView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.peopleCountViewBottomAnchorConstraint,
        ])
        
        // dispatchOffView
        NSLayoutConstraint.activate([
            self.dispatchOffView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.dispatchOffView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.dispatchOffView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.dispatchOffView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // pathBackgroundView
        NSLayoutConstraint.activate([
            self.pathBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pathBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.pathBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.pathBackgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        // allPathButton
        self.allPathButtonTopAnchorConstraint = self.allPathButton.topAnchor.constraint(equalTo: self.kakaoMapButton.topAnchor)
        NSLayoutConstraint.activate([
            self.allPathButtonTopAnchorConstraint,
            self.allPathButton.trailingAnchor.constraint(equalTo: self.kakaoMapButton.trailingAnchor),
            self.allPathButton.heightAnchor.constraint(equalToConstant: 62),
            self.allPathButton.widthAnchor.constraint(equalToConstant: 62),
        ])
        
        // allPathLabel
        NSLayoutConstraint.activate([
            self.allPathLabel.trailingAnchor.constraint(equalTo: self.allPathButton.leadingAnchor),
            self.allPathLabel.centerYAnchor.constraint(equalTo: self.allPathButton.centerYAnchor),
        ])
        
        // partPathButton
        self.partPathButtonTopAnchorConstraint = self.partPathButton.topAnchor.constraint(equalTo: self.kakaoMapButton.topAnchor)
        NSLayoutConstraint.activate([
            self.partPathButtonTopAnchorConstraint,
            self.partPathButton.trailingAnchor.constraint(equalTo: self.kakaoMapButton.trailingAnchor),
            self.partPathButton.heightAnchor.constraint(equalToConstant: 62),
            self.partPathButton.widthAnchor.constraint(equalToConstant: 62),
        ])
        
        // partPathLabel
        NSLayoutConstraint.activate([
            self.partPathLabel.trailingAnchor.constraint(equalTo: self.partPathButton.leadingAnchor),
            self.partPathLabel.centerYAnchor.constraint(equalTo: self.partPathButton.centerYAnchor),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = self.isRunning ? .clear : .white // Navigation bar is transparent and root view appears on it.
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        if self.isRunning {
            self.navigationItem.title = ""
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton.running")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
            
        } else {
            self.navigationItem.title = "상세 배차"
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
            
        }
    }
    
    func setData() {
        if self.isRunning {
            if self.item.stations.filter({ $0.arrivalTime == "" }).isEmpty {
                // 정류장 처리는 완료
                // 운행 일보 체크
                self.loadDrivingHistoryRequest { item in
                    if item.arrivalKM == "" {
                        // 운행일보 on
                        self.backgroundView.isHidden = false
                        self.dispatchNoteView.isHidden = false
                        self.dispatchNoteView.dashboardTextField.becomeFirstResponder()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

// MARK: - Extension for methods added
extension DispatchDetailViewController {
    func drawLineOnMap() {
//        var points: [CLLocationCoordinate2D] = []
//        let locations = self.mapModel.read()
//        
//        for location in locations {
//            print("latitude: \(location.latitude)\nlongitude: \(location.longitude)")
//            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.latitude, location.longitude)
//            
//            points.append(point)
//        }
//        
//        let lineDraw = MKPolyline(coordinates: points, count:points.count)
//        self.mapView.addOverlay(lineDraw)
//        
//        for station in self.stations {
//            self.mapView.addAnnotation(station)
//            
//        }
        
    }
    
    func setAnnotation() {
        var points: [CLLocationCoordinate2D] = []
        var annotations: [MKAnnotation] = []
        
        // 각 정류장마다 어노테이션 생성
        for station in self.item.stations {
            let coordinate = CLLocationCoordinate2D(
                latitude: Double(station.latitude.trimmingCharacters(in: .whitespaces))!,
                longitude: Double(station.longitude.trimmingCharacters(in: .whitespaces))!
            )
            points.append(coordinate)
            
            // 정류장 타입에 따라 다른 이미지 설정
            var annotationImage: UIImage!
            var size: (width: Int, height: Int) = (0, 0)
            
            if self.item.stations.first?.id == station.id {
                annotationImage = UIImage(named: "departure.marker")
                size = (30, 30)
                
            } else if self.item.stations.last?.id == station.id {
                annotationImage = UIImage(named: "arrival.marker")
                size = (30, 30)
                
            } else {
                annotationImage = UIImage(named: "station.marker")
                size = (15, 15)
                
            }
            
            let annotation = CustomAnnotation(
                title: station.stationName,
                subtitle: station.stationType,
                coordinate: coordinate,
                image: annotationImage,
                width: size.width,
                height: size.height
            )
            annotations.append(annotation)
        }
        
        // 경로선 그리기
        let lineDraw = MKPolyline(coordinates: points, count: points.count)
        self.mapView.addOverlay(lineDraw)
        
        // 어노테이션 추가
        self.mapView.addAnnotations(annotations)
        
        // 모든 어노테이션이 보이도록 지도 영역 조정
        if !self.isRunning && annotations.count > 1 {
            self.adjustMapRegion(for: annotations)
        }
    }
    
    // 지도 영역 조정을 위한 헬퍼 메서드
    private func adjustMapRegion(for annotations: [MKAnnotation]) {
        var zoomRect: MKMapRect = .null
        let padding: CGFloat = 50
        
        for annotation in annotations {
            let point = MKMapPoint(annotation.coordinate)
            let rect = MKMapRect(x: point.x, y: point.y, width: 0.1, height: 0.1)
            zoomRect = zoomRect.isNull ? rect : zoomRect.union(rect)
        }
        
        self.mapView.setVisibleMapRect(
            zoomRect,
            edgePadding: UIEdgeInsets(top: padding, left: padding, bottom: padding + 150, right: padding),
            animated: true
        )
    }
    
    func reloadData() {
        SupportingMethods.shared.turnCoverView(.on)
        self.loadDispatchDailyDetailRequest { item in
            if self.isRunning {
                self.dispatchRunningView.item = item
                self.dispatchRunningView.setData()
                
            }
            SupportingMethods.shared.turnCoverView(.off)
            
        }
        
    }
    
    // MARK: API
    func loadDispatchDailyDetailRequest(success: ((DispatchDetailItem) -> ())?) {
        self.dispatchModel.loadDispatchDailyDetailRequest(id: self.item.id, workType: self.item.workType) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDispatchDailyDetailRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func updateDrivingHistoryRequest(id: Int, workType: String, arrivalKM: String = "", passengerNum: Int = 0, success: (() -> ())?) {
        self.dispatchModel.updateDrivingHistoryRequest(id: id, workType: workType, arrivalKM: arrivalKM, passengerNum: passengerNum) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("updateDrivingHistoryRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func loadDrivingHistoryRequest(success: ((DrivingHistoryItem) -> ())?) {
        self.dispatchModel.loadDrivingHistoryRequest(id: self.item.id, workType: self.item.workType) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDrivingHistoryRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    
    func sendDispatchInfoUpdateRequest(id: Int, workType: String, type: String, time: String, success: (() -> ())?) {
        self.dispatchModel.sendDispatchInfoUpdateRequest(id: id, workType: workType, type: type, time: time) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendDispatchInfoUpdateRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension DispatchDetailViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func panGestureHandler(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.bottomSheetView)
        let height: CGFloat = self.bottomSheetView.frame.size.height
        
        if gesture.state == .ended {
            if self.detailMaxHeight < height || self.detailMaxHeight - 200 < height {
//                self.dispatchDetailView.isUserInteractionEnabled = true
                UIView.transition(with: self.bottomSheetView, duration: 0.5) {
                    self.bottomSheetViewHeightAnchorConstraint.constant = self.isRunning ? self.runningMaxHeight : self.detailMaxHeight
                    self.view.layoutIfNeeded()
                    
                }
                
            } else {
//                self.dispatchDetailView.isUserInteractionEnabled = false
                UIView.transition(with: self.bottomSheetView, duration: 0.5) {
                    self.bottomSheetViewHeightAnchorConstraint.constant = self.isRunning ? self.runningBaseHeight : self.detailBaseHeight
                    self.view.layoutIfNeeded()
                    
                }
                
            }
            
            
        } else {
            self.bottomSheetViewHeightAnchorConstraint.constant = height - translation.y
            UIView.animate(withDuration: 0) {
                self.bottomSheetView.layoutIfNeeded()
                
            }
            gesture.setTranslation(.zero, in: self.view)
            
        }
        
    }
    
    @objc func kakaoMapButton(_ sender: UIButton) {
        // FIXME: 애니메이션 테스트, 추후 지워야 함.
        if self.isClose {
            UIView.transition(with: self.kakaoMapButton, duration: 0.5, options: .transitionFlipFromLeft) {
                self.pathBackgroundView.alpha = 0.0
                self.kakaoMapButton.setImage(.useCustomImage("kakaoMap"), for: .normal)
                self.allPathButtonTopAnchorConstraint.constant = 0
                self.allPathLabel.alpha = 0.0
                if self.isRunning {
                    self.partPathButtonTopAnchorConstraint.constant = 0
                    self.partPathLabel.alpha = 0.0
                    
                }
                
                self.view.layoutIfNeeded()
            }
            
            self.isClose = false
            
        } else {
            UIView.transition(with: self.kakaoMapButton, duration: 0.5, options: .transitionFlipFromLeft) {
                self.pathBackgroundView.alpha = 1.0
                self.kakaoMapButton.setImage(.useCustomImage("path.close"), for: .normal)
                self.allPathButtonTopAnchorConstraint.constant = -52.5
                self.allPathLabel.alpha = 1.0
                if self.isRunning {
                    self.partPathButtonTopAnchorConstraint.constant = -101.5
                    self.partPathLabel.alpha = 1.0
                    
                }
                
                self.view.layoutIfNeeded()
            }
            
            self.isClose = true
            
        }
        
    }
    
    @objc func tappedPathBackgroundView(_ gesture: UITapGestureRecognizer) {
        UIView.transition(with: self.kakaoMapButton, duration: 0.5, options: .transitionFlipFromLeft) {
            self.pathBackgroundView.alpha = 0.0
            self.allPathLabel.alpha = 0.0
            self.kakaoMapButton.setImage(.useCustomImage("kakaoMap"), for: .normal)
            self.allPathButtonTopAnchorConstraint.constant = 0
            if self.isRunning {
                self.partPathButtonTopAnchorConstraint.constant = 0
                self.partPathLabel.alpha = 0.0
                
            }
            
            self.view.layoutIfNeeded()
        }
        
        self.isClose = false
        
    }
    
    @objc func partPathButton(_ sender: UIButton) {
//        var previousStation: StationInfo?
        var currentStation: StationInfo?
        for index in 0..<self.item.stations.count {
            if self.item.stations[index].arrivalTime == "" {
                currentStation = self.item.stations[index]
//                if index != 0 {
//                    previousStation = self.item.stations[index - 1]
//                    
//                } else {
//                    previousStation = nil
//                    
//                }
                
                break
            }
        }
        
        guard let currentStation = currentStation else { return }
        let userLocation = self.mapView.userLocation.coordinate
        
//        let previousLatitude = previousStation?.latitude ?? String(userLocation.latitude)
//        let previousLongitude = previousStation?.longitude ?? String(userLocation.longitude)
        
        let latitude = currentStation.latitude
        let longitude = currentStation.longitude
        
        // 현재 정류장에서 다음 정류장까지
//        let url = URL(string: "kakaomap://route?sp=\(previousLatitude),\(previousLongitude)&ep=\(latitude),\(longitude)&by=CAR")!
        // 내 위치에서 정류장까지
        let userLocationURL = URL(string: "kakaomap://route?sp=\(userLocation.latitude),\(userLocation.longitude)&ep=\(latitude),\(longitude)&by=CAR")!
        UIApplication.shared.open(userLocationURL)
        
    }
    
    @objc func allPathButton(_ sender: UIButton) {
        if self.item.maplink != "" {
            guard let url = URL(string: self.item.maplink) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    
    @objc func stationCheck(_ notification: Notification) {
        self.dispatchRunningView.sendStationCheckDataRequest { isLastStation in
            if isLastStation {
                self.backgroundView.isHidden = false
                self.dispatchNoteView.isHidden = false
                self.dispatchNoteView.dashboardTextField.becomeFirstResponder()
                
            } else {
                self.reloadData()
                
            }
            
        }
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                self.dispatchNoteViewBottomAnchorConstraint.constant = -keyboardSize.height
                self.peopleCountViewBottomAnchorConstraint.constant = -keyboardSize.height
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            
            UIView.animate(withDuration: duration) {
                self.backgroundView.isHidden = true
                self.dispatchNoteView.isHidden = true
                self.dispatchNoteViewBottomAnchorConstraint.constant = 0
                self.peopleCountViewBottomAnchorConstraint.constant = 0
                
                self.view.layoutIfNeeded()
                
            } completion: { finished in
                
            }
        }
    }
    
    @objc func dispatchNoteSendButton(_ sender: UIButton) {
        self.updateDrivingHistoryRequest(id: self.item.id, workType: self.item.workType, arrivalKM: self.dispatchNoteView.dashboardTextField.text!) {
            self.dispatchNoteView.dashboardTextField.resignFirstResponder()
            self.backgroundView.isHidden = true
            self.dispatchNoteView.isHidden = true
            self.setData()
            
            self.backgroundView.isHidden = false
            self.peopleCountView.isHidden = false
            self.peopleCountView.peopleCountTextField.becomeFirstResponder()
            
        }
        
    }
    
    @objc func previousButton(_ sender: UIButton) {
        self.peopleCountView.isHidden = true
        
        self.backgroundView.isHidden = false
        self.dispatchNoteView.isHidden = false
        self.dispatchNoteView.dashboardTextField.becomeFirstResponder()
    }
    
    @objc func nextButton(_ sender: UIButton) {
        self.updateDrivingHistoryRequest(id: self.item.id, workType: self.item.workType, passengerNum: Int(self.peopleCountView.peopleCountTextField.text ?? "0")!) {
            //FIXME: 운행일보 요약본 보여주기
            self.peopleCountView.peopleCountTextField.resignFirstResponder()
            SupportingMethods.shared.turnCoverView(.on)
            self.loadDrivingHistoryRequest { item in
                self.dispatchOffView.setData(item: item)
                self.dispatchOffView.isHidden = false
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
    }
    
    @objc func dispatchOffButton(_ sender: UIButton) {
        self.sendDispatchInfoUpdateRequest(id: self.item.id, workType: self.item.workType, type: "운행 종료", time: SupportingMethods.shared.convertDate(intoString: Date(), "HH:mm")) {
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: Notification.Name("ReloadAllData"), object: nil)
            
        }
        
    }
    
}

// MARK: - Extension for MKMapViewDelegate
extension DispatchDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        
        renderer.strokeColor = .useRGB(red: 130, green: 130, blue: 130)
        renderer.lineWidth = 5.0
        renderer.alpha = 1.0
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 현재 위치 표시는 기본 스타일 사용
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        // 커스텀 어노테이션 확인
        guard let customAnnotation = annotation as? CustomAnnotation else { return nil }
        
        // 어노테이션 뷰 재사용을 위한 식별자
        let identifier = "CustomAnnotation"
        
        // 재사용 가능한 어노테이션 뷰가 있는지 확인
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            // 새로운 어노테이션 뷰 생성
            annotationView = MKAnnotationView(annotation: customAnnotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true // 말풍선 표시 여부
        } else {
            annotationView?.annotation = customAnnotation
        }
        
        // 이미지 설정
        annotationView?.image = customAnnotation.image ?? UIImage(named: "station.marker")
        
        // 이미지 크기 조정이 필요한 경우
        annotationView?.frame.size = CGSize(width: customAnnotation.width ?? 30, height: customAnnotation.height ?? 30)
        
        return annotationView
        
    }
    
}
