//
//  DispatchOffView.swift
//  RPA-D
//
//  Created by 이주성 on 12/9/24.
//

import UIKit

class DispatchOffView: UIView {
    
    lazy var baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchOffImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .useCustomImage("dispatchOffDetailMainImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 일보 작성이 완료됐습니다"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 24, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "작성된 운행 일보를 확인해 주세요"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 18, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchNoteBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .useRGB(red: 248, green: 248, blue: 248)
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var dispatchNoteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "운행 일보"
        label.textColor = .useRGB(red: 46, green: 45, blue: 45)
        label.font = .useFont(ofSize: 15, weight: .Bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var dispatchMoreInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "\(User.shared.name) | \(self.item.busNum)"
        label.textColor = .useRGB(red: 148, green: 147, blue: 147)
        label.font = .useFont(ofSize: 14, weight: .Regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.keyboardDismissMode = .onDrag
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DispatchOffTableViewCell.self, forCellReuseIdentifier: "DispatchOffTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderTopPadding = 0
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    lazy var dispatchOffButton: UIButton = {
        let button = UIButton()
        button.setTitle("운행 종료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.useRGB(red: 255, green: 255, blue: 255, alpha: 0.5), for: .highlighted)
        button.titleLabel?.font = .useFont(ofSize: 16, weight: .Bold)
        button.backgroundColor = .useRGB(red: 223, green: 52, blue: 52)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let dispatchModel = DispatchModel()
    var item: DispatchDetailItem
    var noteDataList: [(leftTitle: String, leftFigure: String, rightTitle: String, rightFigure: String)] = [
        (leftTitle: "출발 계기판", leftFigure: "", rightTitle: "도착 계기판", rightFigure: ""),
        (leftTitle: "예상 운행거리", leftFigure: "", rightTitle: "실제 운행거리", rightFigure: "")
    ]
    
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

extension DispatchOffView {
    func setSubViews() {
        SupportingMethods.shared.addSubviews([
            self.baseView,
        ], to: self)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchOffImageView,
            self.titleLabel,
            self.subTitleLabel,
            self.dispatchNoteBaseView,
            self.dispatchOffButton,
        ], to: self.baseView)
        
        SupportingMethods.shared.addSubviews([
            self.dispatchNoteTitleLabel,
            self.dispatchMoreInfoLabel,
            self.tableView,
        ], to: self.dispatchNoteBaseView)
    }
    
    func setLayouts() {
        
        // baseView
        NSLayoutConstraint.activate([
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // dispatchOffImageView
        NSLayoutConstraint.activate([
            self.dispatchOffImageView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dispatchOffImageView.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 130),
        ])
        
        // titleLabel
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.titleLabel.topAnchor.constraint(equalTo: self.dispatchOffImageView.bottomAnchor, constant: 20),
        ])
        
        // subTitleLabel
        NSLayoutConstraint.activate([
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
        ])
        
        // dispatchNoteBaseView
        NSLayoutConstraint.activate([
            self.dispatchNoteBaseView.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dispatchNoteBaseView.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.dispatchNoteBaseView.topAnchor.constraint(equalTo: self.subTitleLabel.bottomAnchor, constant: 20),
            self.dispatchNoteBaseView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // dispatchNoteTitleLabel
        NSLayoutConstraint.activate([
            self.dispatchNoteTitleLabel.leadingAnchor.constraint(equalTo: self.dispatchNoteBaseView.leadingAnchor, constant: 20),
            self.dispatchNoteTitleLabel.topAnchor.constraint(equalTo: self.dispatchNoteBaseView.topAnchor, constant: 20),
        ])
        
        // dispatchMoreInfoLabel
        NSLayoutConstraint.activate([
            self.dispatchMoreInfoLabel.trailingAnchor.constraint(equalTo: self.dispatchNoteBaseView.trailingAnchor, constant: -20),
            self.dispatchMoreInfoLabel.centerYAnchor.constraint(equalTo: self.dispatchNoteTitleLabel.centerYAnchor),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.dispatchNoteBaseView.leadingAnchor, constant: 20),
            self.tableView.trailingAnchor.constraint(equalTo: self.dispatchNoteBaseView.trailingAnchor, constant: -20),
            self.tableView.topAnchor.constraint(equalTo: self.dispatchNoteTitleLabel.bottomAnchor, constant: 10),
            self.tableView.bottomAnchor.constraint(equalTo: self.dispatchNoteBaseView.bottomAnchor, constant: -10),
        ])
        
        // dispatchOffButton
        NSLayoutConstraint.activate([
            self.dispatchOffButton.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor, constant: 20),
            self.dispatchOffButton.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor, constant: -20),
            self.dispatchOffButton.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor, constant: -52),
            self.dispatchOffButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }
    
    func setData(item: DrivingHistoryItem) {
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
            self.loadDrivingHistoryRequest { item in
                if item.arrivalKM != "" {
                    let realDistance = Int(item.arrivalKM)! - Int(item.departureKM)!
                    self.noteDataList[0].leftFigure = "\(Int(item.departureKM)!.formatterStyle(.decimal)!)"
                    self.noteDataList[0].rightFigure = "\(Int(item.arrivalKM)!.formatterStyle(.decimal)!)"
                    self.noteDataList[1].leftFigure = "\(distance / 1000)KM"
                    self.noteDataList[1].rightFigure = "\(realDistance)KM"
                    
                }
                
                self.tableView.reloadData()
                
            }
            
        }
        
    }
}

// MARK: - Extension for methods added
extension DispatchOffView {
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
    
    func loadDrivingHistoryRequest(success: ((DrivingHistoryItem) -> ())?) {
        self.dispatchModel.loadDrivingHistoryRequest(id: self.item.id, workType: self.item.workType) { item in
            success?(item)
            
        } failure: { message in
            SupportingMethods.shared.checkExpiration {
                print("loadDrivingHistoryRequest API Error: \(message)")
                SupportingMethods.shared.turnCoverView(.off)
                
            }
            
        }

    }
}

// MARK: - Extension for selector added
extension DispatchOffView {
    
}

// MARK: - Extension for UITableViewDelegate, UITableViewDataSource
extension DispatchOffView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noteDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DispatchOffTableViewCell", for: indexPath) as! DispatchOffTableViewCell
        let note = self.noteDataList[indexPath.row]
        
        cell.setCell(note: note)
        
        return cell
    }
}
