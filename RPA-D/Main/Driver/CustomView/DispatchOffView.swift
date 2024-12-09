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
    var noteDataList: [(title: String, figure: String)] = [
        (title: "이동 거리", figure: ""),
        (title: "출발 계기판", figure: ""),
        (title: "도착 계기판", figure: ""),
        (title: "인원수", figure: ""),
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
            self.dispatchNoteTitleLabel.leadingAnchor.constraint(equalTo: self.dispatchNoteBaseView.leadingAnchor, constant: 24),
            self.dispatchNoteTitleLabel.topAnchor.constraint(equalTo: self.dispatchNoteBaseView.topAnchor, constant: 20),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.dispatchNoteBaseView.leadingAnchor, constant: 24),
            self.tableView.trailingAnchor.constraint(equalTo: self.dispatchNoteBaseView.trailingAnchor, constant: -24),
            self.tableView.topAnchor.constraint(equalTo: self.dispatchNoteTitleLabel.bottomAnchor, constant: 14),
            self.tableView.bottomAnchor.constraint(equalTo: self.dispatchNoteBaseView.bottomAnchor, constant: -14),
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
        self.loadDrivingHistoryRequest { item in
            if item.arrivalKM != "" {
                let distance = Int(item.arrivalKM)! - Int(item.departureKM)!
                self.noteDataList[0].figure = "\(distance.formatterStyle(.decimal)!)KM"
                self.noteDataList[1].figure = "\(Int(item.departureKM)!.formatterStyle(.decimal)!)"
                self.noteDataList[2].figure = "\(Int(item.arrivalKM)!.formatterStyle(.decimal)!)"
                self.noteDataList[3].figure = "\(item.passengerNum)명"
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }
}

// MARK: - Extension for methods added
extension DispatchOffView {
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
