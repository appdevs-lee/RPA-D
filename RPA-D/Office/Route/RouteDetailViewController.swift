//
//  RouteDetailViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/17/24.
//

import UIKit
import MapKit

final class RouteDetailViewController: UIViewController {
    
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
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var routeDetailView: RouteDetailView = {
        let view = RouteDetailView(item: self.item)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 24
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
    
    lazy var buttonBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(.useCustomImage(self.item.favorite == "true" ? "detail.bookmark.yes" : "detail.bookmark.no"), for: .normal)
        button.addTarget(self, action: #selector(bookmarkButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var knowButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(knowButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        if self.item.know == "true" {
            button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            button.setTitle("숙지 취소", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
            button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .selected)
            
        } else {
            button.backgroundColor = .useRGB(red: 255, green: 245, blue: 245)
            button.setTitle("숙지 완료 하기", for: .normal)
            button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .normal)
            button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52, alpha: 0.5), for: .highlighted)
            button.setTitleColor(.useRGB(red: 223, green: 52, blue: 52, alpha: 0.5), for: .selected)
            
        }
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        
        return button
    }()
    
    let routeModel = RouteModel()
    var item: RouteDetailItem
    var id: Int
    
    var bottomSheetViewHeightAnchorConstraint: NSLayoutConstraint!
    
    let detailBaseHeight: CGFloat = 75
    var detailMaxHeight: CGFloat = 609
    
    var isClose: Bool = false
    var allPathButtonTopAnchorConstraint: NSLayoutConstraint!
    
    init(id: Int, item: RouteDetailItem) {
        self.id = id
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
extension RouteDetailViewController: EssentialViewMethods {
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
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.mapView,
            self.bottomSheetView,
            self.buttonBaseView,
            self.pathBackgroundView,
            self.allPathButton,
            self.allPathLabel,
            self.kakaoMapButton,
            self.backgroundView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.forScrollView,
        ], to: self.view)
        
        SupportingMethods.shared.addSubviews([
            self.routeDetailView,
        ], to: self.contentBaseView)
        
        SupportingMethods.shared.addSubviews([
            self.contentBaseView,
        ], to: self.bottomSheetView)
        
        SupportingMethods.shared.addSubviews([
            self.bookmarkButton,
            self.knowButton,
        ], to: self.buttonBaseView)
        
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // mapView
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            self.mapView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 486 / 375)
            self.mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // bottomSheetView
        self.bottomSheetViewHeightAnchorConstraint = self.bottomSheetView.heightAnchor.constraint(equalToConstant: self.detailBaseHeight)
        NSLayoutConstraint.activate([
            self.bottomSheetView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.bottomSheetView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.bottomSheetView.bottomAnchor.constraint(equalTo: self.buttonBaseView.topAnchor),
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
        
        // dispatchDetailView
        NSLayoutConstraint.activate([
            self.routeDetailView.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor),
            self.routeDetailView.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor),
            self.routeDetailView.topAnchor.constraint(equalTo: self.contentBaseView.topAnchor),
            self.routeDetailView.bottomAnchor.constraint(equalTo: self.contentBaseView.bottomAnchor),
        ])
        
        // forScrollView
        NSLayoutConstraint.activate([
            self.forScrollView.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor),
            self.forScrollView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor),
            self.forScrollView.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor),
            self.forScrollView.heightAnchor.constraint(equalToConstant: self.detailBaseHeight)
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
        
        // buttonBaseView
        NSLayoutConstraint.activate([
            self.buttonBaseView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.buttonBaseView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.buttonBaseView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        // bookmarkButton
        NSLayoutConstraint.activate([
            self.bookmarkButton.leadingAnchor.constraint(equalTo: self.buttonBaseView.leadingAnchor, constant: 20),
            self.bookmarkButton.topAnchor.constraint(equalTo: self.buttonBaseView.topAnchor, constant: 12),
            self.bookmarkButton.bottomAnchor.constraint(equalTo: self.buttonBaseView.bottomAnchor, constant: -12),
            self.bookmarkButton.widthAnchor.constraint(equalToConstant: 68),
            self.bookmarkButton.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        // knowButton
        NSLayoutConstraint.activate([
            self.knowButton.leadingAnchor.constraint(equalTo: self.bookmarkButton.trailingAnchor, constant: 8),
            self.knowButton.trailingAnchor.constraint(equalTo: self.buttonBaseView.trailingAnchor, constant: -20),
            self.knowButton.centerYAnchor.constraint(equalTo: self.bookmarkButton.centerYAnchor),
            self.knowButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setUpNavigationItem() {
        self.view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor:UIColor.useRGB(red: 66, green: 66, blue: 66),
            .font:UIFont.useFont(ofSize: 16, weight: .Medium)
        ]
        
        // MARK: NavigationItem appearance for each view controller
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        self.navigationItem.title = "노선 상세"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftBarButtonItem(_:)))
    }
    
    func setData() {
        
    }
    
}

// MARK: - Extension for methods added
extension RouteDetailViewController {
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
                annotationImage = UIImage(named: "station.marker.current")
                size = (25, 25)
                
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
        if annotations.count > 1 {
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
        
    }
    
    func reloadBookmark(bookmark: String) {
        self.bookmarkButton.setImage(.useCustomImage(bookmark == "true" ? "detail.bookmark.yes" : "detail.bookmark.no"), for: .normal)
        
    }
    
    func reloadKnow(know: String) {
        if know == "true" {
            self.knowButton.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
            self.knowButton.setTitle("숙지 취소", for: .normal)
            self.knowButton.setTitleColor(.white, for: .normal)
            self.knowButton.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
            self.knowButton.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .selected)
            
        } else {
            self.knowButton.backgroundColor = .useRGB(red: 255, green: 245, blue: 245)
            self.knowButton.setTitle("숙지 완료 하기", for: .normal)
            self.knowButton.setTitleColor(.useRGB(red: 223, green: 52, blue: 52), for: .normal)
            self.knowButton.setTitleColor(.useRGB(red: 223, green: 52, blue: 52, alpha: 0.5), for: .highlighted)
            self.knowButton.setTitleColor(.useRGB(red: 223, green: 52, blue: 52, alpha: 0.5), for: .selected)
            
        }
        
    }
    
    // MARK: API
    func sendRouteBookmarkDataRequest(id: Int, success: (() -> ())?) {
        self.routeModel.sendRouteBookmarkDataRequest(id: id) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendRouteBookmarkDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func deleteRouteBookmarkDataRequest(id: Int, success: (() -> ())?) {
        self.routeModel.deleteRouteBookmarkDataRequest(id: id) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("deleteRouteBookmarkDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }

    func sendRouteKnowDataRequest(id: Int, success: (() -> ())?) {
        self.routeModel.sendRouteKnowDataRequest(id: id) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("sendRouteKnowDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
    func deleteRouteKnowDataRequest(id: Int, success: (() -> ())?) {
        self.routeModel.deleteRouteKnowDataRequest(id: id) {
            success?()
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("deleteRouteKnowDataRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
    
}

// MARK: - Extension for selector methods
extension RouteDetailViewController {
    @objc func leftBarButtonItem(_ barButtonItem: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func panGestureHandler(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.bottomSheetView)
        let height: CGFloat = self.bottomSheetView.frame.size.height
        
        if gesture.state == .ended {
            if self.detailMaxHeight < height || self.detailMaxHeight - 200 < height {
                UIView.transition(with: self.bottomSheetView, duration: 0.5) {
                    self.bottomSheetViewHeightAnchorConstraint.constant = self.detailMaxHeight
                    self.view.layoutIfNeeded()
                    
                }
                
            } else {
                UIView.transition(with: self.bottomSheetView, duration: 0.5) {
                    self.bottomSheetViewHeightAnchorConstraint.constant = self.detailBaseHeight
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
                
                self.view.layoutIfNeeded()
            }
            
            self.isClose = false
            
        } else {
            UIView.transition(with: self.kakaoMapButton, duration: 0.5, options: .transitionFlipFromLeft) {
                self.pathBackgroundView.alpha = 1.0
                self.kakaoMapButton.setImage(.useCustomImage("path.close"), for: .normal)
                self.allPathButtonTopAnchorConstraint.constant = -52.5
                self.allPathLabel.alpha = 1.0
                
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
            
            self.view.layoutIfNeeded()
        }
        
        self.isClose = false
        
    }
    
    @objc func allPathButton(_ sender: UIButton) {
        if self.item.maplink != "" {
            guard let url = URL(string: self.item.maplink) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    
    @objc func bookmarkButton(_ sender: UIButton) {
        if self.item.favorite == "true" {
            // 현재 즐겨찾기 중
            self.deleteRouteBookmarkDataRequest(id: self.id) {
                self.item.favorite = "false"
                self.reloadBookmark(bookmark: self.item.favorite)
                
            }
            
        } else {
            self.sendRouteBookmarkDataRequest(id: self.id) {
                self.item.favorite = "true"
                self.reloadBookmark(bookmark: self.item.favorite)
                
            }
            
        }
        
    }
    
    @objc func knowButton(_ sender: UIButton) {
        if self.item.know == "true" {
            // 현재 즐겨찾기 중
            self.deleteRouteKnowDataRequest(id: self.id) {
                self.item.know = "false"
                self.reloadKnow(know: self.item.know)
                
            }
            
        } else {
            self.sendRouteKnowDataRequest(id: self.id) {
                self.item.know = "true"
                self.reloadKnow(know: self.item.know)
                
            }
            
        }
        
    }
    
}

// MARK: - Extension for MKMapViewDelegate
extension RouteDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        
//        renderer.strokeColor = .useRGB(red: 130, green: 130, blue: 130)
        renderer.strokeColor = .useRGB(red: 223, green: 52, blue: 52)
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
