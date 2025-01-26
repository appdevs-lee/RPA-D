//
//  ProblemDetailView.swift
//  RPA-D
//
//  Created by 이주성 on 12/17/24.
//

import UIKit

class ProblemDetailView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ProblemBasicInfoTableViewCell.self, forCellReuseIdentifier: "ProblemBasicInfoTableViewCell")
        tableView.register(StationDetailInfoTableViewCell.self, forCellReuseIdentifier: "StationDetailInfoTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tableView.layer.cornerRadius = 24
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    var item: ProblemDetailItem
    var stationList: [StationInfo] = []
    
    init(item: ProblemDetailItem) {
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

extension ProblemDetailView {
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
extension ProblemDetailView {
    
}

// MARK: - Extension for selector added
extension ProblemDetailView {
    
}

// MARK: - Extension for selector added
extension ProblemDetailView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
            
        } else {
            return self.stationList.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProblemBasicInfoTableViewCell", for: indexPath) as! ProblemBasicInfoTableViewCell
            
            cell.setCell(item: self.item)
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StationDetailInfoTableViewCell", for: indexPath) as! StationDetailInfoTableViewCell
            let station = self.stationList[indexPath.row]
            
            cell.setCell(station: station, index: indexPath.row, lastIndex: self.stationList.count - 1)
            
            return cell
            
        }
        
    }
}
