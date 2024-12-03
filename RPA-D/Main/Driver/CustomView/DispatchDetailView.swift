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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var date: String
    var item: DispatchDetailItem
    var stationList: [StationInfo] = []
    
    init(date: String, item: DispatchDetailItem) {
        self.date = date
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
}

// MARK: - Extension for methods added
extension DispatchDetailView {
    
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
            
            cell.setCell(date: self.date, item: self.item)
            
            return cell
            
        } else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "StationDetailInfoTableViewCell", for: indexPath) as! StationDetailInfoTableViewCell
            let station = self.stationList[indexPath.row]
            
            cell.setCell(station: station)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchDetailReferencesTableViewCell", for: indexPath) as! DispatchDetailReferencesTableViewCell
            
            cell.setCell(references: self.item.references)
            
            return cell
            
        }
        
    }
}
