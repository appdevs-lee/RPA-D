//
//  DispatchDetailViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 11/27/24.
//

import UIKit
import MapKit

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
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
//        mapView.isUserInteractionEnabled = false
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
        button.setImage(.useCustomImage("highlightedKakaoMap"), for: .highlighted)
        button.addTarget(self, action: #selector(kakaoMapButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var contentBaseView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var isRunning: Bool
    var bottomSheetViewHeightAnchorConstraint: NSLayoutConstraint!
    
    let detailBaseHeight: CGFloat = 115
    var detailMaxHeight: CGFloat = 609
    
    let runningBaseHeight: CGFloat = 328
    var runningMaxHeight: CGFloat = 548
    
    init(isRunning: Bool = false) {
        self.isRunning = isRunning
        
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
        self.bottomSheetView.addGestureRecognizer(bottomSheetPanGesture)
        self.bottomSheetView.isUserInteractionEnabled = true
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.mapView,
            self.bottomSheetView,
            self.kakaoMapButton,
        ], to: self.view)
        
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
            self.contentBaseView.bottomAnchor.constraint(equalTo: self.bottomSheetView.bottomAnchor),
            self.contentBaseView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor),
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
                UIView.transition(with: self.bottomSheetView, duration: 0.5) {
                    self.bottomSheetViewHeightAnchorConstraint.constant = self.isRunning ? self.runningMaxHeight : self.detailMaxHeight
                    self.view.layoutIfNeeded()
                    
                }
                
            } else {
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
        print("kakaoMapButton")
        
    }
    
}

// MARK: - Extension for MKMapViewDelegate
extension DispatchDetailViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
//        
//        let renderer = MKPolylineRenderer(polyline: polyLine)
//        
//        renderer.strokeColor = .red
//        renderer.lineWidth = 5.0
//        renderer.alpha = 1.0
//        
//        return renderer
//    }
}
