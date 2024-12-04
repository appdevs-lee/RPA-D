//
//  DispatchDetailViewController.swift
//  RPA-D
//
//  Created by Awesomepia on 11/27/24.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    @objc dynamic var coordinate: CLLocationCoordinate2D

    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
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
    
    var isRunning: Bool
    var item: DispatchDetailItem
    var departureDate: String
    
    var bottomSheetViewHeightAnchorConstraint: NSLayoutConstraint!
    
    let detailBaseHeight: CGFloat = 115
    var detailMaxHeight: CGFloat = 609
    
    let runningBaseHeight: CGFloat = 328
    var runningMaxHeight: CGFloat = 548
    
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
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.mapView,
            self.bottomSheetView,
            self.kakaoMapButton,
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
    
    func setAnnotation() {
        var points: [CLLocationCoordinate2D] = []
        var annotations: [MKAnnotation] = []
        for station in self.item.stations {
            points.append(CLLocationCoordinate2D(latitude: Double(station.latitude.trimmingCharacters(in: .whitespaces))!, longitude: Double(station.longitude.trimmingCharacters(in: .whitespaces))!))
            annotations.append(CustomAnnotation(title: station.stationName, subtitle: station.stationType, coordinate: CLLocationCoordinate2D(latitude: Double(station.latitude.trimmingCharacters(in: .whitespaces))!, longitude: Double(station.longitude.trimmingCharacters(in: .whitespaces))!)))
            
        }
        
        let lineDraw = MKPolyline(coordinates: points, count:points.count)
        self.mapView.addOverlay(lineDraw)
        
        self.mapView.addAnnotations(annotations)
        
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
        print("kakaoMapButton")
        if self.item.maplink != "" {
            guard let url = URL(string: self.item.maplink) else { return }
            UIApplication.shared.open(url)
        }
        
    }
    
}

// MARK: - Extension for MKMapViewDelegate
extension DispatchDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        
        renderer.strokeColor = .red
        renderer.lineWidth = 5.0
        renderer.alpha = 1.0
        
        return renderer
    }
}
