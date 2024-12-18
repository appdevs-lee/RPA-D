//
//  ProblemDetailViewController.swift
//  RPA-D
//
//  Created by 이주성 on 12/17/24.
//

import UIKit
import MapKit

final class ProblemDetailViewController: UIViewController {
    
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
        button.isHidden = true
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
        button.isHidden = true
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
    
    lazy var problemDetailView: ProblemDetailView = {
        let view = ProblemDetailView(item: self.item)
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
    
    var item: ProblemDetailItem
    
    var bottomSheetViewHeightAnchorConstraint: NSLayoutConstraint!
    
    let detailBaseHeight: CGFloat = 142
    var detailMaxHeight: CGFloat = 609
    
    var isClose: Bool = false
    var allPathButtonTopAnchorConstraint: NSLayoutConstraint!
    
    init(item: ProblemDetailItem) {
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
extension ProblemDetailViewController: EssentialViewMethods {
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
            self.problemDetailView,
        ], to: self.contentBaseView)
        
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
            self.mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            self.mapView.heightAnchor.constraint(equalToConstant: ReferenceValues.Size.Device.width * 486 / 375)
            self.mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        
        // bottomSheetView
        self.bottomSheetViewHeightAnchorConstraint = self.bottomSheetView.heightAnchor.constraint(equalToConstant: self.detailBaseHeight)
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
        
        // dispatchDetailView
        NSLayoutConstraint.activate([
            self.problemDetailView.leadingAnchor.constraint(equalTo: self.contentBaseView.leadingAnchor),
            self.problemDetailView.trailingAnchor.constraint(equalTo: self.contentBaseView.trailingAnchor),
            self.problemDetailView.topAnchor.constraint(equalTo: self.contentBaseView.topAnchor),
            self.problemDetailView.bottomAnchor.constraint(equalTo: self.contentBaseView.bottomAnchor),
        ])
        
        // forScrollView
        NSLayoutConstraint.activate([
            self.forScrollView.leadingAnchor.constraint(equalTo: self.bottomSheetView.leadingAnchor),
            self.forScrollView.topAnchor.constraint(equalTo: self.bottomSheetView.topAnchor),
            self.forScrollView.trailingAnchor.constraint(equalTo: self.bottomSheetView.trailingAnchor),
            self.forScrollView.heightAnchor.constraint(equalToConstant: 70)
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
extension ProblemDetailViewController {
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
        
        guard annotations.count > 1 else { return }
               
        var zoomRect: MKMapRect = MKMapRect.null
        let padding: CGFloat = 50

        for annotation in annotations {
            let point = MKMapPoint(annotation.coordinate)
            let rect = MKMapRect(x: point.x, y: point.y, width: 0.1, height: 0.1)
                
            zoomRect = zoomRect.isNull ? rect : zoomRect.union(rect)
        }
               
        self.mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: padding, left: padding, bottom: padding + 150, right: padding), animated: true)
    }
    
    func reloadData() {
        
    }
    
    // MARK: API
    
    
}

// MARK: - Extension for selector methods
extension ProblemDetailViewController {
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
//        if self.item.maplink != "" {
//            guard let url = URL(string: self.item.maplink) else { return }
//            UIApplication.shared.open(url)
//        }
        
    }
    
}

// MARK: - Extension for MKMapViewDelegate
extension ProblemDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline else { return MKOverlayRenderer() }
        
        let renderer = MKPolylineRenderer(polyline: polyLine)
        
        renderer.strokeColor = .red
        renderer.lineWidth = 5.0
        renderer.alpha = 1.0
        
        return renderer
    }
}
