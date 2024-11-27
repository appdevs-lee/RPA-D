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
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()
    
    var isRunning: Bool
    
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
        
    }
    
    func setNotificationCenters() {
        
    }
    
    func setSubviews() {
        SupportingMethods.shared.addSubviews([
            self.mapView,
        ], to: self.view)
    }
    
    func setLayouts() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // mapView
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: self.isRunning ? self.view.topAnchor : safeArea.topAnchor),
            self.mapView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 486 / 375)
        ])
    }
    
    func setViewAfterTransition() {
        //self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.tabBarController?.tabBar.isHidden = false
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
