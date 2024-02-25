//
//  BankDropDownController.swift
//  RexpaySDK
//
//  Created by Abdullah on 01/02/2024.
//

import UIKit

final class BankDropDownController: UIViewController {
    
    var selectedBankHandler: ((Bank) -> ())?
    var dismisHandler: (() -> ())?
    
    let bankDropDownCell = String.init(describing: BankDropDownCell.self)
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BankDropDownCell.self, forCellReuseIdentifier: bankDropDownCell)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let headerLabel: Label = {
        let label = Label(text: "Bank names", font: .poppinsRegular(size: 14), textColor: .hex1A1A1AWith72Alpha)
        label.backgroundColor = .white
        return label
    }()

//    var banks: [Bank] = [
//        Bank(name: "ACCESS BANK", code: "044"),
//        Bank(name: "ECOBANK NIGERIA", code: "050"),
//        Bank(name: "FIDELITY BANK", code: "070"),
//        Bank(name: "FIRST BANK OF NIGEIRA", code: "011"),
//        Bank(name: "FIRST CITY MONUMENT BANK", code: "214")]
    
    var banks: [Bank] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view == view {
            dismiss(animated: true)
            dismisHandler?()
        }
    }
    
    func configureView() {
        view.addSubview(containerView)
        containerView.anchor(leading: view.leadingAnchor,bottom: view.bottomAnchor, trailing: view.trailingAnchor, size: .init(height: Constant.screenHeight * 0.4))
        
        containerView.addSubviews(headerLabel, tableView)
        headerLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, trailing: containerView.trailingAnchor, margin: .topLeftOnly(20, 15))
        
        tableView.anchor(top: headerLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, margin: .topOnly(20))
        
    }
}


extension BankDropDownController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bankDropDownCell, for: indexPath) as! BankDropDownCell
        cell.updateCell(with: banks[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(55)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select item at \(indexPath.item)")
        selectedBankHandler?(banks[indexPath.item])
        dismiss(animated: true)
    }
}

final class BankDropDownCell: BaseTableViewCell {
    
    let bankNameLabel: Label = {
        let label = Label(text: "BankName", font: .poppinsRegular(size: 14), textColor: .hex1A1A1A)
        return label
    }()
    
    override func setup() {
        super.setup()
        contentView.addSubview(bankNameLabel)
        bankNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .leftOnly(15))

    }
    
    func updateCell(with bank: Bank) {
        bankNameLabel.text = bank.name ?? "Not found"
    }
}

