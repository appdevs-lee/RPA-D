//
//  DispatchRunningView.swift
//  RPA-D
//
//  Created by Awesomepia on 12/3/24.
//

import UIKit

class DispatchRunningView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchRunningTableViewCell.self, forCellReuseIdentifier: "DispatchRunningTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var arriveButton: PushButtonView = {
        let view = PushButtonView()
        view.arriveButton.addTarget(self, action: #selector(arriveButton(_:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var item: DispatchDetailItem
    
    init(item: DispatchDetailItem) {
        self.item = item
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 48))
        
        self.setSubViews()
        self.setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DispatchRunningView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.tableView,
            self.arriveButton,
        ], to: self)
    }
    
    func setLayouts() {
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.tableView.heightAnchor.constraint(equalToConstant: 92),
        ])
        
        // arriveButton
        NSLayoutConstraint.activate([
            self.arriveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.arriveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.arriveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
        ])
    }
    
}

// MARK: - Extension for methods added
extension DispatchRunningView {
    
}

// MARK: - Extension for selector added
extension DispatchRunningView {
    @objc func arriveButton(_ sender: UIButton) {
        SupportingMethods.shared.showAlertNoti(title: "아직 정류장에 도착하지 않았습니다. 도착 후, 눌러주세요.")
        
    }
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchRunningView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item.stations.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchRunningTableViewCell", for: indexPath) as! DispatchRunningTableViewCell
        let stationsList = self.item.stations
        let station = self.item.stations[indexPath.row]
        
        if indexPath.row == 0 {
            if station.arrivalTime != "" {
                cell.setCell(station: station, status: false)
                
            } else {
                cell.setCell(station: station, status: true)
                
            }
            
            
        } else if indexPath.row == stationsList.count - 1 {
            if stationsList[indexPath.row - 1].arrivalTime != "" && station.arrivalTime == "" {
                cell.setCell(station: station, status: true)
                
            } else {
                cell.setCell(station: station, status: false)
                
            }
            
        } else {
            if stationsList[indexPath.row - 1].arrivalTime != "" && stationsList[indexPath.row + 1].arrivalTime == "" {
                // 현재 가는 정류장
                cell.setCell(station: station, status: true)
                
            } else {
                cell.setCell(station: station, status: false)
                
            }
        }
        
        
        return cell
    }
}
