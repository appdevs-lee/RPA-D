//
//  DispatchDetailView.swift
//  RPA-D
//
//  Created by Awesomepia on 12/3/24.
//

import UIKit

class DispatchDetailView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchDetailIBaseInfoTableViewCell.self, forCellReuseIdentifier: "DispatchDetailIBaseInfoTableViewCell")
        tableView.register(StationDetailInfoTableViewCell.self, forCellReuseIdentifier: "StationDetailInfoTableViewCell")
        tableView.register(DispatchDetailReferencesTableViewCell.self, forCellReuseIdentifier: "DispatchDetailReferencesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.layer.cornerRadius = 24
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let dispatchModel = DispatchModel()
    
    var date: String
    var item: DispatchDetailItem
    var stationList: [StationInfo] = []
    var estimatedDistance: Int = 0
    var realDistance: Int = 0
    
    var isFuture: Bool = false
    
    init(date: String, item: DispatchDetailItem) {
        self.date = date
        self.item = item
        self.stationList = item.stations
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
        self.setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DispatchDetailView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.tableView,
        ], to: self)
    }
    
    func setLayouts() {
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        
    }
    
    func setData() {
        var locations: [CustomCoordinate] = []
        for station in self.item.stations {
            locations.append(CustomCoordinate(x: station.longitude, y: station.latitude))
            
        }
        
        guard let first = locations.first else { return }
        guard let last = locations.last else { return }
        
        locations.removeFirst()
        locations.removeLast()
        
        SupportingMethods.shared.turnCoverView(.on)
        self.searchDistanceRequest(origin: first, destination: last, wayPoints: locations) { distance in
            self.estimatedDistance = distance / 1000
            
            let date = SupportingMethods.shared.convertString(intoDate: self.date, "yyyy-MM-dd HH:mm")
            if SupportingMethods.shared.isEqualOrLaterThanTargetDate(targetDate: date) {
                print("오늘 혹은 과거")
                self.isFuture = false
                self.loadDrivingHistoryRequest { realDistance in
                    self.realDistance = realDistance
                    
                    self.tableView.reloadData()
                    SupportingMethods.shared.turnCoverView(.off)
                    
                }
                
            } else {
                print("미래")
                self.isFuture = true
                self.tableView.reloadData()
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }
        
    }
}

// MARK: - Extension for methods added
extension DispatchDetailView {
    func searchDistanceRequest(origin: CustomCoordinate, destination: CustomCoordinate, wayPoints: [CustomCoordinate], success: ((_ distance: Int) -> ())?) {
        self.dispatchModel.searchDistanceRequest(origin: origin, destination: destination, wayPoints: wayPoints) { summary in
            success?(summary.distance ?? 0)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("searchDistanceRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        }

    }
    
    func loadDrivingHistoryRequest(success: ((_ realDistance: Int) -> ())?) {
        self.dispatchModel.loadDrivingHistoryRequest(id: self.item.id, workType: self.item.workType) { item in
            let realDistance = (Double(item.arrivalKM) ?? 0) - (Double(item.departureKM) ?? 0)
            success?(Int(realDistance))
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDrivingHistoryRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
        }

    }
    
}

// MARK: - Extension for selector added
extension DispatchDetailView {
    
}

// MARK: - Extension for selector added
extension DispatchDetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
            
        } else if section == 1 {
            return self.stationList.count
            
        } else {
            return 1
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDetailIBaseInfoTableViewCell", for: indexPath) as! DispatchDetailIBaseInfoTableViewCell
            
            cell.setCell(date: self.date, item: self.item, estimatedDistance: self.estimatedDistance, realDistance: self.realDistance, isFuture: self.isFuture)
            
            return cell
            
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "StationDetailInfoTableViewCell", for: indexPath) as! StationDetailInfoTableViewCell
            let station = self.stationList[indexPath.row]
            
            cell.setCell(station: station, index: indexPath.row, lastIndex: self.stationList.count - 1)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDetailReferencesTableViewCell", for: indexPath) as! DispatchDetailReferencesTableViewCell
            
            cell.setCell(references: self.item.references)
            
            return cell
            
        }
        
    }
}
