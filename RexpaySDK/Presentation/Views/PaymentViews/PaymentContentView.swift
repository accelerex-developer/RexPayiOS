//
//  PaymentContentView.swift
//  RexpaySDK
//
//  Created by Abdullah on 23/01/2024.
//

import Foundation
import UIKit


final class PaymentContentView: ScrollableView<ScrollViewContentSize>  {
    
   
    let priceLabel: Label = {
        let label = Label(text: "NGN 120,000", font: .poppinsBold(size: 23), textColor: .hex1A1A1A)
        return label
    }()
    
    let nameLabel: Label = {
        let label = Label(text: "Goyette and Sons", font: .poppinsRegular(size: 14), textColor: .hex9C9898)
        return label
    }()
    
    let headerLabel: Label = {
        let label = Label(text: "Please select your desired payment method to continue.", font: .poppinsRegular(size: 14), textColor: .hex1A1A1AWith72Alpha)
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .hexEDEDED
        view.layer.borderColor = UIColor.hexEDEDED.cgColor
        return view
    }()
    
    let paymentFooterView: PaymentFooterView = {
        let view = PaymentFooterView()
        return view
    }()
    
//    let accelerexLogoContainerView: UIView = {
//        let view = UIView()
//        return view
//    }()
//    
//    let accelerexLogoImgView: UIImageView = {
//        let img = UIImageView(image: UIImage(named: "Accelerex-logo-png", in: Bundle(for: PaymentContentView.self), with: nil))
//        img.contentMode = .scaleAspectFit
//        return img
//    }()
    
    let paymentChannelCell = String.init(describing: PaymentChannelCell.self)
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PaymentChannelCell.self, forCellReuseIdentifier: paymentChannelCell)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    
    var data: [PaymentChannelData] = PaymentChannelModel.getData()
    
    var didSelectAt: ((PaymentChannel) -> Void)?
    
    override func setup() {
        super.setup()
        container.addSubviews(priceLabel, nameLabel, dividerView, headerLabel, tableView)
        priceLabel.anchor(top: container.topAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 30, left: 20, bottom: 0, right: 20))

        nameLabel.anchor(top: priceLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 15, left: 20, bottom: 0, right: 20))

        dividerView.anchor(top: nameLabel.bottomAnchor, leading: container.leadingAnchor, trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 0.7))

        headerLabel.anchor(top: dividerView.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        
        
        tableView.anchor(top: headerLabel.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 180))
        
        
//        accelerexLogoContainerView.anchor(top: tableView.bottomAnchor, leading: container.leadingAnchor,trailing: container.trailingAnchor, margin: .init(top: 20, left: 20, bottom: 0, right: 20), size: .init(height: 55))
    
      

//        accelerexLogoContainerView.addSubview(accelerexLogoImgView)
//        accelerexLogoImgView.placeAtCenterOf(centerY: accelerexLogoContainerView.centerYAnchor, centerX: accelerexLogoContainerView.centerXAnchor)
        
        
//        addSubview(accelerexLogoContainerView)
//        accelerexLogoContainerView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .sides(20, 20), size: .init(height: 55))
//
//        accelerexLogoContainerView.addSubview(accelerexLogoImgView)
//        accelerexLogoImgView.placeAtCenterOf(centerY: accelerexLogoContainerView.centerYAnchor, centerX: accelerexLogoContainerView.centerXAnchor)
        
        addSubview(paymentFooterView)
        paymentFooterView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, margin: .sides(20, 20), size: .init(height: 55))
    }
}


extension PaymentContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: paymentChannelCell, for: indexPath) as! PaymentChannelCell
        cell.updateCell(with: data[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(55)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select item at \(indexPath.item)")
        switch indexPath.item {
        case 0:
            didSelectAt?(.payWithCard)
        case 1:
            didSelectAt?(.payWithUssd)
        case 2:
            didSelectAt?(.payWithBank)
        default:
            print("no payment channel for this")
        }
        
    }
}
