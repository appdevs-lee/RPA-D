//
//  RouteDetailView.swift
//  RPA-D
//
//  Created by 이주성 on 12/17/24.
//

import UIKit

class RouteDetailView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RouteBasicInfoTableViewCell.self, forCellReuseIdentifier: "RouteBasicInfoTableViewCell")
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
    
    var item: RouteDetailItem
    var stationList: [StationInfo] = []
    
    init(item: RouteDetailItem) {
        self.item = item
        self.stationList = item.stations
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RouteDetailView {
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
}

// MARK: - Extension for methods added
extension DispatchDetailView {
    
}

// MARK: - Extension for selector added
extension DispatchDetailView {
    
}

// MARK: - Extension for selector added
extension RouteDetailView: UITableViewDelegate, UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "RouteBasicInfoTableViewCell", for: indexPath) as! RouteBasicInfoTableViewCell
            
            cell.setCell(item: self.item)
            
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
